//
//  Sprite.cs
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

namespace NinoPatcher
{
    public class Sprite : AnimationElement
    {
        private Size movement;
        private int changeFrequency;
        private Image[] images;

        private int currentIndex;
        private int count;

        public Sprite(int delay, int duration, int steps, Point position,
            Point endPosition, Size movement, int changeFrequency, params Image[] images)
			: base(delay, duration, steps, position)
        {
            EndPosition = endPosition;
            this.movement = movement;
            this.images = images;
            this.changeFrequency = changeFrequency;

            currentIndex = 0;
			count = 0;
        }

        public Point EndPosition {
            get;
            set;
        }

        public override void Update()
        {
            // Update frame
			if (count != 0 && (count % changeFrequency) == 0)
                currentIndex = (currentIndex + 1) % images.Length;
			count++;

            // Update position
            if ((EndPosition.X - Position.X >= movement.Width) &&
                (EndPosition.Y - Position.Y >= movement.Height))
                Position = Point.Add(Position, movement);
        }

        public override void Draw(Graphics g)
        {
            Rectangle outputRectangle = new Rectangle(Position, images[currentIndex].Size);
            g.DrawImageUnscaled(images[currentIndex], outputRectangle);
        }
    }
}

