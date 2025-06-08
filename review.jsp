<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="DBUtil" %>  


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的評價</title>
    <link rel="stylesheet" href="lin.css">
    <style>
        .card1 {
            display: block;
            max-width: 600px;
            margin: 20px auto;
            background-color: #ecdfd5;
            border-radius: 15px;
            padding: 15px;
        }

        .image-container {
            gap: 20px;
            margin-bottom: 20px;
        }
        .image-container img {
            width: 100px;
        }

        .product-details p {
            margin: 0;
            font-size: 16px;
        }

        .product-section {
            gap: 20px;
            margin-bottom: 15px;
        }
        button{
        right: 70px; 
        bottom: 50px;
        font-size: 30px;
        border-radius: 50px;
        background-color: #c2a78d;
        border: 1px solid white;
        box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.3);
        color: white;
        }

    </style>
</head>
<body>
<header>
    <h1>🌙月見甜舖</h1>
    <nav>
        <ul>
            <li><a href="index.jsp">首頁</a></li>
            <li><a href="about.jsp">關於我們</a></li>
            <li><a href="register.jsp">會員註冊</a></li>
            <li><a href="enter.jsp">會員登入</a></li>
            <li><a href="account.html">會員中心</a></li>
            <li><a href="shoppingcart.jsp">購物車</a></li>
        </ul>
    </nav>
</header>

<h1 id="title">我的評價</h1>

<section class="card1">
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        conn = DBUtil.getConnection();
        stmt = conn.createStatement();
        String sql = "SELECT * FROM reviews ORDER BY review_time DESC";
        rs = stmt.executeQuery(sql);

        while(rs.next()){
            String member = rs.getString("member_name");
            String product = rs.getString("product_name");
            String content = rs.getString("review_content");
            String time = rs.getString("review_time");
            String productImg = rs.getString("product_image");
            String profileImg = rs.getString("profile_image");
            int rating = rs.getInt("rating");
%>
    <article class="image-container" style="border-bottom: 1px solid rgb(176, 163, 163);">
        <img src="<%=profileImg %>" style="border-radius: 50%; float: left;">
        <div style="color: gray;font-size: 15px;">
            <div style="display: flex; justify-content: space-between;">
                <p><%=member%></p>
                <p><%=time%></p>
            </div>
        </div>
        <p><%=product%></p>
        <div class="product-details"><br>
            <img src="picture/rating.png" alt="星星">
            <p><strong>品質:</strong> 讚</p>
            <p><strong>評論內容:</strong> <%=content%></p><br>
            <img src="<%=productImg %>" style="width: 150px;">
        </div>
    </article>
<%
        }
    } catch(Exception e) {
        out.println("資料載入失敗：" + e.getMessage());
    } finally {
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    }
%>
</section>

<footer style="text-align: center; position: fixed; bottom: 0; width: 100%;">
    <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
</footer>
</body>
</html>
