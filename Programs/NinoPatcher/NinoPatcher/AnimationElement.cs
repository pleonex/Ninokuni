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
        protected AnimationElement(int delay, int duration, int steps, Point position)
        {
            Position = position;
            Delay    = delay;
			Duration = duration;
			Steps    = steps;
			CurrentStep = steps;
        }

        public int Delay {
            get;
            set;
        }

        public int Duration {
            get;
            set;
        }

        public Point Position {
            get;
            set;
        }

		public int CurrentStep {
			get;
			set;
		}

        public int Steps {
            get;
            private set;
        }

        public abstract void Update();
        public abstract void Draw(Graphics g);
    }
}

