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
              "La ruta al archivo es inválida.\nComprueba que no haya caracteres\nextraños en la ruta." },
            { ErrorCode.DoesNotExist,
              "El archivo seleccionado no exsite.\nPrueba a seleccionarlo de nuevo." },
            { ErrorCode.DoNothing,
              "Esta ROM ya tiene la traducción,\nel parche antipiratería y el banner.\nNo se realiza ninguna operación" },
            { ErrorCode.InvalidChecksum,
              "La ROM seleccionada es inválida.\nPor favor, vuelve a descargarte una ROM limpia." },
            { ErrorCode.InvalidSize,
              "Esta ROM no ocupa 512 MB por lo que\nha sido \"trimeada\". Por favor,\ndescarga una ROM entera." },
            { ErrorCode.IsReadOnly,
              "El archivo seleccionado no tiene permisos\nde escritura. Por favor, desmarca\nla casilla de solo-lectura." },
            { ErrorCode.NotEnoughDiskSpace,
              "No hay espacio suficiente en el disco\nactual para guardar la nueva ROM.\nSelecciona otro disco." },
            { ErrorCode.UserCancel,
              "Has cancelado el parcheo." },
            { ErrorCode.Valid,
              "Todo correcto." },
            { ErrorCode.OutputIsInputToo,
              "El archivo donde se escribirá la ROM\nparcheada no puede ser el mismo\nde la ROM limpia." }
        };

        public MessageErrorDialog(ErrorCode error)
        {
            InitializeComponents(error);
        }

        private void InitializeComponents(ErrorCode error)
        {
            Width  = 335;
            Height = 100;
            MaximizeBox = false;
            FormBorderStyle = FormBorderStyle.FixedDialog;
            BackColor     = Color.LightSkyBlue;
            StartPosition = FormStartPosition.CenterParent;
            ShowInTaskbar = false;

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

            Button closeBtn = new Button();
            closeBtn.Location = new Point(250, 48);
            closeBtn.AutoSize = true;
            closeBtn.Text = "Cerrar";
            closeBtn.Click += delegate { this.Close(); };
            Controls.Add(closeBtn);
        }
    }
}

