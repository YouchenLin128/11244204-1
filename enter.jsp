<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員登入</title>
    <link rel="stylesheet" href="lin.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f3e8d6;
            text-align: center;
            margin: 0;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
        button {
            background-color: #c2a78d;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
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

    <h1 style="border: 5px solid #d3c4b8; border-radius: 5px; display: inline-block; background-color: white; margin-left: 20px;">會員登入</h1>
    
    <form action="enter_process.jsp" method="post">
    <label for="email">請輸入Email:</label>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">請輸入密碼:</label>
    <input type="password" id="password" name="password" required><br><br>

    <button type="submit">確認</button><br><br>
    <a href="forget.jsp">
            <button type="button">忘記密碼</button>
        </a>
        <br><br>

        <a href="register.jsp">
            <button type="button">新手加入→請註冊</button>
        </a>
        
</form>


    <br>
    <div style="display: flex; align-items: center; justify-content: center;">
        <img src="picture/exclamation.png" style="width: 20px; margin-right: 5px;">
        <span>防詐騙提醒：月見甜舖不會以電話或簡訊通知或變更付款方式，或要求以ATM進行任何操作！不應在月見甜舖以外的地方輸入月見甜舖帳密，以免權益受損！</span>
    </div>

    <footer style="text-align: center; margin-bottom: 5px; position: fixed; bottom: 0; width: 100%; padding: 10px;">
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>
</html>
