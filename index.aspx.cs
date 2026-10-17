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
    public partial class index : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra trạng thái đăng nhập
                CheckLoginStatus();

                // Load dữ liệu Tour nổi bật
                LoadTourNoiBat();
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

        private void LoadTourNoiBat()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Lấy 3 tour đang mở bán (TrangThai = 1), sắp xếp mới nhất lên đầu
                string query = "SELECT TOP 3 MaTour, TenTour, DiaDiem, HinhAnh, ThoiGian, GiaTour, MoTaNgan FROM Tour WHERE TrangThai = 1 ORDER BY NgayTao DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Đổ dữ liệu vào Repeater trên giao diện
                        rptTourNoiBat.DataSource = dt;
                        rptTourNoiBat.DataBind();
                    }
                }
            }
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("index.aspx");
        }
    }
}