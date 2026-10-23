<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyTour.aspx.cs" Inherits="WebDuLich.QuanLyTour" ValidateRequest="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản Phẩm - Admin</title>
    <link rel="stylesheet" href="style.css">
    <!-- Nạp thư viện Trình soạn thảo văn bản (Word-like) -->
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>

    <style>
        body { background-color: #f4f6f8; }
        .admin-container { background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 15px rgba(0,0,0,0.05); margin: 40px auto; border: 1px solid #e4e9ed; }
        
        .tour-filter { display: flex; gap: 15px; margin-bottom: 25px; background: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px solid #eee; }
        .tour-filter input[type="text"], .tour-filter select { flex: 1; padding: 10px 15px; border: 1px solid #ccc; border-radius: 5px; outline: none; font-size: 14px; }
        .tour-filter button { padding: 0 25px; }

        .grid-table { width: 100%; border-collapse: collapse; margin-top: 10px; font-size: 14px; }
        .grid-table th, .grid-table td { border: 1px solid #eaeaea; padding: 12px; text-align: left; vertical-align: middle; }
        .grid-table th { background-color: #f8f9fa; color: #555; font-weight: 600; text-transform: uppercase; font-size: 12px; }
        .btn-action { padding: 6px 12px; color: #fff; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; font-size: 13px; margin-right: 5px;}
        .btn-edit { background: #087fbd; }
        .btn-delete { background: #dc3545; }
        .status-badge { padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
        .status-1 { background: #d4edda; color: #155724; }
        .status-0 { background: #f8d7da; color: #721c24; }
        
        /* Modal Popup */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); z-index: 1000; justify-content: center; align-items: center; }
        .modal-content { background-color: #fff; padding: 25px 30px; border-radius: 10px; width: 95%; max-width: 900px; max-height: 90vh; overflow-y: auto; position: relative; animation: fadeIn 0.3s; }
        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 15px; position: sticky; top: 0; background: #fff; z-index: 10; }
        .modal-header h3 { margin: 0; color: #173b67; font-size: 20px; }
        .close-btn { background: none; border: none; font-size: 28px; cursor: pointer; color: #aaa; line-height: 1;}
        .close-btn:hover { color: #dc3545; }
        
        .form-group-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 8px; font-size: 13px; color: #555; text-transform: uppercase; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; font-family: inherit; }
        .modal-footer { text-align: right; margin-top: 20px; border-top: 1px solid #eee; padding-top: 15px; position: sticky; bottom: 0; background: #fff; z-index: 10;}
        
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <!-- Quan trọng: enctype="multipart/form-data" để cho phép up file -->
    <form id="form1" runat="server" enctype="multipart/form-data">
        <header class="header" style="background:#fff; border-bottom: 1px solid #eee;">
             <div class="container header-content">
                 <a href="index.aspx" class="logo">Viet<span>Go</span></a>
                 <div class="header-actions">
                     <span style="font-weight: 500; color: #333; margin-right: 15px;">Admin: <asp:Label ID="lblTenNguoiDung" runat="server"></asp:Label></span>
                     <a href="QuanTri.aspx" class="btn btn-outline" style="padding: 6px 15px;">← Bảng điều khiển</a>
                 </div>
             </div>
         </header>

        <main class="container">
            <div class="admin-container">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
                    <h2 style="margin:0; color: #333; font-size: 26px;">Quản Lý Sản Phẩm (Tour)</h2>
                    <button type="button" class="btn btn-primary" style="padding: 10px 20px; font-size: 15px;" onclick="openAddModal()">+ Thêm Tour Mới</button>
                </div>

                <!-- Thanh tìm kiếm bằng GET -->
                <div class="tour-filter">
                    <input type="text" id="txtSearch" placeholder="Tìm tour theo tên..." value="<%= Request.QueryString["keyword"] %>" />
                    <select id="ddlLocation">
                        <option value="">Tất cả địa điểm</option>
                        <option value="Đà Nẵng" <%= Request.QueryString["location"] == "Đà Nẵng" ? "selected" : "" %>>Đà Nẵng</option>
                        <option value="Đà Lạt" <%= Request.QueryString["location"] == "Đà Lạt" ? "selected" : "" %>>Đà Lạt</option>
                        <option value="Hà Nội" <%= Request.QueryString["location"] == "Hà Nội" ? "selected" : "" %>>Hà Nội</option>
                        <option value="Sapa" <%= Request.QueryString["location"] == "Sapa" ? "selected" : "" %>>Sapa</option>
                        <option value="Phú Quốc" <%= Request.QueryString["location"] == "Phú Quốc" ? "selected" : "" %>>Phú Quốc</option>
                    </select>
                    <select id="ddlGia">
                        <option value="">Mọi mức giá</option>
                        <option value="Duoi2Trieu" <%= Request.QueryString["price"] == "Duoi2Trieu" ? "selected" : "" %>>Dưới 2.000.000đ</option>
                        <option value="Tu2Den4Trieu" <%= Request.QueryString["price"] == "Tu2Den4Trieu" ? "selected" : "" %>>2.000.000đ - 4.000.000đ</option>
                        <option value="Tren4Trieu" <%= Request.QueryString["price"] == "Tren4Trieu" ? "selected" : "" %>>Trên 4.000.000đ</option>
                    </select>
                    <select id="ddlSapXep">
                        <option value="MoiNhat" <%= Request.QueryString["sort"] == "MoiNhat" ? "selected" : "" %>>Mới nhất</option>
                        <option value="GiaTangDan" <%= Request.QueryString["sort"] == "GiaTangDan" ? "selected" : "" %>>Giá: Thấp đến Cao</option>
                        <option value="GiaGiamDan" <%= Request.QueryString["sort"] == "GiaGiamDan" ? "selected" : "" %>>Giá: Cao xuống Thấp</option>
                    </select>
                    <button type="button" id="btnSearchJS" class="btn btn-primary">Tìm kiếm</button>
                </div>

                <asp:Label ID="lblThongBao" runat="server" Font-Bold="true" style="display:block; margin-bottom:15px;"></asp:Label>

                <!-- Bảng dữ liệu -->
                <asp:GridView ID="gvTour" runat="server" AutoGenerateColumns="False" CssClass="grid-table" DataKeyNames="MaTour" OnRowCommand="gvTour_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="MaTour" HeaderText="Mã" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Ảnh" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img src='<%# Eval("HinhAnh") %>' style="width:70px; height:45px; object-fit:cover; border-radius:4px;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TenTour" HeaderText="Tên Tour" />
                        <asp:BoundField DataField="DiaDiem" HeaderText="Địa Điểm" ItemStyle-Width="100px" />
                        <asp:BoundField DataField="GiaTour" HeaderText="Giá (VNĐ)" DataFormatString="{0:N0}" ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Right" />
                        <asp:TemplateField HeaderText="Trạng thái" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <span class='<%# Convert.ToInt32(Eval("TrangThai")) == 1 ? "status-badge status-1" : "status-badge status-0" %>'>
                                    <%# Convert.ToInt32(Eval("TrangThai")) == 1 ? "Hiển thị" : "Đã ẩn" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hành động" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Sua" CommandArgument='<%# Eval("MaTour") %>' CssClass="btn-action btn-edit">Sửa</asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Xoa" CommandArgument='<%# Eval("MaTour") %>' CssClass="btn-action btn-delete" OnClientClick="return confirm('Xóa tour này khỏi hệ thống?');">Xóa</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </main>

        <!-- ================= MODAL FORM THÊM / SỬA ================= -->
        <div id="tourModal" class="modal-overlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h3><asp:Label ID="lblTieuDeForm" runat="server" Text="Thêm Tour Mới"></asp:Label></h3>
                    <button type="button" class="close-btn" onclick="closeModal()">&times;</button>
                </div>
                
                <asp:HiddenField ID="hfMaTour" runat="server" /> 

                <!-- Nhóm 1: Cơ bản -->
                <div class="form-group-row">
                    <div class="form-group">
                        <label>Tên Tour (*)</label>
                        <asp:TextBox ID="txtTenTour" runat="server" CssClass="form-control" placeholder="Nhập tên tour..." required></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Địa điểm (*)</label>
                        <asp:TextBox ID="txtDiaDiem" runat="server" CssClass="form-control" placeholder="Đà Lạt, Nha Trang..." required></asp:TextBox>
                    </div>
                </div>

                <div class="form-group-row">
                    <div class="form-group">
                        <label>Giá Tour (VNĐ) (*)</label>
                        <asp:TextBox ID="txtGiaTour" runat="server" TextMode="Number" CssClass="form-control" required></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Hình Ảnh (*)</label>
                        <!-- Nút Chọn File Từ Máy Tính -->
                        <asp:FileUpload ID="fileHinhAnh" runat="server" CssClass="form-control" accept="image/*" />
                        <asp:HiddenField ID="hfHinhAnhCu" runat="server" />
                        <!-- Hiển thị ảnh cũ khi bấm nút Sửa -->
                        <asp:Image ID="imgPreview" runat="server" Style="max-height: 80px; margin-top: 10px; display: none; border-radius: 5px; border: 1px solid #ccc;" />
                    </div>
                </div>

                <!-- Nhóm 2: Cấu hình tour -->
                <div class="form-group-row">
                    <div class="form-group">
                        <label>Thời gian (*)</label>
                        <asp:TextBox ID="txtThoiGian" runat="server" CssClass="form-control" placeholder="3 Ngày 2 Đêm" required></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Phương tiện (*)</label>
                        <asp:TextBox ID="txtPhuongTien" runat="server" CssClass="form-control" placeholder="Máy bay, Ô tô..." required></asp:TextBox>
                    </div>
                </div>

                <div class="form-group-row">
                    <div class="form-group">
                        <label>Khởi hành (*)</label>
                        <asp:TextBox ID="txtKhoiHanh" runat="server" CssClass="form-control" placeholder="Hàng ngày, T3 & T7..." required></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Trạng thái</label>
                        <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-control">
                            <asp:ListItem Value="1">Kích hoạt (Hiển thị)</asp:ListItem>
                            <asp:ListItem Value="0">Đã ẩn (Ngừng bán)</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <!-- Nhóm 3: Mô tả (Sử dụng trình soạn thảo văn bản Word-like) -->
                <div class="form-group">
                    <label>Mô tả ngắn (*)</label>
                    <asp:TextBox ID="txtMoTaNgan" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Tóm tắt về chuyến đi..." required></asp:TextBox>
                </div>
                
                <!-- Bỏ required ở các ô dùng CKEditor vì nó sẽ ẩn textbox thật đi -->
                <div class="form-group">
                    <label>Điểm Nổi Bật (Trình soạn thảo văn bản)</label>
                    <asp:TextBox ID="txtDiemNoiBat" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Lịch Trình Chi Tiết (Trình soạn thảo văn bản)</label>
                    <asp:TextBox ID="txtLichTrinh" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Dịch Vụ Bao Gồm (Trình soạn thảo văn bản)</label>
                    <asp:TextBox ID="txtDichVuBaoGom" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" style="padding: 10px 20px;" onclick="closeModal()">Hủy</button>
                    <!-- Chạy hàm validate để đồng bộ CKEditor trước khi gửi -->
                    <asp:Button ID="btnLuuTour" runat="server" Text="Lưu dữ liệu" CssClass="btn btn-primary" style="padding: 10px 20px;" OnClientClick="return validateForm();" OnClick="btnLuuTour_Click" />
                </div>
            </div>
        </div>
    </form>

    <script>
        window.onload = function () {
            // Thêm dòng này để tắt cảnh báo phiên bản cũ trong Console
            CKEDITOR.config.versionCheck = false;

            CKEDITOR.replace('<%= txtDiemNoiBat.ClientID %>');
            CKEDITOR.replace('<%= txtLichTrinh.ClientID %>');
            CKEDITOR.replace('<%= txtDichVuBaoGom.ClientID %>');
        };
        // Tìm kiếm GET
        document.getElementById("btnSearchJS").addEventListener("click", function () {
            const keyword = document.getElementById("txtSearch").value.trim();
            const location = document.getElementById("ddlLocation").value;
            const price = document.getElementById("ddlGia").value;
            const sort = document.getElementById("ddlSapXep").value;

            const params = new URLSearchParams({
                keyword: keyword, location: location, price: price, sort: sort
            });
            window.location.href = "QuanLyTour.aspx?" + params.toString();
        });

        // Xóa trắng form khi bấm Thêm Mới
        function openAddModal() {
            document.getElementById('<%= hfMaTour.ClientID %>').value = "";
            document.getElementById('<%= txtTenTour.ClientID %>').value = "";
            document.getElementById('<%= txtDiaDiem.ClientID %>').value = "";
            document.getElementById('<%= txtGiaTour.ClientID %>').value = "";
            document.getElementById('<%= txtThoiGian.ClientID %>').value = "";
            document.getElementById('<%= txtPhuongTien.ClientID %>').value = "";
            document.getElementById('<%= txtKhoiHanh.ClientID %>').value = "";
            document.getElementById('<%= txtMoTaNgan.ClientID %>').value = "";
            document.getElementById('<%= ddlTrangThai.ClientID %>').value = "1";
            
            // Xóa ảnh cũ
            document.getElementById('<%= imgPreview.ClientID %>').style.display = 'none';
            document.getElementById('<%= hfHinhAnhCu.ClientID %>').value = "";
            document.getElementById('<%= fileHinhAnh.ClientID %>').value = "";

            // Xóa dữ liệu trong CKEditor
            if (CKEDITOR.instances['<%= txtDiemNoiBat.ClientID %>']) CKEDITOR.instances['<%= txtDiemNoiBat.ClientID %>'].setData('');
            if (CKEDITOR.instances['<%= txtLichTrinh.ClientID %>']) CKEDITOR.instances['<%= txtLichTrinh.ClientID %>'].setData('');
            if (CKEDITOR.instances['<%= txtDichVuBaoGom.ClientID %>']) CKEDITOR.instances['<%= txtDichVuBaoGom.ClientID %>'].setData('');
            
            document.getElementById('<%= lblTieuDeForm.ClientID %>').innerText = "Thêm Tour Mới";
            document.getElementById('tourModal').style.display = 'flex';
        }

        function openModal() {
            document.getElementById('tourModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('tourModal').style.display = 'none';
        }

        function validateForm() {
            // Đồng bộ dữ liệu từ trình soạn thảo ảo về TextBox thật trước khi submit
            for (var instanceName in CKEDITOR.instances) {
                CKEDITOR.instances[instanceName].updateElement();
            }

            var form = document.getElementById('form1');
            if (form.checkValidity()) {
                return true;
            } else {
                form.reportValidity();
                return false;
            }
        }
    </script>
</body>
</html>