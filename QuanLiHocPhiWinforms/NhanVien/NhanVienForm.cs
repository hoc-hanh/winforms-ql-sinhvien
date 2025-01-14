﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApp2.NhanVien;
using WindowsFormsApp2.SinhVien;

namespace WindowsFormsApp2
{
    public partial class NhanVienForm : Form
    {
        private string maKhoa;
        private string tenKhoa;
        public NhanVienForm(string maKhoa, string tenKhoa)
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

        



        private void NhanVienForm_Load(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection();


            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

            using (connection)
            {
                connection.Open();


                SqlDataAdapter dataAdapter = new SqlDataAdapter("SELECT_NV", connection);
                dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@maKhoa", maKhoa));
                dataAdapter.TableMappings.Add("Table", "NhanVien");
                dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataSet dataset = new DataSet();
                dataAdapter.Fill(dataset);
                DataTable dataTable = dataset.Tables["NhanVien"];

                nhanVienTable.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                
                nhanVienTable.DataSource = dataTable;

            }
        }

        private void updateTable()
        {
            SqlConnection connection = new SqlConnection();


            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

            using (connection)
            {
                connection.Open();
                SqlDataAdapter dataAdapter = new SqlDataAdapter("SELECT_NV", connection);
                dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@maKhoa", maKhoa));
                dataAdapter.TableMappings.Add("Table", "NhanVien");
                dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataSet dataset = new DataSet();
                dataAdapter.Fill(dataset);
                DataTable dataTable = dataset.Tables["NhanVien"];

                nhanVienTable.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

                nhanVienTable.DataSource = dataTable;

            }
        }

     

        private void updateBtn_Click(object sender, EventArgs e)
        {
            bool gioiTinh = true;
            
            CultureInfo provider = CultureInfo.InvariantCulture;
            DateTime NgaySinh = DateTime.ParseExact(dateTimePicker.Value.ToString("dd/MM/yyyy"), "dd/MM/yyyy", provider);
            if (radioBNam.Checked)
            {
                gioiTinh = true;
            }
            else if (radioBNu.Checked)
            {
                gioiTinh = false;
            }

            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

            using (connection)
            {
                connection.Open();

                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "update_NV";
                    command.Parameters.Add(new SqlParameter("@manv", textBoxMaNV.Text));
                    command.Parameters.Add(new SqlParameter("@tenNV", textBoxTenNV.Text));
                    command.Parameters.Add(new SqlParameter("@Nsinh", NgaySinh));
                    command.Parameters.Add(new SqlParameter("@GT", gioiTinh));
                    command.Parameters.Add(new SqlParameter("@CMND", textBoxCCCD.Text));
                    command.Parameters.Add(new SqlParameter("@soDT", textBoxSoDT.Text));
                    command.ExecuteNonQuery();
                }
            }
            updateTable();
        }

