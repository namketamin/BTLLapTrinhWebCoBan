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
    public partial class DangKy : System.Web.UI.Page
    {
        // Nhớ thay đổi TÊN_SERVER_CỦA_BẠN bằng Server Name thực tế trong SQL Server (VD: LAPTOP-2QP...)
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblNotice.Text = "";
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string hoTen = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string sdt = txtPhone.Text.Trim();
            string matKhau = txtPassword.Text;
            string xacNhanMatKhau = txtConfirmPassword.Text;

            // 1. Kiểm tra các điều kiện (Validation)
            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(sdt) || string.IsNullOrEmpty(matKhau))
            {
                ShowError("Vui lòng nhập đầy đủ thông tin!");
                return;
            }

            if (matKhau != xacNhanMatKhau)
            {
                ShowError("Mật khẩu xác nhận không khớp!");
                return;
            }

            if (matKhau.Length < 6)
            {
                ShowError("Mật khẩu phải có ít nhất 6 ký tự!");
                return;
            }

            if (!chkAgreeTerms.Checked)
            {
                ShowError("Bạn phải đồng ý với các điều khoản sử dụng!");
                return;
            }

            // 2. Lưu vào Database
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // 2.1 Kiểm tra xem Email đã tồn tại chưa
                    string checkQuery = "SELECT COUNT(*) FROM TaiKhoanNguoiDung WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", email);
                        int count = (int)checkCmd.ExecuteScalar(); // Lấy số lượng email bị trùng

                        if (count > 0)
                        {
                            ShowError("Email này đã được đăng ký. Vui lòng sử dụng email khác hoặc Đăng nhập!");
                            return;
                        }
                    }

                    // 2.2 Nếu Email chưa tồn tại, tiến hành lưu tài khoản mới
                    string insertQuery = @"INSERT INTO TaiKhoanNguoiDung (HoVaTen, Email, SoDienThoai, MatKhau, QuyenTruyCap) 
                                           VALUES (@HoTen, @Email, @SDT, @MatKhau, 'User')";

                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@HoTen", hoTen);
                        insertCmd.Parameters.AddWithValue("@Email", email);
                        insertCmd.Parameters.AddWithValue("@SDT", sdt);
                        insertCmd.Parameters.AddWithValue("@MatKhau", matKhau);
                        // *Lưu ý*: Trong thực tế bạn phải hash (băm) mật khẩu trước khi lưu.
                        // Ở đây làm đồ án cơ bản nên lưu trực tiếp.

                        insertCmd.ExecuteNonQuery();

                        // Xóa trắng form và báo thành công
                        ClearForm();
                        lblNotice.Text = "Đăng ký tài khoản thành công! Vui lòng <a href='DangNhap.aspx'>Đăng nhập</a>.";
                        lblNotice.ForeColor = System.Drawing.Color.Green;
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Lỗi hệ thống: " + ex.Message);
            }
        }

        // Hàm phụ để hiển thị lỗi màu đỏ cho gọn code
        private void ShowError(string message)
        {
            lblNotice.Text = message;
            lblNotice.ForeColor = System.Drawing.Color.Red;
        }

        // Hàm phụ để xóa trắng form sau khi đăng ký thành công
        private void ClearForm()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            chkAgreeTerms.Checked = false;
            // Không cần xóa mật khẩu vì TextMode="Password" tự động làm trắng khi load lại
        }
    }
}