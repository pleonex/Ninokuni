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

        public MainWindow()
        {
            InitializeComponent();
            generalBox.Enabled = false;

            manager = DlcManager.Instance;
            LoadDlcs();
        }

        private void LoadDlcs()
        {
            for (int i = 0; i < manager.NumEntries; i++)
                if (manager[i] != null)
                    dlcsListBox.Items.Add(manager[i]);
        }
    }
}
