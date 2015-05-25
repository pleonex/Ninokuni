//
//  CreditsWindow.cs
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
using System.Windows.Forms;
using System.Reflection;
using System.Drawing;

namespace NinoPatcher
{
    public class CreditsWindow : Form
    {
        public CreditsWindow()
        {
            InitializeComponents();
        }

        private void InitializeComponents()
        {
            Text   = "Créditos";
            Width  = 800;
            Height = 600;
            MaximizeBox = false;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            StartPosition   = FormStartPosition.CenterParent;
            BackgroundImage = ResourcesManager.GetImage("credits.png");
            ShowInTaskbar   = false;

            Button closeBtn = new Button();
            closeBtn.Location = new Point(715, 548);
            closeBtn.AutoSize = true;
            closeBtn.Text = "Cerrar";
            closeBtn.BackColor = SystemColors.Control;
            closeBtn.Click += delegate { this.Close(); };
            Controls.Add(closeBtn);
        }
    }
}

