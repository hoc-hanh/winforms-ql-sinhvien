using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp2
{
    public partial class LopHanhChinhKhoa : Form
    {
        private HomePage homePage;
        public DataProvider dataProvider = new DataProvider();
        public LopHanhChinhKhoa(HomePage homePage)
        {
            InitializeComponent();
            this.homePage = homePage;
        }

        private void LopHanhChinhKhoa_Load(object sender, EventArgs e)
        {
            DataTable dataTable = new DataTable();
            StringBuilder qry = new StringBuilder("EXEC Select_tenKhoa");
            dataTable = dataProvider.execQuery(qry.ToString());

            foreach (DataRow row in dataTable.Rows)
            {
                comboBox1.Items.Add(row["TenKhoa"]);
            }
        }
    }
}
