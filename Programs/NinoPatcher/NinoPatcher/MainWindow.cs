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
using System.Media;
using System.Windows.Forms;

namespace NinoPatcher
{
    public class MainWindow : Form
    {
        private SoundPlayer player;
        private Sprite termito;

        private Panel bgBottom;
        private ProgressBar progressBar;
        private ImageButton btnPatch;
        private ImageButton btnDownloadBook;
        private ImageButton btnShowCredits;
        private ImageButton btnShowExtras;

        public MainWindow()
		{
            InitializeComponents();
            PlaySound();

            ExtrasWindow.AntiPiracy = true;
            ExtrasWindow.Banner     = false;
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
            Icon = ResourcesManager.GetIcon("icon.ico");

            CreateAnimation();

            bgBottom = new Panel();
            bgBottom.BackColor = Color.Transparent;
            bgBottom.Location  = new Point(0, 480);
            bgBottom.Size      = new Size(800, 120);
            bgBottom.BackgroundImage = ResourcesManager.GetImage("skingold.png");
            Controls.Add(bgBottom);

            Panel separationLine = new Panel();
            separationLine.BackColor = Color.White;
            separationLine.Location  = new Point(0, 0);
            separationLine.Size      = new Size(800, 3);
            bgBottom.Controls.Add(separationLine);

            progressBar = new ProgressBar();
            progressBar.Value     = 0;
            progressBar.Location  = new Point(10, 73);
            progressBar.Size      = new Size(523, 15);
            progressBar.Style     = ProgressBarStyle.Continuous;
            progressBar.ForeColor = Color.SkyBlue;
            bgBottom.Controls.Add(progressBar);

            btnPatch = new ImageButton();
            btnPatch.Location = new Point(543, 10);
            btnPatch.DefaultImage = ResourcesManager.GetImage("Buttons.patch_0.png");
            btnPatch.PressedImage = ResourcesManager.GetImage("Buttons.patch_1.png");
            btnPatch.Click += BtnPatchOnClick;
            bgBottom.Controls.Add(btnPatch);

            btnDownloadBook = new ImageButton();
            btnDownloadBook.DefaultImage = ResourcesManager.GetImage("Buttons.book_0.png");
            btnDownloadBook.PressedImage = ResourcesManager.GetImage("Buttons.book_1.png");
            btnDownloadBook.Location = new Point(668, 10);
            bgBottom.Controls.Add(btnDownloadBook);

            btnShowCredits = new ImageButton();
            btnShowCredits.DefaultImage = ResourcesManager.GetImage("Buttons.credits_0.png");
            btnShowCredits.PressedImage = ResourcesManager.GetImage("Buttons.credits_1.png");
            btnShowCredits.Location = new Point(668, 55);
            btnShowCredits.Click += delegate {
                CreditsWindow credits = new CreditsWindow();
                credits.ShowDialog(this);
                credits.Dispose();
            };
            bgBottom.Controls.Add(btnShowCredits);

            btnShowExtras = new ImageButton();
            btnShowExtras.DefaultImage = ResourcesManager.GetImage("Buttons.options_0.png");
            btnShowExtras.PressedImage = ResourcesManager.GetImage("Buttons.options_1.png");
            btnShowExtras.Location = new Point(543, 55);
            bgBottom.Controls.Add(btnShowExtras);
            btnShowExtras.Click += delegate {
                ExtrasWindow extras = new ExtrasWindow();
                extras.ShowDialog(this);
                extras.Dispose();
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

            Image jaboImage  = ResourcesManager.GetImage("Jabologo.png");
			Point jaboOffset = new Point(93, 0);
			Fade jaboFade    = new Fade(5,  85, 1, jaboOffset, -1,  0.020f, jaboImage);
			Fade jaboBlink   = new Fade(90, -1, 1, jaboOffset, 12, -0.030f, jaboImage, 1.0f);

            Image textImage  = ResourcesManager.GetImage("logonombre.png");
            Point textOffset = new Point(84, 0);
            Fade textFade    = new Fade(50, 40, 1, textOffset, -1,  0.025f, textImage);
			BackgroundImage textFixed = new BackgroundImage(90, -1, 1, textOffset, textImage);

			Animation animation = Animation.Instance;
			animation.Add(bgPanel, jaboFade);
			animation.Add(bgPanel, textFade);
			animation.Add(bgPanel, jaboBlink);
			animation.Add(bgPanel, textFixed);
			animation.Interval = 150;	// Setting that, it starts

            // Create sprite animations for later use
            termito = new Sprite(0, -1, 1,                  // delay, duration, steps
                new Point(10, 30), new Point(10, 30),       // start, end pos
                new Size(3, 0), 1,                          // movement
                ResourcesManager.GetImage("Termito.anime_0.png"),   // frame 0
                ResourcesManager.GetImage("Termito.anime_1.png"),   // frame 1
                ResourcesManager.GetImage("Termito.anime_2.png"),   // frame 2
                ResourcesManager.GetImage("Termito.anime_3.png"));  // frame 3
        }

        private void PlaySound()
        {
            player = new SoundPlayer(ResourcesManager.GetStream("sound.wav"));
            player.PlayLooping();
            FormClosing += delegate { player.Stop(); };
        }

        private void BtnPatchOnClick(object sender, EventArgs e)
        {
            Patcher patcher = new Patcher(ExtrasWindow.AntiPiracy, ExtrasWindow.Banner);

            ErrorCode result = AskForFiles(patcher);
            if (!result.IsValid()) {
                MessageErrorDialog errorDialog = new MessageErrorDialog(result);
                errorDialog.ShowDialog(this);
                errorDialog.Dispose();
                return;
            }

            // Add animation
            if (!Animation.Instance.Contains(bgBottom, termito))
                Animation.Instance.Add(bgBottom, termito);

            // Start animation
            termito.Position = new Point(-29, 30);
            PatchProgressChanged(0);
            termito.AutoDisable = false;
            termito.Enabled = true;

            // Disable button
            btnPatch.Enabled = false;
            btnShowExtras.Enabled = false;

            // Patch
            patcher.ProgressChanged += PatchProgressChanged;
            patcher.Finished += PatchFinished;
            patcher.Patch();
        }

        private ErrorCode AskForFiles(Patcher patcher)
        {
            string input;
            InfoDialog.Show("Primero selecciona la ROM limpia.", "ROM de entrada", this);
            using (OpenFileDialog inputDialog = new OpenFileDialog()) {
                inputDialog.AddExtension = true;
                inputDialog.CheckFileExists = true;
                inputDialog.CheckPathExists = true;
                inputDialog.DefaultExt = ".nds";
                inputDialog.DereferenceLinks = true;
                inputDialog.Filter = "Nintendo DS ROM |*.nds";
                inputDialog.Multiselect = false;
                inputDialog.ShowHelp = false;
                inputDialog.ShowReadOnly = false;
                inputDialog.SupportMultiDottedExtensions = true;
                inputDialog.Title = "Selecciona la ROM limpia";
                inputDialog.ValidateNames = true;
                if (inputDialog.ShowDialog(this) != DialogResult.OK)
                    return ErrorCode.UserCancel;

                input = inputDialog.FileName;
            }

            string output;
            InfoDialog.Show("Ahora selecciona dónde guardar\nla ROM parcheada.", "ROM de salida", this);
            using (SaveFileDialog outputDialog = new SaveFileDialog()) {
                outputDialog.AddExtension = true;
                outputDialog.CheckFileExists = false;
                outputDialog.CheckPathExists = true;
                outputDialog.DefaultExt = ".nds";
                outputDialog.DereferenceLinks = true;
                outputDialog.Filter = "Nintendo DS ROM |*.nds";
                outputDialog.ShowHelp = false;
                outputDialog.SupportMultiDottedExtensions = true;
                outputDialog.Title = "Selecciona el destino de la ROM parcheada";
                outputDialog.ValidateNames = true;
                outputDialog.OverwritePrompt = true;
                if (outputDialog.ShowDialog(this) != DialogResult.OK)
                    return ErrorCode.UserCancel;

                output = outputDialog.FileName;
            }

            if (input == output)
                return ErrorCode.OutputIsInputToo;

            CheckingWindow checkWindow = new CheckingWindow();
            checkWindow.Run(patcher, input, output);
            checkWindow.ShowDialog(this);

            ErrorCode result = checkWindow.Result;
            checkWindow.Dispose();

            return result;
        }

        private void PatchFinished(ErrorCode error)
        {
            // Disable animation
            termito.AutoDisable = true;

            // Enable buttons
            btnPatch.Enabled = true;
            btnShowExtras.Enabled = true;

            if (error.IsValid())
                DoneDialog.ShowWindow(this);
            else
                MessageErrorDialog.Show(ErrorCode.UnknownError, this);
        }

        private void PatchProgressChanged(double progress)
        {
            int startX = 10 - 39;
            int endX   = 460;
            int distance = endX - startX;
            int x = (int)(startX + distance * progress / 100);

            termito.EndPosition  = new Point(x, termito.EndPosition.Y);
            progressBar.Value = (int)progress;
        }
    }
}

