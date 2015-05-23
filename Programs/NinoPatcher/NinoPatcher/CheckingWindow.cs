//
//  CheckingWindow.cs
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
using System.ComponentModel;

namespace NinoPatcher
{
    public class CheckingWindow : Form
    {
        private Panel animationPanel;
        private Sprite familiars;

        public CheckingWindow()
        {
            InitializeComponents();
        }

        public ErrorCode Result {
            get;
            private set;
        }

        private void InitializeComponents()
        {
            Text = "Comprobando...";
            Width  = 320;
            Height = 70;
            BackColor = Color.LightSkyBlue;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            MaximizeBox = false;
            MinimizeBox = false;
            ControlBox  = false;
            Icon = ResourcesManager.GetIcon("icon.ico");

            Label label = new Label();
            label.Text = "Comprobando ROM introducida.\nEsto puede tardar unos minutos.";
            label.AutoSize = true;
            label.Location = new Point(116, 10);
            Controls.Add(label);

            animationPanel = new Panel();
            animationPanel.Location = new Point(10, 10);
            animationPanel.Size = new Size(100, 25);
            Controls.Add(animationPanel);

            familiars = new Sprite(0, -1, 1,
                new Point(0, 0), new Point(0, 0),
                new Size(0, 0), 1,
                ResourcesManager.GetImage("Loading.loading_0.png"),
                ResourcesManager.GetImage("Loading.loading_1.png"),
                ResourcesManager.GetImage("Loading.loading_2.png"),
                ResourcesManager.GetImage("Loading.loading_3.png"),
                ResourcesManager.GetImage("Loading.loading_4.png"),
                ResourcesManager.GetImage("Loading.loading_5.png"));
        }

        public void Run(Patcher patcher, string input, string output)
        {
            BackgroundWorker worker = new BackgroundWorker();
            worker.RunWorkerCompleted += HandleRunWorkerCompleted;
            worker.DoWork += delegate(object sender, DoWorkEventArgs e) {
                ErrorCode code = patcher.SetInput(input);
                if (code.IsValid())
                    code = patcher.SetOutput(output, FileChecker.RomLength);

                e.Result = code;
            };

            Animation.Instance.Add(animationPanel, familiars);
            worker.RunWorkerAsync();
        }

        private void HandleRunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            Animation.Instance.Remove(animationPanel, familiars);
            Result = (ErrorCode)e.Result;
            this.Close();
        }
    }
}

