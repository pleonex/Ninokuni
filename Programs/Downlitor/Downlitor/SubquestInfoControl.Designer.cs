namespace Downlitor
{
    partial class SubquestInfoControl
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.mainBox = new System.Windows.Forms.GroupBox();
            this.lblSubquest = new System.Windows.Forms.Label();
            this.comboSubquest = new System.Windows.Forms.ComboBox();
            this.mainBox.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.mainBox.Controls.Add(this.comboSubquest);
            this.mainBox.Controls.Add(this.lblSubquest);
            this.mainBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.mainBox.Location = new System.Drawing.Point(0, 0);
            this.mainBox.Size = new System.Drawing.Size(256, 110);
            this.mainBox.TabIndex = 0;
            this.mainBox.TabStop = false;
            this.mainBox.Text = "Subquest Info";
            // 
            // label1
            // 
            this.lblSubquest.AutoSize = true;
            this.lblSubquest.Location = new System.Drawing.Point(7, 20);
            this.lblSubquest.Size = new System.Drawing.Size(55, 13);
            this.lblSubquest.TabIndex = 0;
            this.lblSubquest.Text = "Subquest:";
            // 
            // comboBox1
            // 
            this.comboSubquest.FormattingEnabled = true;
            this.comboSubquest.Location = new System.Drawing.Point(68, 17);
            this.comboSubquest.Size = new System.Drawing.Size(182, 21);
            this.comboSubquest.TabIndex = 1;
            // 
            // SubquestInfoControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.mainBox);
            this.Name = "SubquestInfoControl";
            this.Size = new System.Drawing.Size(256, 110);
            this.mainBox.ResumeLayout(false);
            this.mainBox.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox mainBox;
        private System.Windows.Forms.ComboBox comboSubquest;
        private System.Windows.Forms.Label lblSubquest;
    }
}
