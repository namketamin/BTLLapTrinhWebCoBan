<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="WebDuLich.ThanhToan" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - VietGo</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .checkout-layout { display: grid; grid-template-columns: 60% 35%; gap: 5%; margin: 40px 0; align-items: start; }
        .box { background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); border: 1px solid #e0e0e0; }
        .box h3 { color: #173b67; margin-bottom: 20px; border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 5px; color: #333; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; font-size: 14px; }
        .form-control[readonly] { background: #f9f9f9; color: #666; }
        .radio-item { padding: 12px; border: 1px solid #eee; border-radius: 5px; margin-bottom: 10px; background: #fafafa; display: flex; align-items: center; gap: 10px; cursor: pointer;}
        
        /* Pricing summary */
        .coupon-box { display: flex; gap: 8px; margin-top: 15px; margin-bottom: 15px; }
        .price-row { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 14px; color: #555; }
        .price-row.total { font-size: 20px; font-weight: bold; color: #dc3545; border-top: 2px dashed #e0e0e0; padding-top: 12px; margin-top: 10px; }
        
        /* Terms & Compact Button */
        .terms-group { margin-top: 15px; font-size: 13px; color: #555; display: flex; align-items: flex-start; gap: 8px; }
        .terms-group input { margin-top: 3px; cursor: pointer; }
        .btn-order-wrapper { text-align: center; margin-top: 15px; }
        .btn-order { padding: 10px 24px; font-size: 15px; background: #ff5722; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; text-transform: uppercase; transition: 0.2s; }
        .btn-order:hover { background: #e64a19; }
        .btn-order:disabled { background: #cccccc; cursor: not-allowed; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="header">
            <div class="container header-content">
                <a href="index.aspx" class="logo">Viet<span>Go</span></a>
                <a href="GioHang.aspx" class="btn btn-outline">← Quay lại Giỏ hàng</a>
            </div>
        </header>

        <main class="container">
            <div style="text-align:center; margin-top:20px;">
                <h2>Đặt tour của bạn</h2>
                <asp:Label ID="lblBaoLoi" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
            </div>

            <div class="checkout-layout">
                <!-- CỘT TRÁI: THÔNG TIN KHÁCH & PHƯƠNG THỨC THANH TOÁN -->
                <div class="box">
                    <h3>1. Thông tin liên hệ</h3>
                    <div class="form-group">
                        <label>Họ và tên</label>
                        <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Địa chỉ của bạn</label>
                        <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ chi tiết..." required="required"></asp:TextBox>
                    </div>

                    <h3 style="margin-top: 25px;">2. Phương thức thanh toán</h3>
                    <asp:RadioButtonList ID="rblThanhToan" runat="server" Width="100%">
                        <asp:ListItem Value="ChuyenKhoan" Selected="True">
                            <div class="radio-item">💳 Chuyển khoản ngân hàng (Vietcombank, MBBank...)</div>
                        </asp:ListItem>
                        <asp:ListItem Value="TienMat">
                            <div class="radio-item">💵 Thanh toán tiền mặt tại tất cả các chi nhánh của VietGo</div>
                        </asp:ListItem>
                    </asp:RadioButtonList>

                    <h3 style="margin-top: 25px;">3. Ghi chú</h3>
                    <div class="form-group" style="margin-bottom:0;">
                        <label>Vui lòng cho chúng tôi biết nếu Quý khách có ghi chú hoặc yêu cầu đặc biệt.</label>
                        <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <!-- CỘT PHẢI: CHI TIẾT BOOKING & TÍNH TIỀN -->
                <div class="box">
                    <h3>Chi tiết đơn hàng</h3>
                    <asp:Image ID="imgTour" runat="server" Width="100%" style="border-radius: 5px; height: 160px; object-fit: cover; margin-bottom: 15px;" />
                    <h4 style="color: #173b67; margin-bottom: 10px;"><asp:Label ID="lblTenTour" runat="server"></asp:Label></h4>
                    
                    <div class="price-row">
                        <span>Đơn giá:</span>
                        <strong style="color:#087fbd;"><asp:Label ID="lblGiaTour" runat="server"></asp:Label> đ/khách</strong>
                    </div>

                    <div style="display:flex; justify-content:space-between; align-items: center; margin-bottom: 15px; background: #f4f6f8; padding: 10px; border-radius: 5px;">
                        <span style="font-size:14px; font-weight:600;">Số lượng khách:</span>
                        <asp:TextBox ID="txtSoKhach" runat="server" TextMode="Number" Text="1" min="1" max="50" CssClass="form-control" style="width: 75px; text-align: center; font-weight:bold;" oninput="tinhTongTien()"></asp:TextBox>
                    </div>

                    <!-- MÃ GIẢM GIÁ -->
                    <div style="border-top: 1px solid #eee; padding-top: 12px; margin-top: 12px;">
                        <label style="font-size:13px; font-weight:600;">Mã ưu đãi / Khuyến mãi</label>
                        <div class="coupon-box">
                            <input type="text" id="txtMaGiamGia" class="form-control" style="text-transform:uppercase;" />
                            <button type="button" class="btn btn-outline" onclick="apDungMa()" style="padding: 0 15px; white-space:nowrap;">Áp dụng</button>
                        </div>
                        <span id="lblCouponNotice" style="font-size: 12px; display:block; margin-bottom: 10px;"></span>
                    </div>

                    <!-- TÓM TẮT BẢNG GIÁ -->
                    <div style="background:#fafafa; padding:12px; border-radius:5px; border:1px solid #f0f0f0;">
                        <div class="price-row">
                            <span>Tạm tính:</span>
                            <span><span id="spTamTinh">0</span> đ</span>
                        </div>
                        <div class="price-row" style="color:#28a745;">
                            <span>Giảm giá:</span>
                            <span>-<span id="spGiamGia">0</span> đ</span>
                        </div>
                        <div class="price-row total">
                            <span>Tổng tiền:</span>
                            <span><span id="hienThiTongTien">0</span> đ</span>
                        </div>
                    </div>

                    <!-- THẺ ẨN LƯU DỮ LIỆU ĐỂ POST VỀ C# -->
                    <asp:HiddenField ID="hfGiaGoc" runat="server" />
                    <asp:HiddenField ID="hfPhanTRAMGiam" runat="server" Value="0" />

                    <!-- Ô CHECKBOX ĐỒNG Ý ĐIỀU KHOẢN -->
                    <div class="terms-group">
                        <input type="checkbox" id="chkTerms" onchange="toggleOrderButton()" />
                        <label for="chkTerms">Tôi đồng ý với <a href="#" style="color:#087fbd; text-decoration:underline;">Điều khoản dịch vụ</a> và <a href="#" style="color:#087fbd; text-decoration:underline;">Chính sách bảo mật</a> của VietGo.</label>
                    </div>

                    <!-- NÚT THANH TOÁN (THU NHỎ) -->
                    <div class="btn-order-wrapper">
                        <asp:Button ID="btnDatHang" runat="server" Text="Tiến hành đặt hàng" CssClass="btn-order" Enabled="false" OnClick="btnDatHang_Click" OnClientClick="return confirm('Xác nhận tiến hành đặt Tour này?');" />
                    </div>
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

        <!-- JS TÍNH TIỀN + CHECK MÃ GIẢM GIÁ + BẬT NÚT ĐẶT HÀNG -->
        <script>
            function tinhTongTien() {
                var giaGoc = parseInt(document.getElementById('<%= hfGiaGoc.ClientID %>').value) || 0;
                var soKhach = parseInt(document.getElementById('<%= txtSoKhach.ClientID %>').value) || 1;
                var phanTramGiam = parseInt(document.getElementById('<%= hfPhanTRAMGiam.ClientID %>').value) || 0;

                var tamTinh = giaGoc * soKhach;
                var giamGia = (tamTinh * phanTramGiam) / 100;
                var tongTien = tamTinh - giamGia;

                document.getElementById('spTamTinh').innerText = tamTinh.toLocaleString('vi-VN');
                document.getElementById('spGiamGia').innerText = giamGia.toLocaleString('vi-VN');
                document.getElementById('hienThiTongTien').innerText = tongTien.toLocaleString('vi-VN');
            }

            function apDungMa() {
                var code = document.getElementById('txtMaGiamGia').value.trim().toUpperCase();
                var lblNotice = document.getElementById('lblCouponNotice');
                var hfGiam = document.getElementById('<%= hfPhanTRAMGiam.ClientID %>');

                if (code === "VIETGO" || code === "KHUYENMAI") {
                    hfGiam.value = "10"; // Giảm 10%
                    lblNotice.innerText = "Áp dụng thành công! Được giảm 10%.";
                    lblNotice.style.color = "#28a745";
                } else if (code === "") {
                    hfGiam.value = "0";
                    lblNotice.innerText = "Vui lòng nhập mã giảm giá!";
                    lblNotice.style.color = "#dc3545";
                } else {
                    hfGiam.value = "0";
                    lblNotice.innerText = "Mã giảm giá không hợp lệ!";
                    lblNotice.style.color = "#dc3545";
                }
                tinhTongTien();
            }

            function toggleOrderButton() {
                var chk = document.getElementById('chkTerms');
                var btn = document.getElementById('<%= btnDatHang.ClientID %>');
                btn.disabled = !chk.checked;
            }

            window.onload = function () {
                tinhTongTien();
                toggleOrderButton();
            };
        </script>
    </form>
</body>
</html>