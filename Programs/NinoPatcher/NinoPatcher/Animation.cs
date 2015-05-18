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
        private Timer timer;
        private Control parent;

        public Animation(int period, Control parent, params Stream[] images)
        {
            timer = new Timer();
            timer.Tick += PaintFrame;
            timer.Interval = period;
        }

        private void PaintFrame(object sender, EventArgs e)
        {
            Bitmap bufl = new Bitmap(parent.Width, parent.Height);
            using (Graphics g = Graphics.FromImage(bufl))
            {
                g.FillRectangle(Brushes.Black, new Rectangle(0, 0, parent.Width, parent.Height));
                //DrawItems(g);
                parent.CreateGraphics().DrawImageUnscaled(bufl, 0, 0);
            }
        }

        private void FadeImage(Graphics g, Image image, int x, int y, float alpha) {
            ColorMatrix cm = new ColorMatrix();
            cm.Matrix33 = alpha;

            ImageAttributes ia = new ImageAttributes();
            ia.SetColorMatrix(cm);

            Rectangle outputRectangle = new Rectangle(x, y, image.Width, image.Height);
            g.DrawImage(image,
                outputRectangle,
                0, 0, image.Width, image.Height,
                GraphicsUnit.Pixel, ia);
        }
    }
}

