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
    public partial class DangNhap : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Xóa thông báo lỗi mỗi lần load lại trang
            if (!IsPostBack)
            {
                lblNotice.Text = "";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Kiểm tra nhập trống
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblNotice.Text = "Vui lòng nhập đầy đủ Email và Mật khẩu!";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Truy vấn kiểm tra Email và Mật khẩu
                    string query = "SELECT MaNguoiDung, HoVaTen, QuyenTruyCap FROM TaiKhoanNguoiDung WHERE Email = @Email AND MatKhau = @MatKhau";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Truyền tham số để chống SQL Injection
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@MatKhau", password);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read()) // Nếu có dữ liệu trả về => Đăng nhập đúng
                            {
                                // Lưu thông tin người dùng vào Session
                                Session["MaNguoiDung"] = reader["MaNguoiDung"];
                                Session["Email"] = email;
                                Session["FullName"] = reader["HoVaTen"].ToString();
                                Session["Role"] = reader["QuyenTruyCap"].ToString(); // Lấy quyền 'Admin' hoặc 'User'

                                // Phân quyền điều hướng
                                if (Session["Role"].ToString() == "Admin")
                                {
                                    // Chuyển hướng tới trang Quản trị viên (bạn cần tạo trang này sau)
                                    Response.Redirect("QuanTri.aspx");
                                }
                                else
                                {
                                    // Chuyển hướng tới trang chủ dành cho Khách (User)
                                    Response.Redirect("index.aspx");
                                }
                            }
                            else
                            {
                                // Sai email hoặc mật khẩu
                                lblNotice.Text = "Tài khoản hoặc mật khẩu không chính xác!";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Bắt lỗi kết nối database
                lblNotice.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }
    }
}