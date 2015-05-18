//
//  MainWindow.cs
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
using System.Reflection;
using System.Windows.Forms;

namespace NinoPatcher
{
    public class MainWindow : Form
    {
        private const string IconResource = "NinoPatcher.Resources.icon.ico";
        private const string VademecumResource = "NinoPatcher.Resources.vademecum.png";

        private Assembly assembly = Assembly.GetExecutingAssembly();
        private Panel bgPanel;
        private ProgressBar progressBar;
        private Button btnPatch;
        private Button btnDownloadBook;
        private Button btnShowCredits;
        private CheckBox checkAntiPiracy;
        private CheckBox checkBanner;

        public MainWindow()
        {
            InitializeComponents();
        }

        private void InitializeComponents()
        {
            Text = "Ninokuni - El Mago de las Tinieblas v1.0 ~~ GradienWords";
            Icon = new Icon(assembly.GetManifestResourceStream(IconResource));
            Width  = 800;
            Height = 600;

            bgPanel = new Panel();
            bgPanel.BackColor = Color.Black;
            bgPanel.Location  = new Point(0, 0);
            bgPanel.Size = new Size(800, 400);
            Controls.Add(bgPanel);

            progressBar = new ProgressBar();
            progressBar.Value = 50;
            progressBar.Location = new Point(0, 400);
            progressBar.Size = new Size(500, 20);
            progressBar.Style = ProgressBarStyle.Continuous;
            Controls.Add(progressBar);

            btnPatch = new Button();
            btnPatch.AutoSize = true;
            btnPatch.Text = "¡Parchear!";
            btnPatch.Location = new Point(500, 400);
            Controls.Add(btnPatch);

            btnDownloadBook = new Button();
            btnDownloadBook.AutoSize = true;
            btnDownloadBook.Text = "Vademécum";
            btnDownloadBook.Image =
                Image.FromStream(assembly.GetManifestResourceStream(VademecumResource));
            btnDownloadBook.TextImageRelation = TextImageRelation.ImageBeforeText;
            btnDownloadBook.Location = new Point(500, 440);
            Controls.Add(btnDownloadBook);

            btnShowCredits = new Button();
            btnShowCredits.AutoSize = true;
            btnShowCredits.Text = "Créditos";
            btnShowCredits.Location = new Point(600, 400);
            Controls.Add(btnShowCredits);

            GroupBox extraBox = new GroupBox();
            extraBox.AutoSize = true;
            extraBox.Text = "Extras para el parche";
            extraBox.Location = new Point(200, 450);
            //extraBox.Size = new Size(150, 300);
            Controls.Add(extraBox);

            Label extraLabel = new Label();
            extraLabel.AutoSize = true;
            extraLabel.Text = "Opciones necesarias para determinadas flashcards.\n";
            extraLabel.Text += "Actívala solo si has probado sin ellas y no funciona.";
            extraLabel.Location = new Point(0, 20);
            extraBox.Controls.Add(extraLabel);

            checkAntiPiracy = new CheckBox();
            checkAntiPiracy.AutoSize = true;
            checkAntiPiracy.Text = "Añadir parche antipiratería";
            checkAntiPiracy.Location = new Point(0, 50);
            extraBox.Controls.Add(checkAntiPiracy);

            checkBanner = new CheckBox();
            checkBanner.AutoSize = true;
            checkBanner.Text = "Añadir título de juego traducido";
            checkBanner.Location = new Point(0, 80);
            extraBox.Controls.Add(checkBanner);
        }
    }
}

