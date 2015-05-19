//
//  AnimationElement.cs
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
    public abstract class AnimationElement
    {
        private int lastTick;

        protected AnimationElement(int startTick, int endTick, int steps, Point position)
        {
            Position  = position;
            TickStart = startTick;
            TickEnd   = endTick;
            TickSteps = steps;

            lastTick = -1;
        }

        public int TickStart {
            get;
            private set;
        }

        public int TickEnd {
            get;
            private set;
        }

        public Point Position {
            get;
            protected set;
        }

        public int TickSteps {
            get;
            private set;
        }

        public void Draw(Graphics g, int tick)
        {
            if (tick < TickStart)
                return;

            if (TickEnd != -1 && tick >= TickEnd)
                return;

            if (lastTick == -1)
                lastTick = tick;

            if ((tick - lastTick) >= TickSteps) {
                Update(tick);
                lastTick = tick;
            }

            DrawElement(g);
        }

        protected abstract void Update(int tick);

        protected abstract void DrawElement(Graphics g);
    }
}

