<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%
    // 管理者驗證
    Object isAdminObj = session.getAttribute("isAdmin");
    if (!(isAdminObj instanceof Boolean) || !((Boolean) isAdminObj)) {
        response.sendRedirect("enter.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("user");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, String>> orders = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/work?serverTimezone=UTC",
            "root",
            "1234"
        );

        String sql = "SELECT o.OrderID, o.id AS member_id, o.buy_time, o.finalTotal, m.realname " +
                     "FROM orders o " +
                     "JOIN members m ON o.id = m.id " +
                     "ORDER BY o.buy_time DESC";

        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> order = new HashMap<>();
            order.put("OrderID", rs.getString("OrderID"));
            order.put("member_id", rs.getString("member_id"));
            order.put("realname", rs.getString("realname"));
            order.put("buy_time", rs.getString("buy_time"));
            order.put("finalTotal", rs.getString("finalTotal"));
            orders.add(order);
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>資料庫查詢發生錯誤，請稍後再試。</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>訂單管理 - 管理者後台</title>
    <link rel="stylesheet" href="lin.css">
</head>
<body>
<header>
    <h1>🌙月見甜舖 - 管理者後台</h1>
    <nav>
        <ul>
            <li><a href="index.jsp">首頁</a></li>
            <li><a href="logout.jsp">登出</a></li>
        </ul>
    </nav>
</header>

<div style="display: flex; justify-content: space-between; align-items: center;">
    <h1 style="padding-left: 20px;">歡迎管理者：<%= adminName %></h1>
</div>

<section style="display: flex; align-items: center; justify-content: space-between; padding: 30px;">
    <div style="display: flex; align-items: center;">
        <img style="border-radius: 50%;" src="picture/usigi.jpg" width="150px" alt="Profile Picture">
        <div style="padding-left: 20px; font-size: large;">
            <!-- 若有需要，可新增管理員資訊 -->
        </div>
    </div>
</section>

<section style="padding: 30px;">
    <h2>訂單列表</h2>
    <table border="1" cellpadding="10" style="border-collapse: collapse; width: 100%; background-color: #f9f9f9;">
        <tr style="background-color: #f3e8d6;">
            <th>訂單編號</th>
            <th>會員ID</th>
            <th>會員姓名</th>
            <th>訂購日期</th>
            <th>總金額</th>
        </tr>
        <%
            if (orders.isEmpty()) {
        %>
            <tr><td colspan="5" style="text-align:center;">目前沒有任何訂單</td></tr>
        <%
            } else {
                for (Map<String, String> order : orders) {
        %>
            <tr>
                <td><%= order.get("OrderID") %></td>
                <td><%= order.get("member_id") %></td>
                <td><%= order.get("realname") %></td>
                <td><%= order.get("buy_time") %></td>
                <td>$<%= order.get("finalTotal") %></td>
            </tr>
        <%
                }
            }
        %>
    </table>
    
</section>
<!-- 新增商品功能 -->
<h2>新增商品</h2>
<form action="addProduct.jsp" method="post">
    商品名稱：<input type="text" name="ProductName" required><br>
    類別ID：<input type="number" name="CategoryID" required><br>
    價格：<input type="number" name="Price" required><br>
    敘述：<input type="text" name="Description"><br>
    詳細內容1：<input type="text" name="Content1"><br>
    詳細內容2：<input type="text" name="Content2"><br>
    庫存數量：<input type="number" name="Stock" required><br>
    圖片連結：<input type="text" name="ProductImage"><br>
    圖片檔名：<input type="text" name="PictureName"><br>
    <input type="submit" value="上架商品">
</form>

<!-- 下架商品功能 -->
<h2>下架商品（庫存歸零）</h2>
<form action="removeProduct.jsp" method="post">
    請選擇要下架的商品：
    <select name="ProductID">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/shop?serverTimezone=UTC",
                    "root", "1234"); 

                String sql = "SELECT ProductID, ProductName FROM product WHERE Stock > 0";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                while (rs.next()) {
        %>
                    <option value="<%= rs.getInt("ProductID") %>">
                        <%= rs.getString("ProductName") %>
                    </option>
        <%
                }
            } catch(Exception e) {
                out.println("錯誤：" + e.getMessage());
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </select>
    <input type="submit" value="下架商品">
</form>

<footer>
    <p>© 2024 月見甜舖 | 管理系統</p>
</footer>
</body>
</html>
