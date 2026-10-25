<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebDuLich.index" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VietGo - Du lịch khám phá</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <header class="header">
            <div class="container header-content">
                <a href="index.aspx" class="logo">Viet<span>Go</span></a>

                <nav class="navbar" id="navbar">
                    <a href="index.aspx" class="active">Trang chủ</a>
                    <a href="danhsachtour.aspx">Danh sách tour</a>
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

                <!-- Bổ sung type="button" vào nút này -->
                <button type="button" class="menu-toggle" id="menuToggle" aria-label="Mở menu">&#9776;</button>
            </div>
        </header>

        <!-- Banner -->
        <section class="banner banner-home">
            <div class="banner-overlay"></div>
            <div class="banner-content container">
                <p class="banner-subtitle">KHÁM PHÁ - TRẢI NGHIỆM - KẾT NỐI</p>
                <h1>Khám phá thế giới<br>cùng VietGo</h1>
                <p class="banner-description">
                    Cùng bạn tạo nên những hành trình đáng nhớ
                    và khám phá những vùng đất tuyệt đẹp.
                </p>
                <a href="danhsachtour.aspx" class="btn btn-primary">
                    Khám phá tour ngay
                </a>
            </div>
        </section>

        <!-- Giới thiệu ngắn -->
        <section class="intro section">
            <div class="container text-center">
                <p class="section-label">CHÀO MỪNG ĐẾN VIETGO</p>
                <h2>Hành trình tuyệt vời bắt đầu từ đây</h2>
                <p class="intro-description">
                    VietGo mang đến những chuyến du lịch thú vị,
                    giúp bạn khám phá cảnh đẹp, văn hóa và ẩm thực
                    tại nhiều điểm đến hấp dẫn.
                </p>
            </div>
        </section>

        <!-- Tour nổi bật -->
        <section class="section section-light">
            <div class="container">
                <div class="section-heading">
                    <div>
                        <p class="section-label">LỰA CHỌN CỦA BẠN</p>
                        <h2>Tour du lịch nổi bật</h2>
                    </div>
                    <a href="danhsachtour.aspx" class="view-all">Xem tất cả tour →</a>
                </div>

                <div class="tour-list">
                    <!-- Sử dụng Repeater để tự động tạo ra các tour-card từ DB -->
                    <asp:Repeater ID="rptTourNoiBat" runat="server">
                        <ItemTemplate>
                            <article class="tour-card">
                                <!-- Đường link truyền thêm MaTour (id) để sang trang chi tiết biết là xem tour nào -->
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
                                    <p class="tour-meta"><%# Eval("ThoiGian") %> · <%# Eval("MoTaNgan") %></p>
                                    <div class="tour-bottom">
                                        <p class="tour-price"><%# Eval("GiaTour", "{0:N0}") %>đ
                                            <span>/ người</span>
                                        </p>
                                        <a href='chitiettour.aspx?id=<%# Eval("MaTour") %>' class="btn btn-outline">
                                            Chi tiết
                                        </a>
                                    </div>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

        <!-- Điểm đến -->
        <section class="section">
            <div class="container">
                <div class="text-center section-title">
                    <p class="section-label">ĐI ĐÂU HÔM NAY?</p>
                    <h2>Điểm đến được yêu thích</h2>
                </div>

                <div class="destination-list">
                    <a href="danhsachtour.aspx" class="destination-card">
                        <img src="images/da-nang.jpg"
                             alt="Đà Nẵng">
                        <span>Đà Nẵng</span>
                    </a>

                    <a href="danhsachtour.aspx" class="destination-card">
                        <img src="images/ha-long.jpg"
                             alt="Vịnh Hạ Long">
                        <span>Vịnh Hạ Long</span>
                    </a>

                    <a href="danhsachtour.aspx" class="destination-card">
                        <img src="images/da-lat.jpg"
                             alt="Đà Lạt">
                        <span>Đà Lạt</span>
                    </a>
                </div>
            </div>
        </section>

        <!-- Lời kêu gọi -->
        <section class="cta-section">
            <div class="container text-center">
                <h2>Sẵn sàng cho chuyến đi tiếp theo?</h2>
                <p>Chọn hành trình yêu thích và bắt đầu khám phá cùng VietGo.</p>
                <a href="danhsachtour.aspx" class="btn btn-light">
                    Xem danh sách tour
                </a>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container footer-content">
                <div>
                    <a href="index.aspx" class="logo footer-logo">
                        Viet<span>Go</span>
                    </a>
                    <p>
                        Đồng hành cùng bạn trên những hành trình
                        khám phá Việt Nam.
                    </p>
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

        const currentPage = window.location.pathname.split("/").pop();

        document.querySelectorAll(".navbar a").forEach(function (link) {
            if (link.getAttribute("href") === currentPage) {
                link.classList.add("active");
            } else {
                link.classList.remove("active");
            }
        });
    </script>

</body>
</html>