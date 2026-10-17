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
    public partial class QuanTri : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Kiểm tra chưa đăng nhập thì đá về trang đăng nhập
            if (Session["Email"] == null)
            {
                Response.Redirect("dangnhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Hiển thị tên trên header và bật trạng thái đã đăng nhập
                if (Session["FullName"] != null)
                {
                    lblTenNguoiDung.Text = Session["FullName"].ToString();
                    phDaDangNhap.Visible = true;
                    phChuaDangNhap.Visible = false;
                }

                // 2. Phân quyền hiển thị Menu
                if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
                {
                    phAdminMenu.Visible = true; // Bật menu admin
                }

                // 3. Load thông tin người dùng từ Database
                LoadThongTinNguoiDung();
            }
        }

        private void LoadThongTinNguoiDung()
        {
            string email = Session["Email"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT HoVaTen, Email, SoDienThoai, QuyenTruyCap FROM TaiKhoanNguoiDung WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Đổ dữ liệu vào các ô textbox
                            txtHoTen.Text = reader["HoVaTen"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtSoDienThoai.Text = reader["SoDienThoai"].ToString();
                            txtQuyen.Text = reader["QuyenTruyCap"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            string email = Session["Email"].ToString();
            string hoTenMoi = txtHoTen.Text.Trim();
            string sdtMoi = txtSoDienThoai.Text.Trim();

            if (string.IsNullOrEmpty(hoTenMoi) || string.IsNullOrEmpty(sdtMoi))
            {
                lblThongBao.Text = "Vui lòng không để trống Họ tên và Số điện thoại!";
                lblThongBao.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE TaiKhoanNguoiDung SET HoVaTen = @HoTen, SoDienThoai = @SDT WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@HoTen", hoTenMoi);
                    cmd.Parameters.AddWithValue("@SDT", sdtMoi);
                    cmd.Parameters.AddWithValue("@Email", email);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    // Cập nhật lại Session tên phòng trường hợp họ đổi tên
                    Session["FullName"] = hoTenMoi;
                    lblTenNguoiDung.Text = hoTenMoi;

                    lblThongBao.Text = "Cập nhật thông tin thành công!";
                    lblThongBao.ForeColor = System.Drawing.Color.Green;
                }
            }
        }

        // Xử lý sự kiện bấm Nút Đăng Xuất dạng khối ở góc dưới
        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Xóa sạch mọi phiên đăng nhập
            Response.Redirect("index.aspx");
        }

    }
}