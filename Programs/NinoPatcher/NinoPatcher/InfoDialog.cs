//
//  InfoDialog.cs
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
    public class InfoDialog : Form
    {
        public InfoDialog(string message, string title)
        {
            InitializeComponents(message);
            Text = title;
        }

        public static void Show(string message, string title, IWin32Window parent)
        {
            InfoDialog dialog = new InfoDialog(message, title);
            dialog.ShowDialog(parent);
            dialog.Dispose();
        }

        private void InitializeComponents(string message)
        {
            Width  = 335;
            Height = 132;
            MaximizeBox = false;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            BackColor     = Color.LightSkyBlue;
            StartPosition = FormStartPosition.CenterParent;
            ShowInTaskbar = false;

            Label lblMessage = new Label();
            lblMessage.Location = new Point(100, 35);
            lblMessage.AutoSize = true;
            lblMessage.Text = message;
            Controls.Add(lblMessage);

            PictureBox shizukuImageBox = new PictureBox();
            shizukuImageBox.Location = new Point(10, 10);
            shizukuImageBox.Size = new Size(75, 100);
            shizukuImageBox.Image = ResourcesManager.GetImage("oliver_info.png");
            Controls.Add(shizukuImageBox);

            Button closeBtn = new Button();
            closeBtn.Location = new Point(250, 80);
            closeBtn.AutoSize = true;
            closeBtn.Text = "Cerrar";
            closeBtn.Click += delegate { this.Close(); };
            Controls.Add(closeBtn);
        }
    }
}

