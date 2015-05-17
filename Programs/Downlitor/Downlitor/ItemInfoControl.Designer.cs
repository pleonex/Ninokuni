namespace Downlitor
{
    partial class ItemInfoControl
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
            this.lblName = new System.Windows.Forms.Label();
            this.comboItems = new System.Windows.Forms.ComboBox();
            this.mainBox.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.mainBox.Controls.Add(this.comboItems);
            this.mainBox.Controls.Add(this.lblName);
            this.mainBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.mainBox.Location = new System.Drawing.Point(0, 0);
            this.mainBox.Size = new System.Drawing.Size(256, 110);
            this.mainBox.TabIndex = 0;
            this.mainBox.TabStop = false;
            this.mainBox.Text = "Item Info";
            // 
            // label1
            // 
            this.lblName.AutoSize = true;
            this.lblName.Location = new System.Drawing.Point(7, 20);
            this.lblName.Size = new System.Drawing.Size(30, 13);
            this.lblName.TabIndex = 0;
            this.lblName.Text = "Item:";
            // 
            // comboBox1
            // 
            this.comboItems.FormattingEnabled = true;
            this.comboItems.Location = new System.Drawing.Point(43, 17);
            this.comboItems.Size = new System.Drawing.Size(207, 21);
            this.comboItems.TabIndex = 1;
            // 
            // ItemInfoControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.mainBox);
            this.Name = "ItemInfoControl";
            this.Size = new System.Drawing.Size(256, 110);
            this.mainBox.ResumeLayout(false);
            this.mainBox.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox mainBox;
        private System.Windows.Forms.Label lblName;
        private System.Windows.Forms.ComboBox comboItems;
    }
}
