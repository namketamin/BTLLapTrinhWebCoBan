using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDuLich
{
    public partial class QuanLyTour : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("dangnhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblTenNguoiDung.Text = Session["FullName"]?.ToString() ?? "Admin";
                LoadDanhSachTour();
            }
        }

        private void LoadDanhSachTour()
        {
            string keyword = Request.QueryString["keyword"] ?? "";
            string location = Request.QueryString["location"] ?? "";
            string price = Request.QueryString["price"] ?? "";
            string sort = Request.QueryString["sort"] ?? "MoiNhat";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT MaTour, TenTour, DiaDiem, GiaTour, HinhAnh, TrangThai FROM Tour WHERE 1=1";

                if (!string.IsNullOrEmpty(keyword)) query += " AND TenTour LIKE @Keyword";
                if (!string.IsNullOrEmpty(location)) query += " AND DiaDiem = @Location";

                if (price == "Duoi2Trieu") query += " AND GiaTour < 2000000";
                else if (price == "Tu2Den4Trieu") query += " AND GiaTour >= 2000000 AND GiaTour <= 4000000";
                else if (price == "Tren4Trieu") query += " AND GiaTour > 4000000";

                if (sort == "GiaTangDan") query += " ORDER BY GiaTour ASC";
                else if (sort == "GiaGiamDan") query += " ORDER BY GiaTour DESC";
                else query += " ORDER BY MaTour DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(keyword)) cmd.Parameters.AddWithValue("@Keyword", "%" + keyword + "%");
                    if (!string.IsNullOrEmpty(location)) cmd.Parameters.AddWithValue("@Location", location);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvTour.DataSource = dt;
                        gvTour.DataBind();
                    }
                }
            }
        }

        protected void gvTour_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int maTour = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Sua")
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT * FROM Tour WHERE MaTour = @MaTour";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaTour", maTour);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtTenTour.Text = reader["TenTour"].ToString();
                                txtDiaDiem.Text = reader["DiaDiem"].ToString();
                                txtMoTaNgan.Text = reader["MoTaNgan"].ToString();
                                txtThoiGian.Text = reader["ThoiGian"].ToString();
                                txtPhuongTien.Text = reader["PhuongTien"].ToString();
                                txtKhoiHanh.Text = reader["KhoiHanh"].ToString();
                                txtGiaTour.Text = Convert.ToDecimal(reader["GiaTour"]).ToString("0");
                                txtDiemNoiBat.Text = reader["DiemNoiBat"].ToString();
                                txtLichTrinh.Text = reader["LichTrinh"].ToString();
                                txtDichVuBaoGom.Text = reader["DichVuBaoGom"].ToString();
                                ddlTrangThai.SelectedValue = reader["TrangThai"].ToString();

                                // Đưa link ảnh cũ vào biến ẩn và hiển thị Preview lên form
                                string hinhAnhCu = reader["HinhAnh"].ToString();
                                hfHinhAnhCu.Value = hinhAnhCu;
                                imgPreview.ImageUrl = hinhAnhCu;
                                imgPreview.Style["display"] = "block"; // Hiển thị thẻ <img>

                                hfMaTour.Value = maTour.ToString();
                                lblTieuDeForm.Text = "Chỉnh sửa Tour";

                                ClientScript.RegisterStartupScript(this.GetType(), "OpenModal", "openModal();", true);
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "Xoa")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "DELETE FROM Tour WHERE MaTour = @MaTour";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@MaTour", maTour);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                    lblThongBao.Text = "Xóa tour thành công!";
                    lblThongBao.ForeColor = System.Drawing.Color.Green;
                    LoadDanhSachTour();
                }
                catch
                {
                    lblThongBao.Text = "Không thể xóa do ràng buộc dữ liệu! Hãy thử chuyển trạng thái về Ẩn.";
                    lblThongBao.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void btnLuuTour_Click(object sender, EventArgs e)
        {
            // === XỬ LÝ UPLOAD ẢNH ===
            string hinhAnh = hfHinhAnhCu.Value; // Mặc định giữ đường dẫn ảnh cũ
            if (fileHinhAnh.HasFile)
            {
                try
                {
                    // Lấy tên gốc của file
                    string fileName = Path.GetFileName(fileHinhAnh.FileName);
                    // Ghép thêm chuỗi thời gian để tên file không bao giờ bị trùng nhau
                    fileName = DateTime.Now.ToString("yyyyMMdd_HHmmss_") + fileName;

                    // Đường dẫn vật lý trên server (Tạo folder nếu chưa có)
                    string folderPath = Server.MapPath("~/images/tours/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    // Lưu file vào máy
                    fileHinhAnh.SaveAs(folderPath + fileName);

                    // Lấy đường dẫn tương đối lưu vào Database
                    hinhAnh = "images/tours/" + fileName;
                }
                catch (Exception ex)
                {
                    lblThongBao.Text = "Lỗi khi upload ảnh: " + ex.Message;
                    lblThongBao.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }
            else if (string.IsNullOrEmpty(hfMaTour.Value) && string.IsNullOrEmpty(hinhAnh))
            {
                // Nếu là Thêm Mới mà quên không up ảnh, gắn tạm cái ảnh mặc định tránh lỗi DB
                hinhAnh = "images/default-tour.jpg";
            }
            // =========================

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                if (string.IsNullOrEmpty(hfMaTour.Value))
                {
                    string query = @"INSERT INTO Tour (TenTour, DiaDiem, HinhAnh, MoTaNgan, ThoiGian, PhuongTien, KhoiHanh, GiaTour, DiemNoiBat, LichTrinh, DichVuBaoGom, TrangThai, NgayTao) 
                                     VALUES (@TenTour, @DiaDiem, @HinhAnh, @MoTaNgan, @ThoiGian, @PhuongTien, @KhoiHanh, @GiaTour, @DiemNoiBat, @LichTrinh, @DichVuBaoGom, @TrangThai, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TenTour", txtTenTour.Text.Trim());
                        cmd.Parameters.AddWithValue("@DiaDiem", txtDiaDiem.Text.Trim());
                        cmd.Parameters.AddWithValue("@HinhAnh", hinhAnh);
                        cmd.Parameters.AddWithValue("@MoTaNgan", txtMoTaNgan.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThoiGian", txtThoiGian.Text.Trim());
                        cmd.Parameters.AddWithValue("@PhuongTien", txtPhuongTien.Text.Trim());
                        cmd.Parameters.AddWithValue("@KhoiHanh", txtKhoiHanh.Text.Trim());
                        cmd.Parameters.AddWithValue("@GiaTour", Convert.ToDecimal(txtGiaTour.Text.Trim()));
                        cmd.Parameters.AddWithValue("@DiemNoiBat", txtDiemNoiBat.Text.Trim());
                        cmd.Parameters.AddWithValue("@LichTrinh", txtLichTrinh.Text.Trim());
                        cmd.Parameters.AddWithValue("@DichVuBaoGom", txtDichVuBaoGom.Text.Trim());
                        cmd.Parameters.AddWithValue("@TrangThai", Convert.ToInt32(ddlTrangThai.SelectedValue));
                        cmd.ExecuteNonQuery();
                    }
                    lblThongBao.Text = "Thêm Tour mới thành công!";
                }
                else
                {
                    string query = @"UPDATE Tour SET 
                                        TenTour=@TenTour, DiaDiem=@DiaDiem, HinhAnh=@HinhAnh, MoTaNgan=@MoTaNgan, 
                                        ThoiGian=@ThoiGian, PhuongTien=@PhuongTien, KhoiHanh=@KhoiHanh, GiaTour=@GiaTour, 
                                        DiemNoiBat=@DiemNoiBat, LichTrinh=@LichTrinh, DichVuBaoGom=@DichVuBaoGom, TrangThai=@TrangThai 
                                     WHERE MaTour=@MaTour";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TenTour", txtTenTour.Text.Trim());
                        cmd.Parameters.AddWithValue("@DiaDiem", txtDiaDiem.Text.Trim());
                        cmd.Parameters.AddWithValue("@HinhAnh", hinhAnh); // Lấy ảnh mới up hoặc giữ ảnh cũ
                        cmd.Parameters.AddWithValue("@MoTaNgan", txtMoTaNgan.Text.Trim());
                        cmd.Parameters.AddWithValue("@ThoiGian", txtThoiGian.Text.Trim());
                        cmd.Parameters.AddWithValue("@PhuongTien", txtPhuongTien.Text.Trim());
                        cmd.Parameters.AddWithValue("@KhoiHanh", txtKhoiHanh.Text.Trim());
                        cmd.Parameters.AddWithValue("@GiaTour", Convert.ToDecimal(txtGiaTour.Text.Trim()));
                        cmd.Parameters.AddWithValue("@DiemNoiBat", txtDiemNoiBat.Text.Trim());
                        cmd.Parameters.AddWithValue("@LichTrinh", txtLichTrinh.Text.Trim());
                        cmd.Parameters.AddWithValue("@DichVuBaoGom", txtDichVuBaoGom.Text.Trim());
                        cmd.Parameters.AddWithValue("@TrangThai", Convert.ToInt32(ddlTrangThai.SelectedValue));
                        cmd.Parameters.AddWithValue("@MaTour", hfMaTour.Value);
                        cmd.ExecuteNonQuery();
                    }
                    lblThongBao.Text = "Cập nhật thông tin Tour thành công!";
                }
            }

            lblThongBao.ForeColor = System.Drawing.Color.Green;
            LoadDanhSachTour();
            ClientScript.RegisterStartupScript(this.GetType(), "CloseModal", "closeModal();", true);
        }
    }
}