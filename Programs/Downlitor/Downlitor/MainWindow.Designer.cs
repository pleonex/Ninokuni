namespace Downlitor
{
    partial class MainWindow
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.dlcsListBox = new System.Windows.Forms.ListBox();
            this.radioSubquest = new System.Windows.Forms.RadioButton();
            this.generalBox = new System.Windows.Forms.GroupBox();
            this.radioObject = new System.Windows.Forms.RadioButton();
            this.radioAlchemy = new System.Windows.Forms.RadioButton();
            this.lblDlcName = new System.Windows.Forms.Label();
            this.txtDlcName = new System.Windows.Forms.TextBox();
            this.generalBox.SuspendLayout();
            this.SuspendLayout();
            // 
            // listBox1
            // 
            this.dlcsListBox.FormattingEnabled = true;
            this.dlcsListBox.Location = new System.Drawing.Point(12, 12);
            this.dlcsListBox.Size = new System.Drawing.Size(174, 199);
            this.dlcsListBox.TabIndex = 0;
            // 
            // groupBox2
            // 
            this.generalBox.Controls.Add(this.txtDlcName);
            this.generalBox.Controls.Add(this.lblDlcName);
            this.generalBox.Controls.Add(this.radioAlchemy);
            this.generalBox.Controls.Add(this.radioObject);
            this.generalBox.Controls.Add(this.radioSubquest);
            this.generalBox.Location = new System.Drawing.Point(192, 12);
            this.generalBox.Size = new System.Drawing.Size(256, 86);
            this.generalBox.TabIndex = 3;
            this.generalBox.TabStop = false;
            this.generalBox.Text = "General info";
            // 
            // radioButton1
            // 
            this.radioSubquest.AutoSize = true;
            this.radioSubquest.Location = new System.Drawing.Point(6, 19);
            this.radioSubquest.Size = new System.Drawing.Size(70, 17);
            this.radioSubquest.TabIndex = 2;
            this.radioSubquest.TabStop = true;
            this.radioSubquest.Text = "Subquest";
            this.radioSubquest.UseVisualStyleBackColor = true;
            // 
            // radioButton2
            // 
            this.radioObject.AutoSize = true;
            this.radioObject.Location = new System.Drawing.Point(101, 19);
            this.radioObject.Size = new System.Drawing.Size(56, 17);
            this.radioObject.TabIndex = 3;
            this.radioObject.TabStop = true;
            this.radioObject.Text = "Object";
            this.radioObject.UseVisualStyleBackColor = true;
            // 
            // radioButton3
            // 
            this.radioAlchemy.AutoSize = true;
            this.radioAlchemy.Location = new System.Drawing.Point(185, 19);
            this.radioAlchemy.Size = new System.Drawing.Size(65, 17);
            this.radioAlchemy.TabIndex = 4;
            this.radioAlchemy.TabStop = true;
            this.radioAlchemy.Text = "Alchemy";
            this.radioAlchemy.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.lblDlcName.AutoSize = true;
            this.lblDlcName.Location = new System.Drawing.Point(3, 43);
            this.lblDlcName.Name = "label3";
            this.lblDlcName.Size = new System.Drawing.Size(38, 13);
            this.lblDlcName.TabIndex = 5;
            this.lblDlcName.Text = "Name:";
            // 
            // textBox1
            // 
            this.txtDlcName.Location = new System.Drawing.Point(6, 59);
            this.txtDlcName.Name = "textBox1";
            this.txtDlcName.Size = new System.Drawing.Size(244, 20);
            this.txtDlcName.TabIndex = 6;
            // 
            // MainWindow
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(456, 222);
            this.Controls.Add(this.generalBox);
            this.Controls.Add(this.dlcsListBox);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "MainWindow";
            this.Text = "Downlitor ~~ by pleonex ~~ v1.0";
            this.generalBox.ResumeLayout(false);
            this.generalBox.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ListBox dlcsListBox;
        private System.Windows.Forms.RadioButton radioSubquest;
        private System.Windows.Forms.GroupBox generalBox;
        private System.Windows.Forms.RadioButton radioAlchemy;
        private System.Windows.Forms.RadioButton radioObject;
        private System.Windows.Forms.TextBox txtDlcName;
        private System.Windows.Forms.Label lblDlcName;
    }
}