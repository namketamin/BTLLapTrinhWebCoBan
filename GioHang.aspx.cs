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
    public partial class GioHang : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckLoginStatus();
                LoadGioHang();
            }
        }

        private void CheckLoginStatus()
        {
            if (Session["MaNguoiDung"] != null)
            {
                phChuaDangNhap.Visible = false;
                phDaDangNhap.Visible = true;
                lblTenNguoiDung.Text = Session["FullName"] != null ? Session["FullName"].ToString() : "Bạn";
            }
            else
            {
                Response.Redirect("dangnhap.aspx");
            }
        }

        private void LoadGioHang()
        {
            if (Session["MaNguoiDung"] == null) return;

            int maNguoiDung = Convert.ToInt32(Session["MaNguoiDung"]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT t.MaTour, t.TenTour, t.HinhAnh, t.KhoiHanh, t.ThoiGian, t.GiaTour 
                                 FROM GioHang g
                                 INNER JOIN Tour t ON g.MaTour = t.MaTour
                                 WHERE g.MaNguoiDung = @MaNguoiDung 
                                 ORDER BY g.NgayThem DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            phCartEmpty.Visible = false;
                            phCartItems.Visible = true;

                            rptGioHang.DataSource = dt;
                            rptGioHang.DataBind();
                        }
                        else
                        {
                            phCartEmpty.Visible = true;
                            phCartItems.Visible = false;
                        }
                    }
                }
            }
        }

        protected void rptGioHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                if (Session["MaNguoiDung"] == null) return;

                int maTourCanXoa = Convert.ToInt32(e.CommandArgument);
                int maNguoiDung = Convert.ToInt32(Session["MaNguoiDung"]);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM GioHang WHERE MaNguoiDung = @MaNguoiDung AND MaTour = @MaTour";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaNguoiDung", maNguoiDung);
                        cmd.Parameters.AddWithValue("@MaTour", maTourCanXoa);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadGioHang();
            }
        }

    }
}