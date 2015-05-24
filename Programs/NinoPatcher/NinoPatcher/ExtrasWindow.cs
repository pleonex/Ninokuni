//
//  ExtrasWindow.cs
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
using System.Drawing;

namespace NinoPatcher
{
    public class ExtrasWindow : Form
    {
        private CheckBox checkAntiPiracy;
        private CheckBox checkBanner;

        public ExtrasWindow()
        {
            InitializeComponents();
        }

        private void InitializeComponents()
        {
            Width  = 400;
            MaximizeBox = false;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            StartPosition = FormStartPosition.CenterParent;

            Label extraLabel = new Label();
            extraLabel.AutoSize = true;
            extraLabel.Text = "Opciones necesarias para determinadas flashcards.\n";
            extraLabel.Text += "Actívala solo si has probado sin ellas y no funciona.";
            extraLabel.Location = new Point(0, 20);
            Controls.Add(extraLabel);

            checkAntiPiracy = new CheckBox();
            checkAntiPiracy.AutoSize = true;
            checkAntiPiracy.Text = "Añadir parche antipiratería";
            checkAntiPiracy.Location = new Point(0, 50);
            Controls.Add(checkAntiPiracy);

            checkBanner = new CheckBox();
            checkBanner.AutoSize = true;
            checkBanner.Text = "Añadir título de juego traducido";
            checkBanner.Location = new Point(0, 80);
            Controls.Add(checkBanner);
        }
    }
}

