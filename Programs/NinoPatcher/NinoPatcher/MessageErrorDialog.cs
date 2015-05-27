//
//  MessageErrorDialog.cs
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
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace NinoPatcher
{
    public class MessageErrorDialog : Form
    {
        private static readonly Dictionary<ErrorCode, string> Messages = 
            new Dictionary<ErrorCode, string>() {
            { ErrorCode.InvalidPath,
              "No se puede acceder al archivo.\nComprueba que no hay caracteres\nextraños en la ruta." },
            { ErrorCode.DoesNotExist,
              "El archivo seleccionado no existe.\nInténtalo de nuevo." },
            { ErrorCode.DoNothing,
              "Esta ROM posee la traducción,\nel parche antipiratería y el banner.\nNo se realizarán más cambios." },
            { ErrorCode.InvalidChecksum,
              "La ROM seleccionada no es válida.\nPor favor, selecciona una ROM limpia." },
            { ErrorCode.InvalidSize,
              "Esta ROM no ocupa 512 MB.\nPor favor, selecciona una ROM entera." },
            { ErrorCode.IsReadOnly,
              "El archivo seleccionado no tiene permisos\nde escritura. Por favor, desmarca\nla casilla de solo lectura." },
            { ErrorCode.NotEnoughDiskSpace,
              "No hay espacio suficiente\npara guardar la nueva ROM." },
            { ErrorCode.UserCancel,
              "Parcheo interrumpido." },
            { ErrorCode.Valid,
              "Todo correcto." },
            { ErrorCode.OutputIsInputToo,
              "No puedes sobreescribir la\nROM de origen." },
            { ErrorCode.UnknownError,
              "Se ha producido un error desconocido\nal parchear. Por favor, contacta\ncon GradienWords." }
        };

        public MessageErrorDialog(ErrorCode error)
        {
            InitializeComponents(error);
        }

        public static void Show(ErrorCode error, IWin32Window parent)
        {
            MessageErrorDialog dialog = new MessageErrorDialog(error);
            dialog.ShowDialog(parent);
            dialog.Dispose();
        }

        private void InitializeComponents(ErrorCode error)
        {
            Width  = 335;
            Height = 100;
            MaximizeBox = false;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            BackColor     = Color.FromArgb(177, 210, 229);
            StartPosition = FormStartPosition.CenterParent;
            ShowInTaskbar = false;

            Button closeBtn = new Button();
            closeBtn.Location = new Point(250, 48);
            closeBtn.AutoSize = true;
            closeBtn.Text = "Cerrar";
            closeBtn.BackColor = SystemColors.Control;
            closeBtn.Click += delegate { this.Close(); };
            Controls.Add(closeBtn);

            Label lblError = new Label();
            lblError.Location = new Point(80, 15);
            lblError.AutoSize = true;
            lblError.Text = Messages[error];
            Controls.Add(lblError);

            PictureBox shizukuImageBox = new PictureBox();
            shizukuImageBox.Location = new Point(10, 10);
            shizukuImageBox.Size = new Size(60, 70);
            shizukuImageBox.Image = ResourcesManager.GetImage("shizuku_error.png");
            Controls.Add(shizukuImageBox);
        }
    }
}

