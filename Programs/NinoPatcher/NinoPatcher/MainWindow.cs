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
        private Button btnShowExtras;

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
            progressBar.Size = new Size(500, 15);
            progressBar.Style = ProgressBarStyle.Continuous;
            progressBar.ForeColor = Color.Blue;
            Controls.Add(progressBar);

            btnPatch = new Button();
            btnPatch.Text = "¡Parchear!";
            btnPatch.Location = new Point(500, 400);
            btnPatch.Size = new Size(120, 40);
            Controls.Add(btnPatch);

            btnDownloadBook = new Button();
            btnDownloadBook.Text = "Vademécum";
            btnDownloadBook.Image =
                Image.FromStream(assembly.GetManifestResourceStream(VademecumResource));
            btnDownloadBook.TextImageRelation = TextImageRelation.ImageBeforeText;
            btnDownloadBook.Location = new Point(500, 460);
            btnDownloadBook.Size = new Size(120, 40);
            Controls.Add(btnDownloadBook);

            btnShowCredits = new Button();
            btnShowCredits.Text = "Créditos";
            btnShowCredits.Location = new Point(630, 400);
            btnShowCredits.Size = new Size(120, 40);
            Controls.Add(btnShowCredits);

            btnShowExtras = new Button();
            btnShowExtras.Text = "Opciones";
            btnShowExtras.Location = new Point(630, 460);
            btnShowExtras.Size = new Size(120, 40);
            Controls.Add(btnShowExtras);
            btnShowExtras.Click += delegate {
                new ExtrasWindow().ShowDialog(this);
            };
        }
    }
}

