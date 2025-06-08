<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %> 
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>月見甜舖</title>
    <link rel="stylesheet" href="style.css">
    <script src="lin.js" defer></script> 
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
    <style>
        header nav {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 10px;
        }
        header nav ul {
            display: flex;
            justify-content: center;
            gap: 20px;
            list-style: none;
            padding: 0;
            margin: 0;
        }
        header nav ul li {
            margin: 0;
        }
        header nav form {
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>
    <!-- COOKIE -->
    <div class="cookie1" id="cookie">
        <p>COOKIE POLICY</p>
        <p>為了提供您最佳的瀏覽體驗，本網站使用 Cookie。繼續瀏覽即表示您接受此設定。</p>
        <button id='cookiebtn'>ACCEPT & CLOSE</button>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var cookieAcceptButton = document.getElementById('cookiebtn');
            var cookieBox = document.getElementById('cookie'); 
            cookieAcceptButton.onclick = function() {
                cookieBox.style.display = "none";
                fetch('cookie.jsp', {
                    method: 'POST' 
                })
                .then(response => {
                    if (!response.ok) {
                        console.error('cookie 創建請求失敗');
                    }
                })
                .catch(error => {
                    console.error('發送 cookie 創建請求時發生錯誤:', error);
                });
            };
        });
    </script>

    <div class="ad-banner">
        <b><p>📣即日起至6/30，購買任何商品滿500元現折10元！</p></b>
    </div>

    <!-- header 區塊 -->
    <header>
        <h1 style="padding-top: 30px; text-align: center;">🌙月見甜舖</h1>
        <%-- 訪客計數邏輯省略保留 --%>
        <nav>
            <ul>
                <li><a href="index.jsp">首頁</a></li>
                <li><a href="about.html">關於我們</a></li>
                <li><a href="register.jsp">會員註冊</a></li>
                <li><a href="enter.jsp">會員登入</a></li>
                <li><a href="account.jsp">會員中心</a></li>
                <li><a href="cart.jsp">購物車</a></li>
            </ul>
            <form action="search.jsp" method="get">
                <input type="text" name="query" placeholder="搜尋商品" required style="padding: 4px; border-radius: 6px; border: 1px solid #ccc;">
                <button type="submit" style="background-color:#ecdfd5; border:none; padding:5px 10px; border-radius:6px;">🔍</button>
            </form>
        </nav>
    </header>

    <!-- 頂部隨機廣告區域 -->
    <div class="random-ad" style="text-align: center;">
    <%
        // Step 1: 連接資料庫，並隨機選擇一條廣告
        String adPicture = "";
        String adPage = "";
        
        try {
            String adSql = "SELECT adpicture, adpage FROM ads ORDER BY RAND() LIMIT 1";
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/work?serverTimezone=UTC", "root", "1234");
            ResultSet rs = con.createStatement().executeQuery(adSql);

            if (rs.next()) {
                adPicture = rs.getString("adpicture");
                adPage = rs.getString("adpage");
            }

            rs.close();
            con.close();
        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
        }
    %>

    <!-- 顯示隨機廣告 -->
    <a href="<%=adPage%>" target="_self">
        <img src="<%=adPicture%>" alt="Random Ad" style="width: 800px; margin-top: 100px;height: 300px;">
    </a>
</div>

    <main class="container">
        <aside class="sidebar">
            <h2>甜點分類</h2>
            <ul>
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
                <li><a href="sidebar/christmas.jsp"><%=categoryArray[0]%></a></li>
                <li><a href="sidebar/season.jsp"><%=categoryArray[1]%></a></li>
                <li><a href="sidebar/classical.jsp"><%=categoryArray[2]%></a></li>
                <li><a href="sidebar/creative.jsp"><%=categoryArray[3]%></a></li>

            </ul>
        </aside>

        <section class="product-view">
            <h2>本店推薦</h2>
            <div class="product-grid">
                <div class="product">
                    <a href="products/pudding.jsp">
                        <img src="picture/日式布丁.jpg" alt="布丁">

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
                                String item = "SELECT * FROM product WHERE ProductName = '日式布丁'";
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
                    <a href="products/yokan.jsp">
                        <img src="picture/羊羹.jpg" alt="羊羹">
                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '羊羹'";
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
                    <a href="products/strawberry-daifuku.jsp">
                        <img src="picture/草莓大福.jpg" alt="草莓大福">

                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '草莓大福'";
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
                    <a href="products/matcha-cake .jsp">
                        <img src="picture/抹茶蛋糕.jpg" alt="抹茶蛋糕">

                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '抹茶蛋糕'";
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
                    <a href="products/chestnut-manju.jsp">
                        <img src="picture/栗子饅頭.jpg" alt="栗子饅頭">

                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '栗子饅頭'";
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
                    <a href="products/water-cake.jsp">
                        <img src="picture/水信玄餅.jpg" alt="水信玄餅">
                        
                        <%
                            // Step 1: 連接資料庫
                            Class.forName("com.mysql.jdbc.Driver");
                            url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                            con = DriverManager.getConnection(url, "root", "1234");
                            if (con.isClosed()) {
                                out.println("連線建立失敗");
                            } else {
                                request.setCharacterEncoding("UTF-8");
                                String item = "SELECT * FROM product WHERE ProductName = '水信玄餅'";
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
            </div>
        </section>
    </main>
    
    
    
    <footer>
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>

        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
        
    </footer>
    
</body>
</html>
