﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp2
{
    public partial class LopHanhChinhForm : Form
    {
        private string maKhoa;
        private string tenKhoa;
        public DataProvider dataProvider = new DataProvider();
        
        public LopHanhChinhForm(string maKhoa, string tenKhoa)
        {
            InitializeComponent();
            AutoScaleMode = AutoScaleMode.Inherit;

            // Set the Dock property to Fill.
            Dock = DockStyle.Fill;

            // Set the Anchor property to Top, Bottom, Left, and Right.
            Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            this.maKhoa = maKhoa;
            this.tenKhoa = tenKhoa;
        }

        private void KhoaForm_Load(object sender, EventArgs e)
        {
            tenKhoaTxt.Text = tenKhoa;
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

            using (connection)
            {
                connection.Open();


                SqlDataAdapter dataAdapter = new SqlDataAdapter("Select_Lop", connection);

                dataAdapter.TableMappings.Add("Table", "Lop");
                dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@maKhoa", maKhoa));

                DataSet dataset = new DataSet();
                dataAdapter.Fill(dataset);
                DataTable dataTable = dataset.Tables["Lop"];

                khoaTable.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

                khoaTable.DataSource = dataTable;
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {

            
        }

        private void searchBtn_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox2.Text.Equals(""))
            {
                MessageBox.Show("Mã khoa đang để trống");
                return;
            }
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

            using (connection)
            {
                connection.Open();


                SqlDataAdapter dataAdapter = new SqlDataAdapter("Select_Lop_Theo_Ten_Khoa", connection);

                dataAdapter.TableMappings.Add("Table", "LopHanhChinh");
                dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@tenKhoa", textBox2.Text));

                DataSet dataset = new DataSet();
                dataAdapter.Fill(dataset);
                DataTable dataTable = dataset.Tables["LopHanhChinh"];
                if (dataTable.Rows.Count == 0 ) {
                    MessageBox.Show("Không tìm thấy lớp hành chính trong khoa này");
                }
                //DataTable dataTable = new DataTable();
                //dataTable.Da
                khoaTable.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

                khoaTable.DataSource = dataTable;
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string tenKhoa = comboBox1.Text;

        }
    }
}
