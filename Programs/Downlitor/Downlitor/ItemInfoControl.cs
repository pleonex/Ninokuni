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
    public partial class ItemInfoControl : UserControl
    {
        public ItemInfoControl(DlcItem dlc)
        {
            InitializeComponent();

            var manager = ItemManager.Instance;
            for (int i = 0; i < ItemManager.NumEntries; i++) {
                var item = manager.GetItem(i);
                comboItems.Items.Add((item == null) ? "Invalid" : item + " (" + i.ToString("D3") + ")");
            }
            comboItems.SelectedIndex = dlc.Index;
            comboItems.AutoCompleteMode = AutoCompleteMode.Suggest;
            comboItems.AutoCompleteSource = AutoCompleteSource.ListItems;

            comboItems.SelectedIndexChanged += delegate {
                if ((string)comboItems.SelectedItem == "Invalid")
                    return;

                dlc.Index = (ushort)comboItems.SelectedIndex;
            };
        }
    }
}
