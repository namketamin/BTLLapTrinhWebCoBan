using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDuLich
{
    public partial class PromotionLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Lấy danh sách từ Session
                List<KhuyenMai> dsKM =
                    Session["DSKM"] as List<KhuyenMai>;

                // Hiển thị danh sách
                gvKhuyenMai.DataSource = dsKM;
                gvKhuyenMai.DataBind();
            }
        }
        //Bước 1: Ghi Cookie
        //HttpCookie ck = new HttpCookie("Ten");
        //        ck.Value = "Nguyen Van A";
        //ck.Expires = DateTime.Now.AddDays(7);

        //Response.Cookies.Add(ck);


        //Bước 2: Đọc Cookie
        //if (Request.Cookies["Ten"] != null)
        //{
        //    string ten = Request.Cookies["Ten"].Value;
        //    }


        //    Bước 3: Xóa Cookie
        //HttpCookie ck = new HttpCookie("Ten");
        //    ck.Expires = DateTime.Now.AddDays(-1);

        //Response.Cookies.Add(ck);

        //<asp:RadioButton ID = "rdNam" runat="server"
        //    Text="Nam" GroupName="GioiTinh" />
    }
}