using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Downlitor
{
    public partial class MainWindow : Form
    {
        DlcManager manager;
        UserControl specificControl;

        public MainWindow()
        {
            InitializeComponent();
            generalBox.Enabled = false;

            manager = DlcManager.Instance;
            LoadDlcs();
            dlcsListBox.SelectedIndex = 1;

            radioObject.CheckedChanged += HandleCheckedChanged;
            radioSubquest.CheckedChanged += HandleCheckedChanged;
            radioAlchemy.CheckedChanged += HandleCheckedChanged;
            radioEmpty.CheckedChanged += HandleCheckedChanged;
            dlcsListBox.SelectedIndexChanged += HandleSelectedIndexChanged;
            txtDlcName.TextChanged += HandleTextChanged;
            this.FormClosing += HandleFormClosing;
        }

        private void HandleTextChanged (object sender, EventArgs e)
        {
            var dlc = (DlcItem)dlcsListBox.SelectedItem;
            dlc.Name = txtDlcName.Text;
        }

        private void HandleCheckedChanged (object sender, EventArgs e)
        {
            var dlc = (DlcItem)dlcsListBox.SelectedItem;

            if (radioObject.Checked)
                dlc.Tab = DlcType.Item;
            if (radioSubquest.Checked)
                dlc.Tab = DlcType.Subquest;
            if (radioAlchemy.Checked)
                dlc.Tab = DlcType.Alchemy;
            if (radioEmpty.Checked) {
                dlc.Tab   = DlcType.Empty;
                dlc.Index = 0x00;
                dlc.Name  = string.Empty;
            }

            UpdateSpecificInfo(dlc);
        }

        private void HandleFormClosing (object sender, FormClosingEventArgs e)
        {
            // Update on closing
            manager.Write();
        }

        private void LoadDlcs()
        {
            var dlcList = new BindingList<DlcItem>(manager.GetItems());
            dlcsListBox.DataSource = dlcList;
        }

        private void HandleSelectedIndexChanged (object sender, EventArgs e)
        {
            var dlc = (DlcItem)dlcsListBox.SelectedItem;
            UpdateGeneralInfo(dlc);
            UpdateSpecificInfo(dlc);
        }

        private void UpdateGeneralInfo(DlcItem dlc)
        {
            generalBox.Enabled = true;
            radioAlchemy.Checked  = (dlc.Tab == DlcType.Alchemy);
            radioObject.Checked   = (dlc.Tab == DlcType.Item);
            radioSubquest.Checked = (dlc.Tab == DlcType.Subquest);
            radioEmpty.Checked    = (dlc.Tab == DlcType.Empty);
            txtDlcName.Text = dlc.Name;
        }

        private void UpdateSpecificInfo(DlcItem dlc)
        {
            if (specificControl != null) {
                this.Controls.Remove(specificControl);
                specificControl.Dispose();
                specificControl = null;
            }

            switch (dlc.Tab) {
            case DlcType.Alchemy:
                specificControl = new AlchemyInfoControl(dlc);
                break;

            case DlcType.Item:
                specificControl = new ItemInfoControl(dlc);
                break;

            case DlcType.Subquest:
                specificControl = new SubquestInfoControl(dlc);
                break;
            }

            if (specificControl != null) {
                specificControl.Location = new Point(224, 104);
                this.Controls.Add(specificControl);
            }
        }
    }
}
