<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PromotionLog.aspx.cs" Inherits="WebDuLich.PromotionLog" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="WebDuLich" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Danh sách mã khuyến mãi</h2>
        <!--
        <asp:GridView ID="gvKhuyenMai" runat="server"
            AutoGenerateColumns="False"
            EmptyDataText="Chưa có dữ liệu">

            <Columns>
                <asp:TemplateField HeaderText="STT">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="MaKM"
                    HeaderText="Mã khuyến mãi" />

                <asp:BoundField DataField="ThoiDiemGui"
                    HeaderText="Thời điểm gửi"
                    DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" />
            </Columns>

        </asp:GridView>
        -->
        <table border="1">
            <tr>
                <th>STT</th>
                <th>Mã khuyến mãi</th>
                <th>Thời điểm gửi</th>
            </tr>

            <%
                List<KhuyenMai> dsKM =
                    Session["DSKM"] as List<KhuyenMai>;

                if (dsKM != null)
                {
                    for (int i = 0; i < dsKM.Count; i++)
                    {
            %>
                <tr>
                    <td><%= i + 1 %></td>
                    <td><%= Server.HtmlEncode(dsKM[i].MaKM) %></td>
                    <td><%= dsKM[i].ThoiDiemGui.ToString("dd/MM/yyyy HH:mm:ss") %></td>
                </tr>
            <%
                    }
                }
            %>
        </table>
    </form>
</body>
</html>
