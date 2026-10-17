<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanTri.aspx.cs" Inherits="WebDuLich.QuanTri" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tài khoản - VietGo</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .account-layout { display: grid; grid-template-columns: 260px 1fr; gap: 30px; margin: 40px 0; }
        .account-sidebar { background: #f8f9fa; padding: 25px; border-radius: 10px; border: 1px solid #e4e9ed; }
        .account-sidebar h3 { font-size: 16px; color: #77838a; margin-bottom: 15px; text-transform: uppercase; letter-spacing: 1px;}
        .account-sidebar ul { list-style: none; padding: 0; margin-bottom: 25px; }
        .account-sidebar li { margin-bottom: 12px; }
        .account-sidebar a, .account-sidebar .btn-logout { display: block; color: #263238; font-weight: 500; padding: 8px 12px; border-radius: 5px; transition: 0.3s; text-decoration: none; border: none; background: transparent; text-align: left; width: 100%; box-sizing: border-box;}
        .account-sidebar a:hover, .account-sidebar a.active { background: #e5f4fc; color: #087fbd; }
        .account-sidebar .btn-logout { color: #dc3545; }
        .account-sidebar .btn-logout:hover { background: #fce7e9; }
        
        .account-content { background: #fff; padding: 35px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); border: 1px solid #e4e9ed; }
        .account-content h2 { color: #173b67; margin-bottom: 5px; }
        .account-content p.desc { color: #687780; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        
        .form-group-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 8px; color: #333; }
        .form-control { width: 100%; padding: 12px; border: 1px solid #d8dee8; border-radius: 6px; font-size: 15px; outline: none; margin-bottom: 20px;}
        .form-control:focus { border-color: #087fbd; }
        .form-control[disabled] { background: #f0f3f5; cursor: not-allowed; }
    </style>
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

                 <button class="menu-toggle" id="menuToggle"
                         aria-label="Mở menu">&#9776;</button>
             </div>
         </header>

        <main class="container">
            <div class="account-layout">
                <!-- Sidebar Menu -->
                <aside class="account-sidebar">
                    <h3>Tài khoản của tôi</h3>
                    <ul>
                        <li><a href="QuanTri.aspx" class="active">Hồ sơ cá nhân</a></li>
                        <li><a href="#">Lịch sử đặt tour</a></li>
                        <li><a href="#">Đổi mật khẩu</a></li>
                    </ul>

                    <!-- Menu chỉ dành cho Admin -->
                    <asp:PlaceHolder ID="phAdminMenu" runat="server" Visible="false">
                        <h3>Quản trị hệ thống</h3>
                        <ul>
                            <li><a href="#">Quản lý Tour</a></li>
                            <li><a href="#">Quản lý Đơn hàng</a></li>
                            <li><a href="#">Quản lý Người dùng</a></li>
                        </ul>
                    </asp:PlaceHolder>

                    <!-- NÚT ĐĂNG XUẤT DÙNG BUTTON CHUẨN -->
                    <div style="border-top: 1px solid #e4e9ed; padding-top: 20px; margin-top: 10px;">
                        <asp:Button ID="btnDangXuat" runat="server" Text="Đăng xuất" CssClass="btn btn-outline" style="color: #dc3545; border-color: #dc3545; width: 100%;" OnClick="btnDangXuat_Click" />
                    </div>

                </aside>

                <!-- Content Area -->
                <div class="account-content">
                    <h2>Hồ sơ cá nhân</h2>
                    <p class="desc">Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
                    
                    <asp:Label ID="lblThongBao" runat="server" ForeColor="Green" Font-Bold="true" style="display:block; margin-bottom:15px;"></asp:Label>

                    <div class="form-group-row">
                        <div class="form-group">
                            <label>Họ và tên</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Email (Không thể thay đổi)</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label>Quyền hạn tài khoản</label>
                        <asp:TextBox ID="txtQuyen" runat="server" CssClass="form-control" Enabled="false" ForeColor="Red" Font-Bold="true"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnCapNhat" runat="server" Text="Lưu Thay Đổi" CssClass="btn btn-primary" OnClientClick="return validateForm();" OnClick="btnCapNhat_Click" />
                </div>
            </div>
        </main>
    </form>
</body>
</html>
<!-- JavaScript Kiểm tra form sửa thông tin -->
    <script>
        function validateForm() {
            // Lấy ID của các ô input do ASP.NET sinh ra (Dùng querySelector tìm đuôi ID)
            var txtHoTen = document.querySelector('input[id$="txtHoTen"]');
            var txtSDT = document.querySelector('input[id$="txtSoDienThoai"]');
            
            var hoTen = txtHoTen.value.trim();
            var sdt = txtSDT.value.trim();

            // 1. Kiểm tra rỗng
            if (hoTen === "") {
                alert("Vui lòng nhập Họ và tên!");
                txtHoTen.focus();
                return false; // Chặn không cho gửi form
            }

            if (sdt === "") {
                alert("Vui lòng nhập Số điện thoại!");
                txtSDT.focus();
                return false;
            }

            // 2. Kiểm tra định dạng số điện thoại Việt Nam (10 số, bắt đầu bằng 03, 05, 07, 08, 09)
            var vnf_regex = /^(03|05|07|08|09)+([0-9]{8})$/;
            if (vnf_regex.test(sdt) == false) {
                alert("Số điện thoại không hợp lệ! Vui lòng nhập số điện thoại Việt Nam (10 số).");
                txtSDT.focus();
                return false;
            }

            // Nếu qua hết các vòng kiểm tra thì cho phép submit
            return true; 
        }
    </script>