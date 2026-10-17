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
    public partial class DanhSachTour : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["KetNoiSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckLoginStatus();
                LoadDiaDiem(); // Tải danh sách địa điểm vào DropDownList

                // 1. Đọc các tham số từ URL (GET)
                string keyword = Request.QueryString["keyword"] ?? "";
                string location = Request.QueryString["location"] ?? "";
                string mucGia = Request.QueryString["price"] ?? "";
                string sapXep = Request.QueryString["sort"] ?? "";

                // 2. Gán ngược lại giá trị lên các ô lọc trên giao diện
                txtSearch.Text = keyword;
                if (ddlLocation.Items.FindByValue(location) != null)
                    ddlLocation.SelectedValue = location;

                if (ddlGia.Items.FindByValue(mucGia) != null)
                    ddlGia.SelectedValue = mucGia;

                if (ddlSapXep.Items.FindByValue(sapXep) != null)
                    ddlSapXep.SelectedValue = sapXep;

                // 3. Tải danh sách tour dựa trên bộ lọc
                LoadDanhSachTour(keyword, location, mucGia, sapXep);
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

        private void LoadDiaDiem()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT DISTINCT DiaDiem FROM Tour WHERE TrangThai = 1 AND DiaDiem IS NOT NULL";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        HashSet<string> danhSachDiaDiem = new HashSet<string>();

                        while (reader.Read())
                        {
                            string rawDiaDiem = reader["DiaDiem"].ToString();
                            string[] arr = rawDiaDiem.Split(',');
                            foreach (string item in arr)
                            {
                                string diaDiemChuan = item.Trim();
                                if (!string.IsNullOrEmpty(diaDiemChuan))
                                {
                                    danhSachDiaDiem.Add(diaDiemChuan);
                                }
                            }
                        }

                        ddlLocation.Items.Clear();
                        ddlLocation.Items.Add(new ListItem("Tất cả địa điểm", ""));

                        foreach (string diaDiem in danhSachDiaDiem)
                        {
                            ddlLocation.Items.Add(new ListItem(diaDiem, diaDiem));
                        }
                    }
                }
            }
        }

        private void LoadDanhSachTour(string keyword, string location, string mucGia, string sapXep)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT MaTour, TenTour, DiaDiem, HinhAnh, ThoiGian, KhoiHanh, GiaTour FROM Tour WHERE TrangThai = 1 ";

                if (!string.IsNullOrEmpty(keyword))
                {
                    query += " AND TenTour LIKE @Keyword ";
                }

                if (!string.IsNullOrEmpty(location))
                {
                    query += " AND (DiaDiem LIKE @Location OR TenTour LIKE @Location) ";
                }

                if (mucGia == "Duoi2Trieu")
                {
                    query += " AND GiaTour < 2000000 ";
                }
                else if (mucGia == "Tu2Den4Trieu")
                {
                    query += " AND GiaTour >= 2000000 AND GiaTour <= 4000000 ";
                }
                else if (mucGia == "Tren4Trieu")
                {
                    query += " AND GiaTour > 4000000 ";
                }

                if (sapXep == "GiaTangDan")
                {
                    query += " ORDER BY GiaTour ASC ";
                }
                else if (sapXep == "GiaGiamDan")
                {
                    query += " ORDER BY GiaTour DESC ";
                }
                else
                {
                    query += " ORDER BY NgayTao DESC ";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(keyword))
                    {
                        cmd.Parameters.AddWithValue("@Keyword", "%" + keyword + "%");
                    }
                    if (!string.IsNullOrEmpty(location))
                    {
                        cmd.Parameters.AddWithValue("@Location", "%" + location + "%");
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            resultCount.InnerText = "Có tổng cộng " + dt.Rows.Count + " tour";
                            noTour.Visible = false;

                            // Lấy số trang hiện tại từ URL (mặc định trang 1)
                            int page = 1;
                            if (Request.QueryString["page"] != null)
                            {
                                int.TryParse(Request.QueryString["page"], out page);
                            }

                            PagedDataSource pds = new PagedDataSource();
                            pds.DataSource = dt.DefaultView;
                            pds.AllowPaging = true;
                            pds.PageSize = 6;

                            if (page < 1) page = 1;
                            if (page > pds.PageCount) page = pds.PageCount;

                            pds.CurrentPageIndex = page - 1;

                            // Tạo URL cơ sở để giữ nguyên bộ lọc khi phân trang
                            string baseUrl = $"DanhSachTour.aspx?keyword={Server.UrlEncode(keyword)}&location={Server.UrlEncode(location)}&price={mucGia}&sort={sapXep}";

                            // Nút Trước
                            if (!pds.IsFirstPage)
                            {
                                lnkPrev.NavigateUrl = baseUrl + $"&page={page - 1}";
                                lnkPrev.Visible = true;
                            }
                            else
                            {
                                lnkPrev.Visible = false;
                            }

                            // Nút Sau
                            if (!pds.IsLastPage)
                            {
                                lnkNext.NavigateUrl = baseUrl + $"&page={page + 1}";
                                lnkNext.Visible = true;
                            }
                            else
                            {
                                lnkNext.Visible = false;
                            }

                            lblCurrentPage.Text = page.ToString();
                            lblTotalPages.Text = pds.PageCount.ToString();

                            rptDanhSachTour.DataSource = pds;
                            rptDanhSachTour.DataBind();
                        }
                        else
                        {
                            rptDanhSachTour.DataSource = new DataTable();
                            rptDanhSachTour.DataBind();

                            resultCount.InnerText = "";
                            noTour.Visible = true;
                            lnkPrev.Visible = false;
                            lnkNext.Visible = false;
                            lblCurrentPage.Text = "0";
                            lblTotalPages.Text = "0";
                        }
                    }
                }
            }
        }

        // Khi bấm nút Tìm kiếm -> Gom dữ liệu đẩy lên URL dạng GET
        //protected void btnSearch_Click(object sender, EventArgs e)
        //{
        //    string keyword = Server.UrlEncode(txtSearch.Text.Trim());
        //    string location = Server.UrlEncode(ddlLocation.SelectedValue);
        //    string mucGia = ddlGia.SelectedValue;
        //    string sapXep = ddlSapXep.SelectedValue;

        //    Response.Redirect($"DanhSachTour.aspx?keyword={keyword}&location={location}&price={mucGia}&sort={sapXep}&page=1");
        //}

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("index.aspx");
        }
    }
}