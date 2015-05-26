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
        private const string AntiPiracyTextInfo = 
            "Aunque no sea necesario en algunas flashcards,\n" +
            "en muy pocas causará problemas. No incluye el\n" +
            "intercambio del ARM7.";
        private const string BannerTextInfo = 
            "Marca esta opción si quieres ver el título del juego\n" +
            "en español en el menú de la flaschard. Esta opción\n" +
            "hace que muchas flashcard dejen de ser compatibles.";

        public ExtrasWindow()
        {
            InitializeComponents();
        }

        public static bool AntiPiracy {
            get;
            set;
        }

        public static bool Banner {
            get;
            set;
        }

        private void InitializeComponents()
        {
            Text   = "Parches adicionales";
            Width  = 350;
            Height = 215;
            MaximizeBox = false;
            BackColor   = Color.LightSkyBlue;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            StartPosition   = FormStartPosition.CenterParent;
            ShowInTaskbar = false;

            Button closeBtn = new Button();
            closeBtn.Location = new Point(265, 163);
            closeBtn.AutoSize = true;
            closeBtn.Text = "Cerrar";
            closeBtn.BackColor = SystemColors.Control;
            closeBtn.Click += delegate { this.Close(); };
            Controls.Add(closeBtn);

            Label extraLabel = new Label();
            extraLabel.Text  = "Opciones necesarias para determinadas flashcards.\n";
            extraLabel.Text += "Cambia su valor solo si has probado y no funciona.";
            extraLabel.Location = new Point(5, 10);
            extraLabel.AutoSize = true;
            Controls.Add(extraLabel);

            CheckBox checkAntiPiracy = new CheckBox();
            checkAntiPiracy.Text  = "Añadir parche antipiratería básico.\n" + AntiPiracyTextInfo;
            checkAntiPiracy.Location = new Point(8, 50);
            checkAntiPiracy.AutoSize = true;
            checkAntiPiracy.Checked  = AntiPiracy;
            checkAntiPiracy.CheckAlign = ContentAlignment.TopLeft;
            checkAntiPiracy.CheckedChanged += delegate { AntiPiracy = checkAntiPiracy.Checked; };
            Controls.Add(checkAntiPiracy);

            CheckBox checkBanner = new CheckBox();
            checkBanner.Text = "Añadir título de juego traducido.\n" + BannerTextInfo;
            checkBanner.Location = new Point(8, 110);
            checkBanner.AutoSize = true;
            checkBanner.Checked  = Banner;
            checkBanner.CheckAlign = ContentAlignment.TopLeft;
            checkBanner.CheckedChanged += delegate { Banner = checkBanner.Checked; };
            Controls.Add(checkBanner);
        }
    }
}

