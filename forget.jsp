<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>忘記密碼</title>
    <link rel="stylesheet" href="lin.css">
    <script src="lin.js" defer></script> 
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
                <li><a href="shoppingcart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>

    <h1 id="title">忘記密碼</h1>

    <form action="forget_process.jsp" method="post" style="text-align: center;">
        <label for="email">請輸入Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="password">請輸入新的密碼:</label>
        <input type="password" id="password" name="password" required><br><br>

        <label for="password_confirm">確認密碼:</label>
        <input type="password" id="password_confirm" name="password_confirm" required><br><br>

        <button type="submit">確認</button>
    </form>

    <br>
    <div style="display: flex; align-items: center; justify-content: center;">
        <img src="picture/exclamation.png" style="width: 20px; margin-right: 5px;">
        <span>防詐騙提醒：月見甜舖不會以電話或簡訊通知或變更付款方式，或要求以ATM進行任何操作！</span>
    </div>

    <footer>
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>
</html>
