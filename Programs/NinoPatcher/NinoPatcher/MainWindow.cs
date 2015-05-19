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
using System.Media;

namespace NinoPatcher
{
    public class MainWindow : Form
    {
        private const string IconResource = "NinoPatcher.Resources.icon.ico";
        private const string VademecumResource = "NinoPatcher.Resources.vademecum.png";
        private const string ButtonResourcePath = "NinoPatcher.Resources.Buttons.";

        private Assembly assembly = Assembly.GetExecutingAssembly();
        private SoundPlayer player;
        private ProgressBar progressBar;

        public MainWindow()
        {
            InitializeComponents();
            PlaySound();
        }

        private void InitializeComponents()
        {
            SuspendLayout();

            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            Width  = 800;
            Height = 600;
            MinimumSize = new Size(800, 600);
            MaximumSize = new Size(800, 600);
            Text = "Ninokuni - El Mago de las Tinieblas v1.0 ~~ GradienWords";
            Icon = new Icon(assembly.GetManifestResourceStream(IconResource));

            CreateAnimation();

            Panel bgBottom = new Panel();
            bgBottom.BackColor = Color.Transparent;
            bgBottom.Location = new Point(0, 480);
            bgBottom.Size = new Size(800, 120);
            bgBottom.BackgroundImage = Image.FromStream(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.skingold.png"));
            Controls.Add(bgBottom);

            Panel separationLine = new Panel();
            separationLine.BackColor = Color.White;
            separationLine.Size = new Size(800, 3);
            separationLine.Location = new Point(0, 0);
            bgBottom.Controls.Add(separationLine);

            progressBar = new ProgressBar();
            progressBar.Value = 0;
            progressBar.Location = new Point(10, 73);
            progressBar.Size = new Size(523, 15);
            progressBar.Style = ProgressBarStyle.Continuous;
            progressBar.ForeColor = Color.SkyBlue;
            bgBottom.Controls.Add(progressBar);

            Image termitoImg0 = Image.FromStream(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.anime_0.png"));
            Image termitoImg1 = Image.FromStream(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.anime_1.png"));
            Image termitoImg2 = Image.FromStream(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.anime_2.png"));
            Image termitoImg3 = Image.FromStream(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.anime_3.png"));
            Sprite termitoSprite = new Sprite(0, -1, 1, new Point(500, 30), 
                                       new Point(10, 30), new Size(-1, 0), 1,
                                       termitoImg0, termitoImg1, termitoImg2, termitoImg3);
            Fade termitoBg = new Fade(0, -1, 1, Point.Empty, -1, 0f,
                Image.FromStream(
                    assembly.GetManifestResourceStream("NinoPatcher.Resources.skingold.png"))
                , 1.0f);
            Animation animation = new Animation(150, bgBottom, termitoBg, termitoSprite);
            animation.Start();

            ImageButton btnPatch = new ImageButton();
            btnPatch.Location = new Point(543, 10);
            btnPatch.DefaultImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "patch_0.png"));
            btnPatch.PressedImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "patch_1.png"));
            bgBottom.Controls.Add(btnPatch);

            ImageButton btnDownloadBook = new ImageButton();
            btnDownloadBook.DefaultImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "book_0.png"));
            btnDownloadBook.PressedImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "book_1.png"));
            btnDownloadBook.Location = new Point(543, 55);
            bgBottom.Controls.Add(btnDownloadBook);

            ImageButton btnShowCredits = new ImageButton();
            btnShowCredits.DefaultImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "credits_0.png"));
            btnShowCredits.PressedImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "credits_1.png"));
            btnShowCredits.Location = new Point(668, 10);
            bgBottom.Controls.Add(btnShowCredits);

            ImageButton btnShowExtras = new ImageButton();
            btnShowExtras.DefaultImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "options_0.png"));
            btnShowExtras.PressedImage = Image.FromStream(
                assembly.GetManifestResourceStream(ButtonResourcePath + "options_1.png"));
            btnShowExtras.Location = new Point(668, 55);
            bgBottom.Controls.Add(btnShowExtras);
            btnShowExtras.Click += delegate {
                new ExtrasWindow().ShowDialog(this);
            };

            ResumeLayout(false);
        }

        private void CreateAnimation()
        {
            // For smooth animations
            SetStyle(ControlStyles.UserPaint, true);
            SetStyle(ControlStyles.OptimizedDoubleBuffer, true);
            SetStyle(ControlStyles.AllPaintingInWmPaint, true);

            Panel bgPanel = new Panel();
            bgPanel.BackColor = Color.Black;
            bgPanel.Location  = new Point(0, 0);
            bgPanel.Size = new Size(800, 480);
            Controls.Add(bgPanel);

            Image jaboImage = Image.FromStream(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.Jabologo.png"));
            Image textImage = Image.FromStream(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.logonombre.png"));

            Point jaboOffset = new Point(93, 0);
            Point textOffset = new Point(84, 0);

            Fade jaboFade  = new Fade(05, 90, 1, jaboOffset, -1,  0.020f, jaboImage);
            Fade textFade  = new Fade(55, 90, 1, textOffset, -1,  0.025f, textImage);

            Animation animation = new Animation(100, bgPanel, jaboFade, textFade);
            animation.Start();

            animation.Finished += delegate {
                Fade textFixed = new Fade(0, -1, 1, textOffset, -1, 0, textImage, 1.0f);
                Fade jaboBlink = new Fade(0, -1, 1, jaboOffset, 12, -0.020f, jaboImage, 1.0f);

                animation = new Animation(200, bgPanel, jaboBlink, textFixed);
                animation.Start();
            };
        }

        private void PlaySound()
        {
            player = new SoundPlayer(
                assembly.GetManifestResourceStream("NinoPatcher.Resources.sound.wav"));
            player.PlayLooping();
            FormClosing += delegate { player.Stop(); };
        }
    }
}

