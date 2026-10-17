using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDuLich
{
    public partial class ChiTietTour : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckLoginStatus();

                string idQuery = Request.QueryString["id"];
                int maTour = 0;

                if (!string.IsNullOrEmpty(idQuery) && int.TryParse(idQuery, out maTour))
                {
                    LoadChiTietTour(maTour);
                }
                else
                {
                    Response.Redirect("danhsachtour.aspx");
                }
            }
        }

        private void CheckLoginStatus()
        {
            if (Session["FullName"] != null)
            {
                phChuaDangNhap.Visible = false;
                phDaDangNhap.Visible = true;
                lblTenNguoiDung.Text = Session["FullName"].ToString();
            }
            else
            {
                phChuaDangNhap.Visible = true;
                phDaDangNhap.Visible = false;
            }
        }

        private void LoadChiTietTour(int maTour)
        {
            string diaDiemTour = "";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Tour WHERE MaTour = @MaTour AND TrangThai = 1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MaTour", maTour);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string tenTour = reader["TenTour"].ToString();
                            diaDiemTour = reader["DiaDiem"].ToString();

                            lblBreadcrumb.Text = "Tour " + diaDiemTour;
                            lblTenTour.Text = tenTour;
                            lblDiaDiemTop.Text = diaDiemTour.ToUpper();
                            imgTour.ImageUrl = reader["HinhAnh"].ToString();
                            imgTour.AlternateText = tenTour;
                            lblMoTaNgan.Text = reader["MoTaNgan"].ToString();

                            lblThoiGian.Text = reader["ThoiGian"].ToString();
                            lblSideThoiGian.Text = reader["ThoiGian"].ToString();

                            lblPhuongTien.Text = reader["PhuongTien"].ToString();
                            lblSidePhuongTien.Text = reader["PhuongTien"].ToString();

                            lblKhoiHanh.Text = reader["KhoiHanh"].ToString();
                            lblSideDiaDiem.Text = diaDiemTour;

                            decimal giaTour = Convert.ToDecimal(reader["GiaTour"]);
                            lblGiaTour.Text = giaTour.ToString("N0");

                            litDiemNoiBat.Text = reader["DiemNoiBat"].ToString();
                            litLichTrinh.Text = reader["LichTrinh"].ToString();
                            litDichVuBaoGom.Text = reader["DichVuBaoGom"].ToString();
                        }
                        else
                        {
                            Response.Redirect("danhsachtour.aspx");
                        }
                    }
                }

                if (!string.IsNullOrEmpty(diaDiemTour))
                {
                    string queryLienQuan = "SELECT TOP 3 MaTour, TenTour, DiaDiem, HinhAnh, GiaTour FROM Tour WHERE DiaDiem = @DiaDiem AND MaTour != @MaTourHienTai AND TrangThai = 1 ORDER BY NEWID()";
                    using (SqlCommand cmdLQ = new SqlCommand(queryLienQuan, conn))
                    {
                        cmdLQ.Parameters.AddWithValue("@DiaDiem", diaDiemTour);
                        cmdLQ.Parameters.AddWithValue("@MaTourHienTai", maTour);

                        using (SqlDataAdapter da = new SqlDataAdapter(cmdLQ))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            rptTourLienQuan.DataSource = dt;
                            rptTourLienQuan.DataBind();
                        }
                    }
                }
            }
        }

        protected void btnThemGioHang_Click(object sender, EventArgs e)
        {
            if (Session["MaNguoiDung"] == null)
            {
                Response.Redirect("dangnhap.aspx");
                return;
            }

            int maTour = 0;
            if (int.TryParse(Request.QueryString["id"], out maTour))
            {
                int maNguoiDung = Convert.ToInt32(Session["MaNguoiDung"]);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string checkQuery = "SELECT COUNT(*) FROM GioHang WHERE MaNguoiDung = @MaNguoiDung AND MaTour = @MaTour";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);
                        checkCmd.Parameters.AddWithValue("@MaTour", maTour);
                        int count = (int)checkCmd.ExecuteScalar();

                        if (count == 0)
                        {
                            string insertQuery = "INSERT INTO GioHang (MaNguoiDung, MaTour) VALUES (@MaNguoiDung, @MaTour)";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);
                                insertCmd.Parameters.AddWithValue("@MaTour", maTour);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
                Response.Redirect("giohang.aspx");
            }
        }

    }
}