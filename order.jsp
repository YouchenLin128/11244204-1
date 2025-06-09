<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<%
    Integer userId = (Integer) session.getAttribute("id");
    if (userId == null) {
        out.println("<h3>請先登入才能查看購買紀錄。</h3>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/work?serverTimezone=UTC",
        "root",
        "1234"
    );
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>購買紀錄</title>
    <link rel="stylesheet" href="lin.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .card1 {
            display: block;
            max-width: 600px;
            margin: 20px auto;
            background-color: #f3e8d6;
            border-radius: 15px;
            padding: 15px;
        }
        .image-container {
            display: flex;
            flex-direction: row; 
            gap: 20px; 
            align-items: center;
            margin-bottom: 20px;
        }
        .image-container img {
            width: 200px;
            height: auto;
        }
        .product-details {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .product-details p {
            margin: 0;
            font-size: 16px;
        }
        .text-content p {
            margin: 5px 0;
        }
        .product-section {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <header>
        <h1>🌙月見甜舖</h1>
        <nav>
            <ul>
                <li><a href="index.jsp">首頁</a></li>
                <li><a href="about.html">關於我們</a></li>
                <li><a href="register.jsp">會員註冊</a></li>
                <li><a href="enter.jsp">會員登入</a></li>
                <li><a href="account.jsp">會員中心</a></li>
                <li><a href="cart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>

    <h1 id="title" style="text-align:center;">購買紀錄</h1>

<%
    String orderSql = "SELECT * FROM orders WHERE id = ? ORDER BY buy_time DESC";
    pstmt = conn.prepareStatement(orderSql);
    pstmt.setInt(1, userId);
    rs = pstmt.executeQuery();

    while (rs.next()) {
        int orderId = rs.getInt("OrderID");
        String buyTime = rs.getString("buy_time");
        String address = rs.getString("RecipientAddress");
        int finalTotal = rs.getInt("finalTotal");

        // 撈訂單商品細項
        String itemSql = "SELECT * FROM order_items WHERE OrderID = ?";
        PreparedStatement itemPstmt = conn.prepareStatement(itemSql);
        itemPstmt.setInt(1, orderId);
        ResultSet itemRs = itemPstmt.executeQuery();
%>
    <section class="card1">
<%
        int totalCount = 0;
        while (itemRs.next()) {
            String productName = itemRs.getString("ProductName");
            String productImage = itemRs.getString("ProductImage");
            int quantity = itemRs.getInt("Quantity");
            int price = itemRs.getInt("Price");
            totalCount += quantity;
%>
        <div class="image-container">
            <img src="<%= productImage %>" alt="<%= productName %>">
            <div class="product-details">
                <p style="font-weight: bold;"><%= productName %></p>
                <p>數量:<%= quantity %></p>
                <p>價格:<%= price * quantity %></p>
            </div>
        </div>
<%
        } // end while items
        itemRs.close();
        itemPstmt.close();
%>
        <div style="margin-left: 15px; border-top: 1px solid rgb(176, 163, 163);">
            <div class="text-content">
                <p>訂單日期: <%= buyTime %></p>
                <p>訂單編號: <%= orderId %></p>
                <p>地址: <%= address %></p>
                <p>商品數量: <%= totalCount %></p>
                <p>金額: <%= finalTotal %></p>
            </div>
        </div>
    </section>
<%
    } // end while orders
    rs.close();
    pstmt.close();
    conn.close();
%>

    <footer>
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>
</html>
