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
    }
}