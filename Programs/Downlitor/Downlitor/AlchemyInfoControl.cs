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
    public partial class AlchemyInfoControl : UserControl
    {
        public AlchemyInfoControl(DlcItem dlc)
        {
            InitializeComponent();
            comboRecipe.Format += delegate(object sender, ListControlConvertEventArgs e) {
                var recipe = (AlchemyRecipe)e.ListItem;
                if (recipe.Name != null)
                    e.Value = recipe.Name;
                else
                    e.Value = "Invalid";
            };

            var manager = AlchemyManager.Instance;
            for (int i = 0; i < manager.NumEntries; i++)
                comboRecipe.Items.Add(manager[i]);

            comboRecipe.AutoCompleteMode = AutoCompleteMode.Suggest;
            comboRecipe.AutoCompleteSource = AutoCompleteSource.ListItems;
            comboRecipe.SelectedIndex = dlc.Index;
            UpdateIngredients();

            comboRecipe.SelectedIndexChanged += delegate {
                if ((string)comboRecipe.SelectedItem == "Invalid")
                    return;

                dlc.Index = (ushort)comboRecipe.SelectedIndex;
                UpdateIngredients();
            };
        }

        private void UpdateIngredients()
        {
            listIngredient.Items.Clear();

            var recipe = (AlchemyRecipe)comboRecipe.SelectedItem;
            listIngredient.Items.Add(recipe.Ingredient1);

            if (recipe.Ingredient2.Quantity > 0)
                listIngredient.Items.Add(recipe.Ingredient2);

            if (recipe.Ingredient3.Quantity > 0)
                listIngredient.Items.Add(recipe.Ingredient3);
        }
    }
}
