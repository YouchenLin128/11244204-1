<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Step 0: import library --> 
<%@ page import = "java.sql.*, java.util.*" %> 

<html lang="zh-Hant">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>月見甜舖</title>
    <link rel="stylesheet" href="../style.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
</head>

<body>
    <!-- 固定在頁面頂部的推播區域，包含訊息 -->
    <div class="ad-banner">
        <b>
            <p>🔔 𖢔꙳𐂂𖥧˖* 𝙼𝚎𝚛𝚛𝚢 𝚇𝚖𝚊𝚜 ࿄ཽ· 新品上架！快來品嚐聖誕節限定甜點，限時優惠！</p>
        </b>
    </div>

    <!-- header 區塊 -->
    <header>
        <h1>🌙月見甜舖</h1>
        <nav>
            <ul>
                <li><a href="../index.jsp">首頁</a></li>
                <li><a href="../about.html">關於我們</a></li>
                <li><a href="../register.jsp">會員註冊</a></li>
                <li><a href="../enter.jsp">會員登入</a></li>
                <li><a href="../account.jsp">會員中心</a></li>
                <li><a href="../cart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>

    <main class="container">
        <!-- 側邊欄 -->
        <aside class="sidebar">
            <h2>甜點分類</h2>
            <ul id="categories">
                <%!
                    String[] categoryArray;
                %>
                <%
                    // Step 1: 連接資料庫
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                    Connection con = DriverManager.getConnection(url, "root", "1234");
                    
                    if (con.isClosed()) {
                        out.println("連線建立失敗");
                    } else {

                        request.setCharacterEncoding("UTF-8");

                        // 宣告 Statement
                        Statement stmt = con.createStatement();

                        // 第一次查詢資料筆數
                        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM category");
                        rs.next();
                        int count = rs.getInt(1);
                        rs.close();

                        // 使用全域變數
                        categoryArray = new String[count];

                        // 第二次查詢實際資料
                        rs = stmt.executeQuery("SELECT CategoryName FROM category");
                        int index = 0;
                        while (rs.next()) {
                            categoryArray[index] = rs.getString("categoryName");
                            index++;
                        }

                        rs.close();
                        stmt.close();
                        con.close();
                    }
                %>
                <li><a href="./christmas.jsp"><%=categoryArray[0]%></a></li>
                <li><a href="./season.jsp"><%=categoryArray[1]%></a></li>
                <li><a href="./classical.jsp"><%=categoryArray[2]%></a></li>
                <li><a href="./creative.jsp"><%=categoryArray[3]%></a></li>

            
            </ul>
        </aside>

        <!-- 商品展示區 -->
        <section class="product-view">
            <h2>聖誕節限定甜點</h2>
            <div class="product-grid">
                <div class="product">
                    <a href="../products/snowman-daifuku.jsp">
                        <img src="picture1/雪人大福.jpg" alt="雪人大福">

                        <%!
                            String productName = "";
                            String productPrice = "";
                        %>

                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '雪人大福'";
                                ResultSet gs = con.createStatement().executeQuery(item);

                                if(gs.next()) {
                                    productName = gs.getString("ProductName");
                                    productPrice = gs.getString("Price");
                                }
                                gs.close();
                                con.close();
                            }
                        %>
                        <p><%=productName%></p>
                        <p>價格: NT$<%=productPrice%></p>
                        
                    </a>
                </div>
                <div class="product">
                    <a href="../products/christmas-wagashi-gift-set.jsp">
                        <img src="picture1/聖誕和菓子禮盒組.jpg" alt="聖誕和菓子禮盒組">

                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '聖誕和菓子禮盒組'";
                                ResultSet gs = con.createStatement().executeQuery(item);

                                if(gs.next()) {
                                    productName = gs.getString("ProductName");
                                    productPrice = gs.getString("Price");
                                }
                                gs.close();
                                con.close();
                            }
                        %>
                        <p><%=productName%></p>
                        <p>價格: NT$<%=productPrice%></p>
                        
                    </a>
                </div>
                <div class="product">
                    <a href="../products/christmas-party-dorayaki-with-cream.jsp">
                        <img src="picture1/聖誕派對生乳銅鑼燒1.jpg" alt="聖誕派對生乳銅鑼燒">

                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '聖誕派對生乳銅鑼燒'";
                                ResultSet gs = con.createStatement().executeQuery(item);

                                if(gs.next()) {
                                    productName = gs.getString("ProductName");
                                    productPrice = gs.getString("Price");
                                }
                                gs.close();
                                con.close();
                            }
                        %>
                        <p><%=productName%></p>
                        <p>價格: NT$<%=productPrice%></p>
                        
                    </a>
                </div>
        </section>
    </main>


    <footer>
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>

    <script>
        function toggleSubcategories() {
            const subcategories = document.querySelector('.subcategory');
            subcategories.style.display = subcategories.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</body>

</html>