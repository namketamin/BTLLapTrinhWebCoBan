<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="WebDuLich.GioHang" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - VietGo</title>
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

                 <button class="menu-toggle" id="menuToggle"
                         aria-label="Mở menu">&#9776;</button>
             </div>
         </header>
        
        <main class="section">
            <div class="container">
                <div class="section-title">
                    <h2>Giỏ hàng của bạn</h2>
                </div>

                <!-- TRẠNG THÁI 1: GIỎ HÀNG TRỐNG -->
                <asp:PlaceHolder ID="phCartEmpty" runat="server" Visible="true">
                    <div class="cart-content" style="text-align:center; padding: 50px 0;">
                        <img src="images/empty-cart.png" alt="Trống" style="width: 150px; opacity: 0.5; margin-bottom: 20px;" onerror="this.style.display='none'" />
                        <p style="font-size: 18px; color: #666; margin-bottom: 20px;">Hiện tại giỏ hàng đang trống.</p>
                        <a href="danhsachtour.aspx" class="btn btn-primary">Tiếp tục khám phá tour</a>
                    </div>
                </asp:PlaceHolder>

                <!-- TRẠNG THÁI 2: CÓ SẢN PHẨM TRONG GIỎ -->
                <asp:PlaceHolder ID="phCartItems" runat="server" Visible="false">
                    <div class="cart-list">
                        <asp:Repeater ID="rptGioHang" runat="server" OnItemCommand="rptGioHang_ItemCommand">
                            <ItemTemplate>
                                <div class="cart-item" style="display:flex; border:1px solid #e0e0e0; margin-bottom:15px; padding:15px; border-radius:8px; align-items:center; background:#fff; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
                                    
                                    <!-- Ảnh Tour -->
                                    <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TenTour") %>' style="width:180px; height:120px; object-fit:cover; border-radius:5px; margin-right:20px;" />
                                    
                                    <!-- Thông tin Tour -->
                                    <div style="flex-grow: 1;">
                                        <h3 style="margin-top: 0; color: #173b67;"><%# Eval("TenTour") %></h3>
                                        <p style="margin: 5px 0; color: #666;">Khởi hành: <strong><%# Eval("KhoiHanh") %></strong></p>
                                        <p style="margin: 5px 0; color: #666;">Thời gian: <strong><%# Eval("ThoiGian") %></strong></p>
                                        <p style="color:#ff5722; font-size: 18px; font-weight:bold; margin-top: 10px;"><%# Eval("GiaTour", "{0:N0}") %> đ <span style="font-size: 14px; font-weight: normal; color: #999;">/ khách</span></p>
                                    </div>
                                    
                                    <!-- Nút thao tác -->
                                    <div style="text-align:right; min-width: 150px;">
                                        <!-- Chuyển sang trang Thanh toán kèm ID tour -->
                                        <a href='ThanhToan.aspx?id=<%# Eval("MaTour") %>' class="btn btn-primary" style="display:block; margin-bottom:10px; background-color: #ff5722; border-color: #ff5722;">
                                            Thanh toán ngay
                                        </a>
                                        
                                        <!-- Nút Xóa khỏi giỏ -->
                                        <asp:LinkButton ID="btnXoa" runat="server" CommandName="Remove" CommandArgument='<%# Eval("MaTour") %>' CssClass="btn btn-outline" style="color:#dc3545; border-color:#dc3545; display:block;" OnClientClick="return confirm('Bạn có chắc muốn xóa tour này khỏi giỏ hàng?');">
                                           Xóa
                                        </asp:LinkButton>
                                    </div>

                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:PlaceHolder>
            </div>
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
</body>
</html>