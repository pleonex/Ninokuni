//
//  BackgroundImage.cs
//
//  Author:
//       Benito Palacios <benito356@gmail.com>
//
//  Copyright (c) 2015 Benito Palacios
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
using System.Drawing.Imaging;

namespace NinoPatcher
{
	public class BackgroundImage : AnimationElement
	{
		private Image image;

		public BackgroundImage(int delay, int duration, int steps, Point position, Image image)
			: base(delay, duration, steps, position)
		{
			this.image = image;
		}

		public override void Update()
		{
 		}

		public override void Draw(Graphics g)
		{
            // In Unix using DrawImage without ImageAttribute does only support pixels
            // with alpha value 0 or 255. It's a performance cost.
            ColorMatrix cm = new ColorMatrix();
            cm.Matrix33 = 1.0f;

            ImageAttributes ia = new ImageAttributes();
            ia.SetColorMatrix(cm);

            Rectangle outputRectangle = new Rectangle(Position, image.Size);
            g.DrawImage(image, outputRectangle, 0, 0, image.Width, image.Height,
                GraphicsUnit.Pixel, ia);
        }
	}
}

