using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDuLich
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaNguoiDung"] == null)
            {
                Response.Redirect("dangnhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadThongTinTaiKhoan();
                LoadChiTietTour();
            }
        }

        private void LoadThongTinTaiKhoan()
        {
            int maNguoiDung = Convert.ToInt32(Session["MaNguoiDung"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT HoVaTen, Email, SoDienThoai FROM TaiKhoanNguoiDung WHERE MaNguoiDung = @MaND";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MaND", maNguoiDung);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtHoTen.Text = reader["HoVaTen"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtSDT.Text = reader["SoDienThoai"].ToString();
                        }
                    }
                }
            }
        }

        private void LoadChiTietTour()
        {
            string idQuery = Request.QueryString["id"];
            int maTour = 0;

            if (int.TryParse(idQuery, out maTour))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT TenTour, HinhAnh, GiaTour FROM Tour WHERE MaTour = @MaTour";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaTour", maTour);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblTenTour.Text = reader["TenTour"].ToString();
                                imgTour.ImageUrl = reader["HinhAnh"].ToString();

                                decimal giaGoc = Convert.ToDecimal(reader["GiaTour"]);
                                lblGiaTour.Text = giaGoc.ToString("N0");
                                hfGiaGoc.Value = giaGoc.ToString("0");
                            }
                            else
                            {
                                Response.Redirect("danhsachtour.aspx");
                            }
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("danhsachtour.aspx");
            }
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            try
            {
                int maNguoiDung = Convert.ToInt32(Session["MaNguoiDung"]);
                int maTour = Convert.ToInt32(Request.QueryString["id"]);

                int soKhach = 1;
                int.TryParse(txtSoKhach.Text, out soKhach);

                string diaChi = txtDiaChi.Text.Trim();
                string ghiChu = txtGhiChu.Text.Trim();
                string phuongThuc = rblThanhToan.SelectedValue == "ChuyenKhoan" ? "Chuyển khoản" : "Tiền mặt";

                // Tính toán tổng tiền chính xác ở Server
                decimal giaGoc = Convert.ToDecimal(hfGiaGoc.Value);
                int phanTramGiam = 0;
                int.TryParse(hfPhanTRAMGiam.Value, out phanTramGiam);

                decimal tamTinh = giaGoc * soKhach;
                decimal giamGia = (tamTinh * phanTramGiam) / 100;
                decimal tongTien = tamTinh - giamGia;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Thêm thông tin đơn hàng (Lưu cả Ghi chú nếu bảng DonHang của bạn có cột GhiChu)
                    string insertQuery = @"INSERT INTO DonHang (MaNguoiDung, MaTour, SoKhach, DiaChi, PhuongThucThanhToan, TongTien) 
                                           VALUES (@MaNguoiDung, @MaTour, @SoKhach, @DiaChi, @PT, @TongTien)";
                    using (SqlCommand cmdInsert = new SqlCommand(insertQuery, conn))
                    {
                        cmdInsert.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);
                        cmdInsert.Parameters.AddWithValue("@MaTour", maTour);
                        cmdInsert.Parameters.AddWithValue("@SoKhach", soKhach);
                        cmdInsert.Parameters.AddWithValue("@DiaChi", diaChi);
                        cmdInsert.Parameters.AddWithValue("@PT", phuongThuc);
                        cmdInsert.Parameters.AddWithValue("@TongTien", tongTien);

                        cmdInsert.ExecuteNonQuery();
                    }

                    // Xóa tour này khỏi bảng Giỏ Hàng
                    string deleteCart = "DELETE FROM GioHang WHERE MaNguoiDung = @MaNguoiDung AND MaTour = @MaTour";
                    using (SqlCommand cmdDelete = new SqlCommand(deleteCart, conn))
                    {
                        cmdDelete.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);
                        cmdDelete.Parameters.AddWithValue("@MaTour", maTour);
                        cmdDelete.ExecuteNonQuery();
                    }
                }

                string alertMsg = "Đặt tour thành công! Cảm ơn bạn đã tin tưởng VietGo.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('{alertMsg}'); window.location.href='QuanTri.aspx';", true);
            }
            catch (Exception ex)
            {
                lblBaoLoi.Text = "Lỗi xử lý đặt hàng: " + ex.Message;
            }
        }
    }
}