using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Downlitor
{
    public partial class SubquestInfoControl : UserControl
    {
        public SubquestInfoControl(DlcItem dlc)
        {
            InitializeComponent();

            var manager = SubquestManager.Instance;
            for (int i = 0; i < manager.NumEntries; i++)
                comboSubquest.Items.Add(manager.GetEntry(i));
            comboSubquest.SelectedIndex = manager.GetIndex(dlc.Index);

            comboSubquest.SelectedIndexChanged += delegate {
                dlc.Index = (ushort)manager.GetNumber(comboSubquest.SelectedIndex);
            };
        }
    }
}
