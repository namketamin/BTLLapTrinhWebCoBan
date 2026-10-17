<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DanhSachTour.aspx.cs" Inherits="WebDuLich.DanhSachTour" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách tour - VietGo</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <!-- Header -->
        <header class="header">
            <div class="container header-content">
                <a href="index.aspx" class="logo">Viet<span>Go</span></a>

                <nav class="navbar" id="navbar">
                    <a href="index.aspx">Trang chủ</a>
                    <a href="danhsachtour.aspx" class="active">Danh sách tour</a>
                    <a href="gioithieu.aspx">Giới thiệu</a>
                    <a href="lienhe.aspx">Liên hệ</a>
                </nav>

                <div class="header-actions">
                    <!-- 1. Trạng thái CHƯA đăng nhập -->
                    <asp:PlaceHolder ID="phChuaDangNhap" runat="server">
                        <a href="dangnhap.aspx" class="btn-login">Đăng nhập</a>
                    </asp:PlaceHolder>

                    <!-- 2. Trạng thái ĐÃ đăng nhập -->
                    <asp:PlaceHolder ID="phDaDangNhap" runat="server" Visible="false">
                        <div class="user-dropdown">
                            <span class="user-name">Chào, <asp:Label ID="lblTenNguoiDung" runat="server"></asp:Label>!</span>
                            <!-- Nút vào trang quản lý -->
                            <a href="QuanTri.aspx" class="btn-outline" style="padding: 5px 10px; margin-left: 10px;">Tài khoản</a>
                            
                        </div>
                    </asp:PlaceHolder>

                    <!-- 3. Nút Giỏ hàng luôn hiển thị -->
                    <a href="giohang.aspx" class="btn btn-primary">Giỏ hàng</a>
                </div>

                <button class="menu-toggle" id="menuToggle"
                        aria-label="Mở menu">&#9776;</button>
            </div>
        </header>

        <!-- Banner -->
        <section class="banner banner-tours">
            <div class="banner-overlay"></div>
            <div class="banner-content container">
                <p class="banner-subtitle">VIETGO TOUR</p>
                <h1>Khám phá những<br>hành trình tuyệt vời</h1>
                <p class="banner-description">
                    Lựa chọn điểm đến yêu thích và bắt đầu chuyến đi của bạn.
                </p>
            </div>
        </section>

        <!-- Danh sách tour -->
        <section class="section section-light">
            <div class="container">

                <div class="section-heading">
                    <div>
                        <p class="section-label">KHÁM PHÁ VIỆT NAM</p>
                        <h2>Danh sách tour du lịch</h2>
                    </div>
                </div>

                <!-- Tìm kiếm và lọc tour (Dùng GET - Không dùng UpdatePanel) -->
                <div class="tour-filter">

                    <asp:TextBox ID="txtSearch" runat="server"
                        ClientIDMode="Static"
                        placeholder="Tìm tour theo tên..."></asp:TextBox>

                    <asp:DropDownList ID="ddlLocation" runat="server"
                        ClientIDMode="Static">
                        <asp:ListItem Value="">Tất cả địa điểm</asp:ListItem>
                    </asp:DropDownList>

                    <asp:DropDownList ID="ddlGia" runat="server"
                        ClientIDMode="Static">
                        <asp:ListItem Value="">Mọi mức giá</asp:ListItem>
                        <asp:ListItem Value="Duoi2Trieu">Dưới 2.000.000đ</asp:ListItem>
                        <asp:ListItem Value="Tu2Den4Trieu">2.000.000đ - 4.000.000đ</asp:ListItem>
                        <asp:ListItem Value="Tren4Trieu">Trên 4.000.000đ</asp:ListItem>
                    </asp:DropDownList>

                    <asp:DropDownList ID="ddlSapXep" runat="server"
                        ClientIDMode="Static">
                        <asp:ListItem Value="MoiNhat">Mới nhất</asp:ListItem>
                        <asp:ListItem Value="GiaTangDan">Giá: Thấp đến Cao</asp:ListItem>
                        <asp:ListItem Value="GiaGiamDan">Giá: Cao xuống Thấp</asp:ListItem>
                    </asp:DropDownList>

                    <button type="button" id="btnSearch" class="btn btn-primary">
                        Tìm kiếm
                    </button>
                </div>

                <p id="resultCount" class="result-count" runat="server"></p>

                <div class="tour-list" id="tourList">
                    <asp:Repeater ID="rptDanhSachTour" runat="server">
                        <ItemTemplate>
                            <article class="tour-card">
                                <a href='chitiettour.aspx?id=<%# Eval("MaTour") %>'>
                                    <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TenTour") %>'>
                                </a>
                                <div class="tour-info">
                                    <span class="tour-location"><%# Eval("DiaDiem") %></span>
                                    <h3>
                                        <a href='chitiettour.aspx?id=<%# Eval("MaTour") %>'>
                                            <%# Eval("TenTour") %>
                                        </a>
                                    </h3>
                                    <p class="tour-meta"><%# Eval("ThoiGian") %> · <%# Eval("KhoiHanh") %></p>
                                    <div class="tour-bottom">
                                        <p class="tour-price"><%# Eval("GiaTour", "{0:N0}") %>đ <span>/ người</span></p>
                                        <a href='chitiettour.aspx?id=<%# Eval("MaTour") %>' class="btn btn-outline">Chi tiết</a>
                                    </div>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <p id="noTour" class="no-tour" runat="server" visible="false">Không tìm thấy tour phù hợp.</p>

                <!-- Khối phân trang bằng Link chuyển URL -->
                <div class="pagination">
                    <asp:HyperLink ID="lnkPrev" runat="server" CssClass="btn btn-outline">&laquo; Trước</asp:HyperLink>
                    <span style="padding: 10px; font-weight: bold; color: #173b67;">
                        Trang <asp:Label ID="lblCurrentPage" runat="server"></asp:Label> / <asp:Label ID="lblTotalPages" runat="server"></asp:Label>
                    </span>
                    <asp:HyperLink ID="lnkNext" runat="server" CssClass="btn btn-outline">Sau &raquo;</asp:HyperLink>
                </div>

            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container footer-content">
                <div>
                    <a href="index.aspx" class="logo footer-logo">
                        Viet<span>Go</span>
                    </a>
                    <p>Đồng hành cùng bạn trên những hành trình khám phá Việt Nam.</p>
                </div>

                <div>
                    <h3>Liên kết nhanh</h3>
                    <a href="index.aspx">Trang chủ</a>
                    <a href="danhsachtour.aspx">Danh sách tour</a>
                    <a href="gioithieu.aspx">Giới thiệu</a>
                    <a href="lienhe.aspx">Liên hệ</a>
                </div>

                <div>
                    <h3>Liên hệ</h3>
                    <p>Email: contact@vietgo.vn</p>
                    <p>Điện thoại: 0123 456 789</p>
                    <p>Địa chỉ: Hà Nội, Việt Nam</p>
                </div>
            </div>

            <div class="footer-bottom">
                © 2026 VietGo. Website du lịch.
            </div>
        </footer>
    </form>
    
<script>
    document.getElementById("btnSearch").addEventListener("click", function () {
        const keyword = document.getElementById("txtSearch").value.trim();
        const location = document.getElementById("ddlLocation").value;
        const price = document.getElementById("ddlGia").value;
        const sort = document.getElementById("ddlSapXep").value;

        const params = new URLSearchParams({
            keyword: keyword,
            location: location,
            price: price,
            sort: sort,
            page: 1
        });

        window.location.href = "DanhSachTour.aspx?" + params.toString();
    });

    document.getElementById("menuToggle").addEventListener("click", function () {
        document.getElementById("navbar").classList.toggle("show");
    });
</script>


</body>
</html>
