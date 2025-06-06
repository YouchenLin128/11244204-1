<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        .text-content p {margin: 5px 0;}
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
                <li><a href="about.jsp">關於我們</a></li>
                <li><a href="register.jsp">會員註冊</a></li>
                <li><a href="enter.jsp">會員登入</a></li>
                <li><a href="account.html">會員中心</a></li>
                <li><a href="shoppingcart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>
    <h1 id="title">購買紀錄</h1>
    <section class="card1">
        <div class="image-container">
            <img src="picture/銅鑼燒.jpg" >
            <div class="product-details">
                <p style="font-weight: bold;">銅鑼燒</p>
                <p>數量:2</p>
                <p>價格:240</p>
            </div>
        </div>
        <div class="image-container">
            <img src="picture/金平糖.jpg" >
            <div class="product-details">
                <p style="font-weight: bold;">金平糖</p>
                <p>數量:1</p>
                <p>價格:100</p>
            </div>
        </div>
         <div style="margin-left: 15px;border-top: 1px solid rgb(176, 163, 163);">
            <div class="text-content">
              <p>訂單日期:2024/11/25</p>
             <p>訂單序號:5464646</p>
             <p>地址:台北市大安區幸福路8號</p>
             <p>商品數量:3</p>
             <p>金額:340</p>
            </div>
        </div>
    </section>
    <section class="card1">
        <div class="image-container">
            <img src="picture/桔大福.jpg">
            <div class="product-details">
                <p style="font-weight: bold;">桔大福</p>
                <p>數量:1</p>
                <p>價格:90</p>
            </div>
        </div>
         <div style="margin-left: 15px;border-top: 1px solid rgb(176, 163, 163);">
            <div class="text-content">
              <p>訂單日期:2024/05/18</p>
             <p>訂單序號:5464746</p>
             <p>地址:台北市大安區幸福路8號</p>
             <p>商品數量:1</p>
             <p>金額:90</p>
            </div>
        </div>
    </section>
    <section class="card1">
        <div class="image-container">
            <img src="picture/蕨餅.jpg" >
            <div class="product-details">
                <p style="font-weight: bold;">蕨餅</p>
                <p>數量:4</p>
                <p>價格:600</p>
            </div>
        </div>
        <div class="image-container">
            <img src="picture/羊羹.jpg" >
            <div class="product-details">
                <p style="font-weight: bold;">羊羹</p>
                <p>數量:2</p>
                <p>價格:200</p>
            </div>
        </div>
        <div class="image-container">
            <img src="picture/金平糖.jpg" alt="產品圖片">
            <div class="product-details">
                <p style="font-weight: bold;">金平糖</p>
                <p>數量:1</p>
                <p>價格:100</p>
            </div>
        </div>
         <div style="margin-left: 15px;border-top: 1px solid rgb(176, 163, 163);">
            <div class="text-content">
              <p>訂單日期:2024/11/25</p>
             <p>訂單序號:5464646</p>
             <p>地址:台灣</p>
             <p>商品數量:7</p>
             <p>金額:900</p>
            </div>
        </div>
    </section>
    <footer>
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>
</html>