<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Step 0: import library --> 
<%@ page import = "java.sql.*" %> 

<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>月見甜舖</title>
    <link rel="stylesheet" href="style.css">
    <script src="lin.js" defer></script> 
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
        <h1 style="padding-top: 30px;">🌙月見甜舖</h1>
        <%
            Class.forName("com.mysql.jdbc.Driver");	  
            //使用JDBC去連結MySQL，所以該行語法的意思，就是要告訴電腦我要使用JDBC
            try {
            //Step 2: 建立連線 
                String sql="";
                String url="jdbc:mysql://localhost/?serverTimezone=UTC";
                Connection con=DriverManager.getConnection(url,"root","1234");   
                if(con.isClosed())
                    out.println("連線建立失敗");
                else
                {
                    //Step 3: 相關程式

                    sql="use shop"; // SQL 語法：使用 shop 資料庫
                    con.createStatement().execute(sql); // 執行上一行的 SQL
                    sql="SELECT * FROM `countview`";
                    ResultSet rs=con.createStatement().executeQuery(sql);
                    //計數器+1
                    if(rs.next()) {// 一筆一筆讀取資料，回傳 false 表示讀取結束
                        String countString = rs.getString(1);//轉成 int 整數並存至 countString 變數
                        int count1 = Integer.parseInt(countString);
                        //計數器+1
                        if(session.isNew()){//使用新的 Session 連入
                            count1++;
                            countString = String.valueOf(count1); //將整數轉成字串
                            //寫回資料庫
                            sql="UPDATE `countview` SET `count` = " + countString ;
                            con.createStatement().execute(sql);
                        }
                        out.println("目前訪問人次：" + count1);
                    }
                //Step 4: 關閉連線
                con.close();
                }
            }
            catch (SQLException sExec) {
                out.println("SQL錯誤!" + sExec.toString());
                }
        %>
        <nav>
            <ul>
                <li><a href="index.html">首頁</a></li>
                    <li><a href="about.html">關於我們</a></li>
                    <li><a href="register.html">會員註冊</a></li>
                    <li><a href="enter.html">會員登入</a></li>
                    <li><a href="account.html">會員中心</a></li>
                    <li><a href="shoppingcart.html">購物車</a></li>
            </ul>
        </nav>
    </header>

    <!-- 圖片區塊，在 header 下方顯示 -->
    <!-- 底部廣告輪播區域 -->
    <div class="carousel-container">
        <div class="carousel">
            <a href="products/christmas-wagashi-gift-set.html">
                <img src="picture/聖誕和菓子禮盒組.jpg" alt="廣告圖片1">
            </a>
            <a href="products/snowman-daifuku.html">
                <img src="picture/雪人大福.jpg" alt="廣告圖片2">
            </a>
            <a href="products/christmas-party-dorayaki-with-cream.html">
                <img src="picture/聖誕派對生乳銅鑼燒1.jpg" alt="廣告圖片3">
            </a>
            <a href="products/christmas-wagashi-gift-set.html">
                <img src="picture/聖誕和菓子禮盒組.jpg" alt="廣告圖片1">
            </a>
            <a href="products/snowman-daifuku.html">
                <img src="picture/雪人大福.jpg" alt="廣告圖片2">
            </a>
            <a href="products/christmas-party-dorayaki-with-cream.html">
                <img src="picture/聖誕派對生乳銅鑼燒1.jpg" alt="廣告圖片3">
            </a>
        </div>
    </div>
    

    <main class="container">
        <aside class="sidebar">
            <h2>甜點分類</h2>
            <ul>
                <li><a href="sidebar/christmas.html">聖誕節限定甜點</a></li>
                <li><a href="sidebar/season.html">季節限定甜點</a></li>
                <li><a href="sidebar/classical.html">經典日式點心</a></li>
                <li><a href="sidebar/creative.html">創新甜點</a></li>
            </ul>
        </aside>

        <section class="product-view">
            <h2>本店推薦</h2>
            <div class="product-grid">
                <div class="product">
                    <a href="products/pudding.html">
                        <img src="picture/日式布丁.jpg" alt="布丁">
                        <p>布丁</p>
                        <p>價格: NT$150</p>
                    </a>
                </div>
                <div class="product">
                    <a href="products/yokan.html">
                        <img src="picture/羊羹.jpg" alt="羊羹">
                        <p>羊羹</p>
                        <p>價格: NT$150</p>
                    </a>
                </div>
                <div class="product">
                    <a href="products/strawberry-daifuku.html">
                        <img src="picture/草莓大福.jpg" alt="草莓大福">
                        <p>草莓大福</p>
                        <p>價格: NT$150</p>
                    </a>
                </div>
                <div class="product">
                    <a href="products/matcha-cake .html">
                        <img src="picture/抹茶蛋糕.jpg" alt="抹茶蛋糕">
                        <p>抹茶蛋糕</p>
                        <p>價格: NT$150</p>
                    </a>
                </div>
                <div class="product">
                    <a href="products/chestnut-manju.html">
                        <img src="picture/栗子饅頭.jpg" alt="栗子饅頭">
                        <p>栗子饅頭</p>
                        <p>價格: NT$150</p>
                    </a>
                </div>
                <div class="product">
                    <a href="products/water-cake.html">
                        <img src="picture/水信玄餅.jpg" alt="水信玄餅">
                        <p>水信玄餅</p>
                        <p>價格: NT$150</p>
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