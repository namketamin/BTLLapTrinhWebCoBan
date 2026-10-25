<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gioithieu.aspx.cs" Inherits="WebDuLich.GioiThieu" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu - VietGo</title>
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
                    <a href="danhsachtour.aspx">Danh sách tour</a>
                    <a href="gioithieu.aspx" class="active">Giới thiệu</a>
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

        <!-- Nội dung giới thiệu -->
        <main class="about-page">

            <section class="section">
                <div class="container">

                    <div class="text-center section-title">
                        <p class="section-label">CHÀO MỪNG ĐẾN VIETGO</p>
                        <h1>Giới thiệu về VietGo</h1>
                        <p class="about-description">
                            Đồng hành cùng bạn trên mọi hành trình khám phá Việt Nam.
                        </p>
                    </div>

                    <div class="about-intro">
                        <div class="about-text">
                            <h2>VietGo là gì?</h2>

                            <p>
                                VietGo là website giới thiệu các tour du lịch
                                tại Việt Nam, giúp khách hàng tìm kiếm và lựa chọn
                                những chuyến đi phù hợp với nhu cầu của mình.
                            </p>

                            <p>
                                Tại VietGo, bạn có thể tham khảo thông tin về
                                điểm đến, lịch trình và giá tour để dễ dàng
                                lên kế hoạch cho chuyến đi tiếp theo.
                            </p>

                            <p>
                                Chúng tôi mong muốn mang đến một trải nghiệm
                                tìm kiếm tour đơn giản, thuận tiện và dễ sử dụng.
                            </p>

                            <a href="danhsachtour.aspx" class="btn btn-primary">
                                Khám phá tour ngay
                            </a>
                        </div>

                        <div class="about-image">
                            <img src="images/banner-trang-gt.jpg"
                                 alt="Khám phá du lịch Đà Nẵng">
                        </div>
                    </div>

                </div>
            </section>

            <!-- Giá trị -->
            <section class="section section-light">
                <div class="container">
                    <div class="text-center section-title">
                        <p class="section-label">ĐIỀU CHÚNG TÔI HƯỚNG ĐẾN</p>
                        <h2>Giá trị của VietGo</h2>
                    </div>

                    <div class="values-list">

                        <article class="value-card">
                            <div class="value-icon">🌍</div>
                            <h3>Khám phá</h3>
                            <p>
                                Giới thiệu những điểm đến hấp dẫn,
                                từ cảnh đẹp thiên nhiên đến các địa danh văn hóa.
                            </p>
                        </article>

                        <article class="value-card">
                            <div class="value-icon">🎯</div>
                            <h3>Thuận tiện</h3>
                            <p>
                                Giúp người dùng dễ dàng tham khảo và
                                lựa chọn tour phù hợp với kế hoạch cá nhân.
                            </p>
                        </article>

                        <article class="value-card">
                            <div class="value-icon">❤️</div>
                            <h3>Trải nghiệm</h3>
                            <p>
                                Khuyến khích mọi người khám phá những vùng đất mới
                                và tạo nên các kỷ niệm đáng nhớ.
                            </p>
                        </article>

                    </div>
                </div>
            </section>

            <!-- Lời kết -->
            <section class="section">
                <div class="container text-center about-cta">
                    <h2>Hành trình tuyệt vời bắt đầu từ đây</h2>
                    <p>
                        Lựa chọn điểm đến yêu thích và cùng VietGo
                        bắt đầu chuyến đi của bạn.
                    </p>
                    <a href="danhsachtour.aspx" class="btn btn-primary">
                        Xem danh sách tour
                    </a>
                </div>
            </section>

        </main>

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