        private void deleteBtn_Click(object sender, EventArgs e)
        {
           
            SqlConnection connection = new SqlConnection();


            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

            using (connection)
            {
                connection.Open();

                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "DELETE_NV";
                    command.Parameters.Add(new SqlParameter("@tenNV", textBoxMaNV.Text));
                    command.ExecuteNonQuery();
                }
            }
            updateTable();
        }

        

        private void nhanVienTable_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int row = e.RowIndex;
            textBoxMaNV.Text = nhanVienTable.Rows[row].Cells["Mã Nhân Viên"].Value.ToString();
            textBoxTenNV.Text = nhanVienTable.Rows[row].Cells["Tên Nhân Viên"].Value.ToString();
            textBoxCCCD.Text = nhanVienTable.Rows[row].Cells["CMND"].Value.ToString();
            textBoxSoDT.Text = nhanVienTable.Rows[row].Cells["Số Điện Thoại"].Value.ToString();

            if (nhanVienTable.Rows[row].Cells["Giới Tính"].Value.ToString().Equals("Nam"))
            {
                radioBNam.Checked = true;
            }
            else
            {
                radioBNu.Checked = true;
            }


            
            DateTime NgaySinh = (DateTime)nhanVienTable.Rows[row].Cells["Ngày Sinh"].Value;

            dateTimePicker.Value = NgaySinh;
        }

        private void showAllBtn_Click(object sender, EventArgs e)
        {
            updateTable();
        }

        private void searchBtn_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(searchMaNV.Text))
            {
                SqlConnection connection = new SqlConnection();
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

                using (connection)
                {
                    connection.Open();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter("Search_NV_MaNV", connection);
                    dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@maKhoa", maKhoa));
                    dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@maNV", searchMaNV.Text));
                    dataAdapter.TableMappings.Add("Table", "NhanVien");
                    dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                    DataSet dataset = new DataSet();
                    dataAdapter.Fill(dataset);
                    DataTable dataTable = dataset.Tables["NhanVien"];
                    nhanVienTable.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                    nhanVienTable.DataSource = dataTable;
                }
            }
            else if (!string.IsNullOrEmpty(searchTenNV.Text))
            {
                SqlConnection connection = new SqlConnection();
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

                using (connection)
                {
                    connection.Open();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter("Search_NV_TenNV_NgaySinh", connection);
                    dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@maKhoa", maKhoa));
                    dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@tenNV", searchTenNV.Text));
                    dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@ngaySinh", searchNgaySinh.Value));
                    dataAdapter.TableMappings.Add("Table", "NhanVien");
                    dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                    DataSet dataset = new DataSet();
                    dataAdapter.Fill(dataset);
                    DataTable dataTable = dataset.Tables["NhanVien"];
                    nhanVienTable.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                    nhanVienTable.DataSource = dataTable;
                }
            }
        }

        private void baoCaoBtn_Click(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;

            using (connection)
            {
                connection.Open();
                SqlDataAdapter dataAdapter = new SqlDataAdapter("Select_NV_Report", connection);
                dataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                dataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@maKhoa", maKhoa));
               
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);
                NhanVienReport nhanVienReport = new NhanVienReport();
                nhanVienReport.SetDataSource(dataTable);
                ReportViewer chiTietHoaDonFormView = new ReportViewer();
                chiTietHoaDonFormView.crystalReportViewer1.ReportSource = nhanVienReport;
                chiTietHoaDonFormView.Show();
            }
        }

        private void addBtn_Click_1(object sender, EventArgs e)
        {
            //DateTime date = DateTime.Now;
            //TimeSpan dateDiff = date.Subtract(dateTimePicker.Value);
            //int tuoi = dateDiff.Days;
            //if (currentDate.Month < birthDate.Month || (currentDate.Month == birthDate.Month && currentDate.Day < birthDate.Day))
            //{
            //    age--;
            //}
            //MessageBox.Show(tuoi.ToString());
            bool gioiTinh = true;

            CultureInfo provider = CultureInfo.InvariantCulture;
            DateTime NgaySinh = DateTime.ParseExact(dateTimePicker.Value.ToString("dd/MM/yyyy"), "dd/MM/yyyy", provider);
            if (radioBNam.Checked)
            {
                gioiTinh = true;
            }
            else if (radioBNu.Checked)
            {
                gioiTinh = false;
            }

            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["QlHocPhiConnectionString"].ConnectionString;
            using (connection)
            {
                connection.Open();
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "insert_NV";
                    command.Parameters.Add(new SqlParameter("@manv", textBoxMaNV.Text));
                    command.Parameters.Add(new SqlParameter("@tenNV", textBoxTenNV.Text));
                    command.Parameters.Add(new SqlParameter("@makhoa", maKhoa));
                    command.Parameters.Add(new SqlParameter("@Nsinh", NgaySinh));
                    command.Parameters.Add(new SqlParameter("@GT", gioiTinh));
                    command.Parameters.Add(new SqlParameter("@CMND", textBoxCCCD.Text));
                    command.Parameters.Add(new SqlParameter("@soDT", textBoxSoDT.Text));


                    try
                    {
                        //  Block of code to try
                        command.ExecuteNonQuery();
                    }
                    catch (Exception error)
                    {
                        MessageBox.Show("Lỗi: Mã Nhân Viên đã có.");
                        //  Block of code to handle errors
                    }



                }
            }

            updateTable();
        }
    }
}
