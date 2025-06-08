<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>商品詳情</title>
    <link rel="stylesheet" href="products/product.css">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
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

    <main class="container">
        <%
            String pid = request.getParameter("id");
            if (pid != null && !pid.isEmpty()) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/shop?serverTimezone=UTC", "root", "1234");
                    String sql = "SELECT * FROM product WHERE ProductID = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, pid);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
                        String name = rs.getString("ProductName");
                        String price = rs.getString("Price");
                        String desc = rs.getString("Description");
                        String pic = rs.getString("PictureName");
        %>
        <div class="product-detail">
            <img src="products/picture2/<%= pic %>" alt="<%= name %>">
            <h2><%= name %></h2>
            <p><strong>價格：</strong>NT$ <%= price %></p>
            <p><strong>商品介紹：</strong><%= desc %></p>
        
            <%
                String targetPage = "";
                switch(name) {
                    case "和菓子": targetPage = "wagashi.jsp"; break;
                    case "日式布丁": targetPage = "pudding.jsp"; break;
                    case "水信玄餅": targetPage = "raindrop-cake.jsp"; break;
                    case "銅鑼燒": targetPage = "dorayaki.jsp"; break;
                    case "羊羹": targetPage = "yokan.jsp"; break;
                    case "醬油糰子": targetPage = "soy-sauce-dango.jsp"; break;
                    case "蕨餅": targetPage = "warabi-mochi.jsp"; break;
                    case "雪人大福": targetPage = "snowman-daifuku.jsp"; break;
                    case "聖誕和菓子禮盒組": targetPage = "christmas-wagashi-gift-set.jsp"; break;
                    case "聖誕派對生乳銅鑼燒": targetPage = "christmas-party-dorayaki-with-cream.jsp"; break;
                    case "草莓大福": targetPage = "strawberry-daifuku.jsp"; break;
                    case "桔大福": targetPage = "orange-daifuku.jsp"; break;
                    case "橘餅": targetPage = "orange-mochi.jsp"; break;
                    case "金平糖": targetPage = "konpeito.jsp"; break;
                    case "栗子饅頭": targetPage = "chestnut-manju.jsp"; break;
                    case "抹茶蛋糕": targetPage = "matcha-cake.jsp"; break;
                    default: targetPage = "#"; // 預設避免錯誤
                }
            %>
        
            <a href="products/<%= targetPage %>" class="btn">前往商品頁</a>
        </div>        
        <%
                    } else {
                        out.println("<p style='color:red;'>找不到商品。</p>");
                    }
                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<p style='color:red;'>資料庫錯誤：" + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p style='color:red;'>未提供商品編號。</p>");
            }
        %>
    </main>

    <footer>
        <p>© 2024 月見甜鋪</p>
    </footer>

    <style>
        .container {
            padding: 30px;
            max-width: 800px;
            margin: auto;
            background-color: #fefaf6;
            border-radius: 10px;
        }
        .product-detail img {
            width: 100%;
            max-width: 300px;
            border-radius: 10px;
        }
        .product-detail h2 {
            font-size: 24px;
            color: #653a1e;
        }
        .product-detail p {
            font-size: 16px;
            margin: 10px 0;
            color: #333;
        }
        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #c7a17a;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</body>
</html>
