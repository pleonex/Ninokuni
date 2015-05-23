//
//  Animation.cs
//
//  Author:
//       Benito Palacios Sánchez <benito356@gmail.com>
//
//  Copyright (c) 2015 Benito Palacios Sánchez
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Windows.Forms;

namespace NinoPatcher
{
    public sealed class Animation
    {
		private static volatile Animation instance;
		private static object syncRoot = new Object();

		private readonly Dictionary<Control, List<AnimationElement>> elements;
        private Timer timer;

        private Animation()
        {
			elements = new Dictionary<Control, List<AnimationElement>>();
            timer = new Timer();
            timer.Tick += PaintFrame;
			timer.Enabled = false;
        }

		public static Animation Instance {
			get {
				if (instance == null) {
					lock (syncRoot) {
						if (instance == null)
							instance = new Animation();
					}
				}

				return instance;
			}
		}

		public int Interval {
			get { return timer.Interval; }
			set { timer.Interval = value; timer.Enabled = true; }
		}

		public void Add(Control parent, AnimationElement element)
		{
            lock (syncRoot) {
                if (!elements.ContainsKey(parent)) {
                    elements.Add(parent, new List<AnimationElement>());
                    parent.Paint += HandleControlPaint;
                }

                elements[parent].Add(element);
            }
		}

        public bool Contains(Control parent, AnimationElement element)
        {
            lock (syncRoot)
                return elements.ContainsKey(parent) && elements[parent].Contains(element);
        }

		public void Remove(Control parent, AnimationElement element)
		{
            lock (syncRoot) {
    			if (!elements.ContainsKey(parent))
    				throw new ArgumentException();

    			elements[parent].Remove(element);

                if (elements[parent].Count == 0) {
                    parent.Paint -= HandleControlPaint;
                    elements.Remove(parent);
                }
            }
		}

		private void HandleControlPaint(object sender, PaintEventArgs e)
		{
            lock (syncRoot)
                PaintControl((Control)sender, false);
		}

        private void PaintFrame(object sender, EventArgs e)
        {
            lock (syncRoot) {
                foreach (Control key in elements.Keys)
                    PaintControl(key, true);
            }
        }

		private void PaintControl(Control control, bool mustUpdate)
		{
            using (Bitmap bufImg = new Bitmap(control.Width, control.Height)) {
				using (Graphics g = Graphics.FromImage(bufImg)) {
                    ClearControl(control, g);

					// Draw animations
					foreach (AnimationElement el in elements[control]) {
						if (mustUpdate)
							UpdateElement(el);

                        if (IsEnabled(el))
                            el.Draw(g);
					}

					// Draw image
					control.CreateGraphics().DrawImageUnscaled(bufImg, Point.Empty);
				}
			}
		}

        private void ClearControl(Control control, Graphics g)
        {
            // If it has set a background image draw only it
            if (control.BackgroundImage != null)
                g.DrawImage(control.BackgroundImage, Point.Empty);
            else
                // Otherwise, draw background color
                g.FillRectangle(
                    new SolidBrush(control.BackColor),
                    new Rectangle(Point.Empty, control.Size));
        }

		private bool IsEnabled(AnimationElement element)
		{
			return (element.Delay == 0) && (element.Duration == -1 || element.Duration > 0);
		}

		private void UpdateElement(AnimationElement element)
		{
			// First check if in this tick we can update counters
			element.CurrentStep--;
			if (element.CurrentStep > 0)
				return;

			// And fill again step count
			element.CurrentStep = element.Steps;

			// Then waits for delay time
			if (element.Delay > 0) {
				element.Delay--;
				return;
			}

			// Checks for duration animation
			if (element.Duration == -1 || element.Duration > 0) {
				element.Duration = (element.Duration != -1) ? element.Duration - 1 : -1;
				element.Update();
			}
		}
    }
}

