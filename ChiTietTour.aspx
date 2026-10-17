<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChiTietTour.aspx.cs" Inherits="WebDuLich.ChiTietTour" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết tour Đà Nẵng - VietGo</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <form id="form1" runat="server">
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

        <!-- Nội dung chi tiết tour -->
        <section class="section">
            <div class="container">

                <div class="tour-breadcrumb">
                    <a href="danhsachtour.aspx">Danh sách tour</a> /
                    <span><asp:Label ID="lblBreadcrumb" runat="server"></asp:Label></span>
                </div>

                <div class="detail-layout">

                    <!-- Thông tin chính -->
                    <div class="detail-main">
                        <asp:Image ID="imgTour" runat="server" CssClass="detail-image" />

                        <p class="section-label"><asp:Label ID="lblDiaDiemTop" runat="server"></asp:Label> · VIỆT NAM</p>
                        <h2><asp:Label ID="lblTenTour" runat="server"></asp:Label></h2>

                        <p class="detail-description">
                            <asp:Label ID="lblMoTaNgan" runat="server"></asp:Label>
                        </p>

                        <div class="detail-highlights">
                            <div>
                                <span>Thời gian</span>
                                <strong><asp:Label ID="lblThoiGian" runat="server"></asp:Label></strong>
                            </div>
                            <div>
                                <span>Phương tiện</span>
                                <strong><asp:Label ID="lblPhuongTien" runat="server"></asp:Label></strong>
                            </div>
                            <div>
                                <span>Khởi hành</span>
                                <strong><asp:Label ID="lblKhoiHanh" runat="server"></asp:Label></strong>
                            </div>
                        </div>

                        <div class="detail-section">
                            <h3>Điểm tham quan nổi bật</h3>
                            <!-- Dùng Literal để in nguyên mã HTML (ul li) từ DB -->
                            <asp:Literal ID="litDiemNoiBat" runat="server"></asp:Literal>
                        </div>

                        <div class="detail-section">
                            <h3>Lịch trình tham khảo</h3>
                            <!-- Dùng Literal để in các div lịch trình -->
                            <asp:Literal ID="litLichTrinh" runat="server"></asp:Literal>
                        </div>

                        <div class="detail-section">
                            <h3>Dịch vụ bao gồm</h3>
                            <!-- Dùng Literal để in danh sách dịch vụ -->
                            <asp:Literal ID="litDichVuBaoGom" runat="server"></asp:Literal>
                        </div>
                    </div>

                    <!-- Khung giá tour bên phải -->
                    <aside class="detail-sidebar">
                        <div class="price-box">
                            <p>Giá tour từ</p>
                            <h2><asp:Label ID="lblGiaTour" runat="server"></asp:Label>đ</h2>
                            <span> / người</span>

                            <hr>

                            <p><strong>Thời gian:</strong> <asp:Label ID="lblSideThoiGian" runat="server"></asp:Label></p>
                            <p><strong>Địa điểm:</strong> <asp:Label ID="lblSideDiaDiem" runat="server"></asp:Label></p>
                            <p><strong>Phương tiện:</strong> <asp:Label ID="lblSidePhuongTien" runat="server"></asp:Label></p>

                            <asp:LinkButton ID="btnThemGioHang" runat="server" CssClass="btn btn-primary contact-tour" OnClick="btnThemGioHang_Click" style="background-color: #ff5722; border: none; margin-bottom: 10px;">
                                🛒 Thêm vào giỏ hàng
                            </asp:LinkButton>

                            <a href="lienhe.aspx" class="btn btn-primary contact-tour">
                                Liên hệ tư vấn
                            </a>
                        </div>
                    </aside>
                </div>
            </div>
        </section>

        <!-- Tour liên quan -->
        <section class="section section-light">
            <div class="container">
                <div class="section-heading">
                    <div>
                        <p class="section-label">GỢI Ý CHO BẠN</p>
                        <h2>Tour du lịch liên quan</h2>
                    </div>
                    <a href="danhsachtour.aspx" class="view-all">Xem tất cả tour →</a>
                </div>

                <div class="tour-list">
                    <!-- Dùng Repeater để gọi 3 tour ngẫu nhiên cùng địa điểm -->
                    <asp:Repeater ID="rptTourLienQuan" runat="server">
                        <ItemTemplate>
                            <article class="tour-card">
                                <a href='chitiettour.aspx?id=<%# Eval("MaTour") %>'>
                                    <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TenTour") %>'>
                                </a>
                                <div class="tour-info">
                                    <span class="tour-location"><%# Eval("DiaDiem") %></span>
                                    <h3>
                                        <a href='chitiettour.aspx?id=<%# Eval("MaTour") %>'><%# Eval("TenTour") %></a>
                                    </h3>
                                    <p class="tour-price"><%# Eval("GiaTour", "{0:N0}") %>đ <span>/ người</span></p>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
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

    <!-- JavaScript DOM -->
    <script>
        const menuToggle = document.getElementById("menuToggle");
        const navbar = document.getElementById("navbar");

        menuToggle.addEventListener("click", function () {
            navbar.classList.toggle("show");
        });
    </script>

</body>
</html>
