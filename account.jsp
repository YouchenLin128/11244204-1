<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("realname");
    Integer memberIDObject = (Integer) session.getAttribute("id");

    if (username == null || memberIDObject == null) {
        response.sendRedirect("enter.jsp");
        return;
    }

    String memberID = String.valueOf(memberIDObject);
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>會員中心</title>
    <link rel="stylesheet" href="lin.css">
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

    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h1 id="title">會員中心</h1>
        <form action="logout.jsp" method="post" style="margin-right: 50px;">
            <button type="submit" style="text-align: center;">登出</button>
        </form>
    </div>

    <section style="display: flex; align-items: center; justify-content: space-between; padding-right: 200px;">
        <div style="display: flex; align-items: center;">
            <img style="border-radius: 50%;" src="picture/usigi.jpg" width="150px" alt="Profile Picture">
            <div style="display: flex; flex-direction: column; padding-left: 20px;font-size: large;">
                <p style="margin: 0;"><%= username %></p>
                <p style="margin: 0; color: gray;">會員編號: <%= memberID %></p>
            </div>
        </div>
        <!-- 點數與折價券資訊（可先寫死測試） -->
        <div style="display: flex; gap: 20px; align-items: center;">
            <div style="text-align: center;border: 1px solid#f3e8d6;border-radius: 50px;background-color:#f3e8d6;">
                <img src="picture/coin.png" width="50px" alt="Exclamation Icon">
                <p>我的點數</p>
                <p style="color: #5e4f45;">537點</p>
            </div>
            <div style="text-align: center;border: 1px solid#f3e8d6;border-radius: 50px;background-color:#f3e8d6;">
                <img src="picture/coupons.png" width="50px" alt="Exclamation Icon">
                <p>折價券</p>
                <p style="color: #5e4f45;">537張</p>
            </div>
        </div>
    </section>

    <!-- 其他會員功能按鈕（資料、訂單、評價...） -->
    <section style="background-color:  #f3e8d6;border-radius: 25px;">
        <div style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 20px; padding-left: 20px; padding-top: 20px;">
            <div style="text-align: center;">
                <a href="data.jsp"><img src="picture/user.png" style="width: 40px;"></a>
                <div><a href="data.jsp">會員資料</a></div>
            </div>
            <div style="text-align: center;">
                <a href="order.html"><img src="picture/checkout.png" style="width: 40px;"></a>
                <div><a href="order.html">購買紀錄</a></div>
            </div>
            <div style="text-align: center;">
                <a href="comment.html"><img src="picture/check-list.png" style="width: 40px;"></a>
                <div><a href="comment.html">我的評價</a></div>
            </div>
            <div style="text-align: center;">
                <a href="mailto:example@example.com"><img src="picture/customer-support.png" style="width: 40px;"> </a>
                <div><a href="mailto:example@example.com">聯絡客服</a></div>
            </div>
        </div>
    </section>
    <footer>
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>
</html>
