<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LienHe.aspx.cs" Inherits="WebDuLich.LienHe" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên hệ - VietGo</title>
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
                    <a href="gioithieu.aspx">Giới thiệu</a>
                    <a href="lienhe.aspx" class="active">Liên hệ</a>
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

        <!-- Nội dung liên hệ -->
        <main>
            <section class="section">
                <div class="container">

                    <div class="text-center section-title">
                        <p class="section-label">VIETGO LUÔN SẴN SÀNG HỖ TRỢ</p>
                        <h1>Liên hệ với chúng tôi</h1>
                        <p class="contact-description">
                            Hãy gửi câu hỏi hoặc yêu cầu của bạn.
                            VietGo rất vui được đồng hành cùng bạn.
                        </p>
                    </div>

                    <div class="contact-layout">

                        <!-- Thông tin liên hệ -->
                        <div class="contact-info">
                            <h2>Thông tin liên hệ</h2>
                            <p>
                                Bạn cần tư vấn về tour du lịch hoặc muốn tìm hiểu
                                thêm về VietGo? Hãy liên hệ với chúng tôi qua
                                các thông tin dưới đây.
                            </p>

                            <div class="contact-item">
                                <span class="contact-icon">📧</span>
                                <div>
                                    <h3>Email</h3>
                                    <p>contact@vietgo.vn</p>
                                </div>
                            </div>

                            <div class="contact-item">
                                <span class="contact-icon">📞</span>
                                <div>
                                    <h3>Điện thoại</h3>
                                    <p>0123 456 789</p>
                                </div>
                            </div>

                            <div class="contact-item">
                                <span class="contact-icon">📍</span>
                                <div>
                                    <h3>Địa chỉ</h3>
                                    <p>Hà Nội, Việt Nam</p>
                                </div>
                            </div>

                            <div class="contact-item">
                                <span class="contact-icon">🕒</span>
                                <div>
                                    <h3>Thời gian hỗ trợ</h3>
                                    <p>Thứ 2 - Thứ 7: 8:00 - 17:00</p>
                                </div>
                            </div>
                        </div>

                        <!-- Form liên hệ -->
                        <div class="contact-form-box">
                            <h2>Gửi tin nhắn</h2>

                            <div id="contactForm">
                                <div class="form-group">
                                    <label for="contactName">Họ và tên</label>
                                    <input type="text" id="contactName"
                                           name="name"
                                           placeholder="Nhập họ và tên">
                                    <small class="error-message"
                                           id="nameError"></small>
                                </div>

                                <div class="form-group">
                                    <label for="contactEmail">Email</label>
                                    <input type="email" id="contactEmail"
                                           name="email"
                                           placeholder="Nhập email">
                                    <small class="error-message"
                                           id="emailError"></small>
                                </div>

                                <div class="form-group">
                                    <label for="contactSubject">Chủ đề</label>
                                    <input type="text" id="contactSubject"
                                           name="subject"
                                           placeholder="Nhập chủ đề">
                                    <small class="error-message"
                                           id="subjectError"></small>
                                </div>

                                <div class="form-group">
                                    <label for="contactMessage">Nội dung</label>
                                    <textarea id="contactMessage"
                                              name="message" rows="5"
                                              placeholder="Nhập nội dung liên hệ"></textarea>
                                    <small class="error-message"
                                           id="messageError"></small>
                                </div>

                                <button type="submit" class="btn btn-primary">
                                    Gửi liên hệ
                                </button>

                                <p id="formNotice" class="form-notice"
                                   role="status"></p>
                            </div>
                        </div>

                    </div>
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
    const contactForm = document.getElementById("contactForm");
    const sendButton = document.querySelector(
        ".contact-form-box button"
    );

    sendButton.addEventListener("click", function (event) {
        event.preventDefault();

        const name = document.getElementById("contactName");
        const email = document.getElementById("contactEmail");
        const subject = document.getElementById("contactSubject");
        const message = document.getElementById("contactMessage");

        const nameError = document.getElementById("nameError");
        const emailError = document.getElementById("emailError");
        const subjectError = document.getElementById("subjectError");
        const messageError = document.getElementById("messageError");
        const formNotice = document.getElementById("formNotice");

        // Xóa lỗi cũ trước khi kiểm tra lại
        nameError.textContent = "";
        emailError.textContent = "";
        subjectError.textContent = "";
        messageError.textContent = "";
        formNotice.textContent = "";

        let isValid = true;

        if (name.value.trim() === "") {
            nameError.textContent = "Vui lòng nhập họ và tên.";
            isValid = false;
        }

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (email.value.trim() === "") {
            emailError.textContent = "Vui lòng nhập email.";
            isValid = false;
        } else if (!emailPattern.test(email.value.trim())) {
            emailError.textContent = "Email không hợp lệ.";
            isValid = false;
        }

        if (subject.value.trim() === "") {
            subjectError.textContent = "Vui lòng nhập chủ đề.";
            isValid = false;
        }

        if (message.value.trim() === "") {
            messageError.textContent = "Vui lòng nhập nội dung.";
            isValid = false;
        }

        if (isValid) {
            formNotice.textContent =
                "Thông tin hợp lệ! Tin nhắn chưa được gửi đến máy chủ.";
            formNotice.classList.add("success-message");

            // Xóa dữ liệu sau khi kiểm tra thành công
            name.value = "";
            email.value = "";
            subject.value = "";
            message.value = "";
        } else {
            formNotice.classList.remove("success-message");
        }
    });

    </script>

</body>
</html>
