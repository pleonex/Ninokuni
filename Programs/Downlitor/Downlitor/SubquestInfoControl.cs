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
        private DlcItem dlc;

        public SubquestInfoControl(DlcItem dlc)
        {
            InitializeComponent();
            this.dlc = dlc;
        }
    }
}
