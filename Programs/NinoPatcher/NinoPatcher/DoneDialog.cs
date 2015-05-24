//
//  DoneDialog.cs
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
    public class DoneDialog : Form
    {
        private Panel spritePanel;
        private Sprite shizuku;

        public DoneDialog()
        {
            InitializeComponents();
            FormClosing += HandleFormClosing;
        }

        private void InitializeComponents()
        {
            Text   = "Completado";
            Width  = 250;
            Height = 75;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            StartPosition = FormStartPosition.CenterParent;
            BackColor   = Color.LightSkyBlue;
            MaximizeBox = false;

            Label lblText = new Label();
            lblText.Text = "¡Parcheo completado con éxito!";
            lblText.Location = new Point(55, 20);
            lblText.AutoSize = true;
            Controls.Add(lblText);

            spritePanel = new Panel();
            spritePanel.Location = new Point(5, 0);
            spritePanel.Size = new Size(42, 45);
            Controls.Add(spritePanel);

            shizuku = new Sprite(0, -1, 1,
                new Point(0, 0), new Point(0, 0), new Size(0, 0), 1,
                ResourcesManager.GetImage("Done.shizuku_happy_0.png"),
                ResourcesManager.GetImage("Done.shizuku_happy_1.png"),
                ResourcesManager.GetImage("Done.shizuku_happy_2.png"),
                ResourcesManager.GetImage("Done.shizuku_happy_3.png"),
                ResourcesManager.GetImage("Done.shizuku_happy_4.png"),
                ResourcesManager.GetImage("Done.shizuku_happy_5.png"),
                ResourcesManager.GetImage("Done.shizuku_happy_6.png"));
            Animation.Instance.Add(spritePanel, shizuku);
        }

        private void HandleFormClosing(object sender, FormClosingEventArgs e)
        {
            Animation.Instance.Remove(spritePanel, shizuku);
        }
    }
}

