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

            dlcsListBox.SelectedIndexChanged += HandleSelectedIndexChanged;
        }

        private void LoadDlcs()
        {
            for (int i = 0; i < manager.NumEntries; i++)
                if (manager[i] != null)
                    dlcsListBox.Items.Add(manager[i]);
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
