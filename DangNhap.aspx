<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="WebDuLich.DangNhap" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - VietGo</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <form id="form1" runat="server">
        <header class="header">
            <div class="container header-content">
                <a href="index.aspx" class="logo">Viet<span>Go</span></a>

                <nav class="navbar" id="navbar">
                    <a href="index.aspx">Trang chủ</a>
                    <a href="danhsachtour.aspx">Danh sách tour</a>
                    <a href="gioithieu.aspx">Giới thiệu</a>
                    <a href="lienhe.aspx">Liên hệ</a>
                </nav>

                <div class="header-actions">
                    <a href="dangnhap.aspx" class="btn-login active">Đăng nhập</a>
                    <a href="giohang.aspx" class="btn btn-primary">Giỏ hàng</a>
                </div>

                <button class="menu-toggle" id="menuToggle"
                        aria-label="Mở menu">&#9776;</button>
            </div>
        </header>

        <main class="login-page">
            <div class="container login-container">

                <div class="login-intro">
                    <h1>Chào mừng trở lại!</h1>
                    <p>Đăng nhập VietGo để tiếp tục khám phá những hành trình thú vị.</p>
                    <img src="images/du-khach.jpg" alt="Khám phá Đà Nẵng">
                </div>

                <div class="login-box">
                    <h2>Đăng nhập</h2>
                    <p class="login-description">Nhập thông tin tài khoản của bạn</p>

                     <!--  -->
                    <div id="loginForm">
                        <div class="form-group">
                            <label for="txtEmail">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Nhập email của bạn"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">Mật khẩu</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Nhập mật khẩu"></asp:TextBox>
                        </div>

                        <div class="login-options">
                            <label class="remember-option">
                                <asp:CheckBox ID="chkRemember" runat="server" />
                                Ghi nhớ đăng nhập
                            </label>
                            <a href="#" id="forgotPassword">Quên mật khẩu?</a>
                        </div>

                        <!-- Nút đăng nhập của ASP.NET -->
                        <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn btn-primary login-button" OnClick="btnLogin_Click" />

                        <!-- Label để hiện thông báo lỗi từ server -->
                        <asp:Label ID="lblNotice" runat="server" CssClass="form-error" style="display: block; margin-top: 15px;"></asp:Label>
                    </div>

                    <p class="register-link">
                        Chưa có tài khoản?
                        <a href="dangky.aspx">Đăng ký ngay</a>
                    </p>
                </div>

            </div>
        </main>

        <footer class="footer">
            <div class="container footer-content">
                <div>
                    <a href="index.aspx" class="logo footer-logo">Viet<span>Go</span></a>
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
            <div class="footer-bottom">© 2026 VietGo. Website du lịch.</div>
        </footer>
    </form>

<script>
    // Mở menu trên thiết bị nhỏ
    const menuToggle = document.getElementById("menuToggle");
    const navbar = document.getElementById("navbar");

    menuToggle.addEventListener("click", function () {
        navbar.classList.toggle("show");
    });
    // Kiểm tra dữ liệu đăng nhập
    const btnLogin = document.getElementById("btnLogin");

    btnLogin.addEventListener("click", function () {
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value;

        const emailError = document.getElementById("emailError");
        const passwordError = document.getElementById("passwordError");
        const notice = document.getElementById("loginNotice");

        // Xóa thông báo cũ
        emailError.textContent = "";
        passwordError.textContent = "";
        notice.textContent = "";

        let isValid = true;

        // Kiểm tra email
        if (email === "") {
            emailError.textContent = "Vui lòng nhập email.";
            isValid = false;
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            emailError.textContent = "Email không hợp lệ.";
            isValid = false;
        }

        // Kiểm tra mật khẩu
        if (password.trim() === "") {
            passwordError.textContent = "Vui lòng nhập mật khẩu.";
            isValid = false;
        }

        // Kết quả kiểm tra
        if (isValid) {
            notice.textContent =
                "Thông tin hợp lệ. Chức năng đăng nhập chưa kết nối với hệ thống tài khoản.";
        }
    });

    // Demo chức năng quên mật khẩu
    document.getElementById("forgotPassword").addEventListener("click", function (event) {
        event.preventDefault();
        alert("Vui lòng liên hệ quản trị viên để được hỗ trợ lấy lại mật khẩu.");
    });

</script>

</body>
</html>
