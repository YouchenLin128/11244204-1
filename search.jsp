<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>搜尋結果</title>
    <link rel="stylesheet" href="products/product.css">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <h1>🌙月見甜鋪</h1>
        <nav>
            <ul style="display: flex; align-items: center;">
                <li><a href="index.jsp">首頁</a></li>
                <li><a href="about.html">關於我們</a></li>
                <li><a href="register.jsp">會員註冊</a></li>
                <li><a href="enter.jsp">會員登入</a></li>
                <li><a href="account.jsp">會員中心</a></li>
                <li><a href="cart.jsp">購物車</a></li>
                <li>
                    <form action="search.jsp" method="get" style="display: flex; align-items: center;">
                        <input type="text" name="query" placeholder="搜尋商品" style="padding: 5px; border-radius: 5px;">
                        <button type="submit" style="margin-left: 5px; padding: 5px 10px; border-radius: 5px; cursor: pointer;">🔍</button>
                    </form>
                </li>
            </ul>
        </nav>
    </header>

    <main class="container">
        <h2>搜尋結果</h2>
        <div class="product-list">
            <% 
                String keyword = request.getParameter("query");
                if (keyword != null && !keyword.trim().isEmpty()) {
                    keyword = "%" + keyword.trim() + "%";
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/shop?serverTimezone=UTC", "root", "1234");
                        String sql = "SELECT ProductID, ProductName, PictureName FROM product WHERE ProductName LIKE ?";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, keyword);
                        ResultSet rs = pstmt.executeQuery();
                        if (!rs.isBeforeFirst()) {
                            out.println("<p>沒有找到相關商品。</p>");
                        }
                        while (rs.next()) {
                            String name = rs.getString("ProductName");
                            String picture = rs.getString("PictureName");
                            int pid = rs.getInt("ProductID");
            %>
                            <div class="product-item">
                                <a href="detail.jsp?id=<%= rs.getInt("ProductID") %>">
                                    <img src="products/picture2/<%= picture %>" alt="<%= name %>">
                                    <p><%= name %></p>
                                </a>
                            </div>
            <% 
                        }
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch(Exception e) {
                        out.println("<p style='color:red;'>搜尋發生錯誤：" + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>請輸入關鍵字。</p>");
                }
            %>
        </div>
    </main>

    <style>
        .container {
            padding: 20px;
            max-width: 1000px;
            margin: auto;
        }
        .product-list {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 20px;
        }
        .product-item {
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            background-color: #fefaf6;
            width: 200px;
        }
        .product-item img {
            width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 5px;
        }
        .product-item p {
            margin-top: 10px;
            font-size: 16px;
            font-weight: bold;
            color: #653a1e;
        }
    </style>

    <footer>
        <p>© 2024 月見甜鋪</p>
    </footer>
</body>
</html>
