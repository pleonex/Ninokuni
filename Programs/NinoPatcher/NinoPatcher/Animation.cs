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
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using System.Drawing.Imaging;

namespace NinoPatcher
{
    public class Animation
    {
        private Control parent;
        private AnimationElement[] elements;

        private Timer timer;
        private int tick;

        public Animation(int period, Control parent, params AnimationElement[] elements)
        {
            this.parent = parent;
            this.elements = elements;

            timer = new Timer();
            timer.Tick += PaintFrame;
            timer.Interval = period;
        }

        public void Start()
        {
            timer.Start();
            tick = 0;
        }

        public void Stop()
        {
            timer.Stop();
        }

        private void PaintFrame(object sender, EventArgs e)
        {
            Bitmap bufl = new Bitmap(parent.Width, parent.Height);
            using (Graphics g = Graphics.FromImage(bufl))
            {
                // Draw background color
                g.FillRectangle(
                    new SolidBrush(parent.BackColor),
                    new Rectangle(Point.Empty, parent.Size));

                // Draw animations
                foreach (AnimationElement el in elements)
                    el.Draw(g, tick);

                // Draw image
                parent.CreateGraphics().DrawImageUnscaled(bufl, Point.Empty);
            }

            tick++;
        }
    }
}

