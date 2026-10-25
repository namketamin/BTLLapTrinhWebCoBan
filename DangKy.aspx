<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="WebDuLich.DangKy" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - VietGo</title>
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
                    <a href="dangnhap.aspx" class="btn-login">Đăng nhập</a>
                    <a href="giohang.aspx" class="btn btn-primary">Giỏ hàng</a>
                </div>

                <!-- Bổ sung type="button" vào nút này -->
                <button type="button" class="menu-toggle" id="menuToggle" aria-label="Mở menu">&#9776;</button>
            </div>
        </header>

        <main class="register-page">
            <div class="container register-container">

                <div class="register-box">
                    <h1>Tạo tài khoản</h1>
                    <p class="register-description">
                        Tham gia VietGo để bắt đầu hành trình khám phá của bạn.
                    </p>

                    <div id="registerForm">
                       <div class="form-group">
                            <label for="txtFullName">Họ và tên</label>
                            <asp:TextBox ID="txtFullName" runat="server" placeholder="Nhập họ và tên" ClientIDMode="Static"></asp:TextBox>
                            <small class="form-error" id="nameError" style="color:red; display:block; font-size:13px;"></small>
                        </div>

                        <div class="form-group">
                            <label for="txtEmail">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Nhập email của bạn" ClientIDMode="Static"></asp:TextBox>
                            <small class="form-error" id="emailError" style="color:red; display:block; font-size:13px;"></small>
                        </div>

                        <div class="form-group">
                            <label for="txtPhone">Số điện thoại</label>
                            <asp:TextBox ID="txtPhone" runat="server" placeholder="Nhập số điện thoại" ClientIDMode="Static"></asp:TextBox>
                            <small class="form-error" id="phoneError" style="color:red; display:block; font-size:13px;"></small>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">Mật khẩu</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Tối thiểu 6 ký tự" ClientIDMode="Static"></asp:TextBox>
                            <small class="form-error" id="passwordError" style="color:red; display:block; font-size:13px;"></small>
                        </div>

                        <div class="form-group">
                            <label for="txtConfirmPassword">Xác nhận mật khẩu</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Nhập lại mật khẩu" ClientIDMode="Static"></asp:TextBox>
                            <small class="form-error" id="confirmError" style="color:red; display:block; font-size:13px;"></small>
                        </div>

                        <label class="terms-option">
                            <asp:CheckBox ID="chkAgreeTerms" runat="server" ClientIDMode="Static" />
                            Tôi đồng ý với các điều khoản sử dụng.
                        </label>
                        <small class="form-error" id="termsError" style="color:red; display:block; font-size:13px; margin-bottom:10px;"></small>

                        <!-- Thêm OnClientClick="return validateForm();" để gọi hàm JS trước khi gửi lên C# -->
                        <asp:Button ID="btnRegister" runat="server" Text="Đăng ký" CssClass="btn btn-primary register-button" OnClick="btnRegister_Click" OnClientClick="return validateForm();" />

                        <asp:Label ID="lblNotice" runat="server" CssClass="form-notice" style="display:block; margin-top:15px; font-weight:bold;"></asp:Label>
                    </div>

                    <p class="login-link">
                        Đã có tài khoản?
                        <a href="dangnhap.aspx">Đăng nhập</a>
                    </p>
                </div>

                <div class="register-intro">
                    <img src="images/dang-ky-1.jpg" alt="Du lịch cùng VietGo">
                    <h2>Khám phá Việt Nam cùng VietGo</h2>
                    <p>Lưu giữ những trải nghiệm đáng nhớ qua mỗi chuyến đi.</p>
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

    // Hàm kiểm tra form (được gọi từ OnClientClick của nút Đăng ký)
    function validateForm() {
        // Lấy dữ liệu từ các thẻ asp:TextBox đã được set ClientIDMode="Static"
        const fullName = document.getElementById("txtFullName").value.trim();
        const email = document.getElementById("txtEmail").value.trim();
        const phone = document.getElementById("txtPhone").value.trim();
        const password = document.getElementById("txtPassword").value;
        const confirmPassword = document.getElementById("txtConfirmPassword").value;
        const agreeTerms = document.getElementById("chkAgreeTerms").checked;

        // Xóa thông báo lỗi cũ
        document.getElementById("nameError").textContent = "";
        document.getElementById("emailError").textContent = "";
        document.getElementById("phoneError").textContent = "";
        document.getElementById("passwordError").textContent = "";
        document.getElementById("confirmError").textContent = "";
        document.getElementById("termsError").textContent = "";

        let isValid = true;

        if (fullName === "") {
            document.getElementById("nameError").textContent = "Vui lòng nhập họ và tên.";
            isValid = false;
        } else if (!/^[A-Za-zÀ-ỹ\s]+$/.test(fullName)) {
            document.getElementById("nameError").textContent = "Họ và tên không được chứa số hoặc ký tự đặc biệt.";
            isValid = false;
        }

        if (email === "") {
            document.getElementById("emailError").textContent = "Vui lòng nhập email.";
            isValid = false;
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            document.getElementById("emailError").textContent = "Email không hợp lệ.";
            isValid = false;
        }

        if (phone === "") {
            document.getElementById("phoneError").textContent = "Vui lòng nhập số điện thoại.";
            isValid = false;
        } else if (!/^0\d{9}$/.test(phone)) {
            document.getElementById("phoneError").textContent = "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.";
            isValid = false;
        }

        if (password.length < 6) {
            document.getElementById("passwordError").textContent = "Mật khẩu phải có ít nhất 6 ký tự.";
            isValid = false;
        }

        if (confirmPassword === "") {
            document.getElementById("confirmError").textContent = "Vui lòng xác nhận mật khẩu.";
            isValid = false;
        } else if (password !== confirmPassword) {
            document.getElementById("confirmError").textContent = "Mật khẩu xác nhận không khớp.";
            isValid = false;
        }

        if (!agreeTerms) {
            document.getElementById("termsError").textContent = "Bạn cần đồng ý với điều khoản sử dụng.";
            isValid = false;
        }

        // Nếu isValid = true, form sẽ tiếp tục chạy vào C# (btnRegister_Click)
        // Nếu isValid = false, form sẽ bị chặn lại và hiển thị lỗi bằng JS
        return isValid;
    }
</script>

</body>
</html>
