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
        private Point endPosition;
        private Size movement;
        private float changeFrequency;
        private Image[] images;

        private int currentIndex;
        private int lastChangeTick;

        public Sprite(int startTick, int endTick, int steps, Point position,
            Point endPosition, Size movement, float changeFrequency, params Image[] images)
            : base(startTick, endTick, steps, position)
        {
            this.endPosition = endPosition;
            this.movement = movement;
            this.images = images;
            this.changeFrequency = changeFrequency;

            currentIndex = 0;
        }

        protected override void Update(int tick)
        {
            // Update frame
            if ((tick - lastChangeTick) >= changeFrequency) {
                currentIndex = (currentIndex + 1) % images.Length;
                lastChangeTick = tick;
            }

            // Update position
            if (!Position.Equals(endPosition))
                Position = Point.Add(Position, movement);
        }

        protected override void DrawElement(Graphics g)
        {
            Rectangle outputRectangle = new Rectangle(Position, images[currentIndex].Size);
            g.DrawImage(images[currentIndex], outputRectangle);
        }
    }
}

