using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDuLich
{
    public partial class LienHe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Giả sử khi đăng nhập thành công, bạn lưu Session["FullName"] = "Tên người dùng";
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
        }
        // Xử lý nút Đăng xuất
        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Xóa phiên đăng nhập
            Response.Redirect("index.aspx");
        }
    }
}