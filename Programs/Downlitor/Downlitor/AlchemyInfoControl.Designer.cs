namespace Downlitor
{
    partial class AlchemyInfoControl
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
            this.listIngredient = new System.Windows.Forms.ListBox();
            this.label2 = new System.Windows.Forms.Label();
            this.comboRecipe = new System.Windows.Forms.ComboBox();
            this.lblRecipe = new System.Windows.Forms.Label();
            this.mainBox.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.mainBox.Controls.Add(this.listIngredient);
            this.mainBox.Controls.Add(this.label2);
            this.mainBox.Controls.Add(this.comboRecipe);
            this.mainBox.Controls.Add(this.lblRecipe);
            this.mainBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.mainBox.Location = new System.Drawing.Point(0, 0);
            this.mainBox.Size = new System.Drawing.Size(256, 110);
            this.mainBox.TabIndex = 0;
            this.mainBox.TabStop = false;
            this.mainBox.Text = "Alchemy Info";
            // 
            // listBox2
            // 
            this.listIngredient.FormattingEnabled = true;
            this.listIngredient.Location = new System.Drawing.Point(9, 57);
            this.listIngredient.SelectionMode = System.Windows.Forms.SelectionMode.None;
            this.listIngredient.Size = new System.Drawing.Size(240, 43);
            this.listIngredient.TabIndex = 7;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 40);
            this.label2.Size = new System.Drawing.Size(62, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Ingredients:";
            // 
            // comboBox1
            // 
            this.comboRecipe.FormattingEnabled = true;
            this.comboRecipe.Location = new System.Drawing.Point(56, 16);
            this.comboRecipe.Size = new System.Drawing.Size(194, 21);
            this.comboRecipe.TabIndex = 5;
            // 
            // label1
            // 
            this.lblRecipe.AutoSize = true;
            this.lblRecipe.Location = new System.Drawing.Point(6, 19);
            this.lblRecipe.Size = new System.Drawing.Size(44, 13);
            this.lblRecipe.TabIndex = 4;
            this.lblRecipe.Text = "Recipe:";
            // 
            // AlchemyInfoControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.mainBox);
            this.Name = "AlchemyInfoControl";
            this.Size = new System.Drawing.Size(256, 110);
            this.mainBox.ResumeLayout(false);
            this.mainBox.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox mainBox;
        private System.Windows.Forms.ListBox listIngredient;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox comboRecipe;
        private System.Windows.Forms.Label lblRecipe;
    }
}
