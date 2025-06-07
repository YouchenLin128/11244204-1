<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 檢查是否登入，抓 session 中的會員 id
    String memberIdRaw = String.valueOf(session.getAttribute("id"));

    if (memberIdRaw == null || memberIdRaw.equals("null")) {
        response.sendRedirect("enter.jsp"); // 未登入導回登入頁
        return;
    }

    int memberId = Integer.parseInt(memberIdRaw); // 將字串轉為整數

    // 預設會員資料
    String realname = "", birthday = "", email = "", phone = "", address = "";

    // 資料庫連線資訊
    String url = "jdbc:mysql://localhost:3306/work?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPassword = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "SELECT * FROM members WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, memberId);  // 正確使用整數參數

        rs = pstmt.executeQuery();

        if (rs.next()) {
            realname = rs.getString("realname");
            birthday = rs.getString("birthday");
            email = rs.getString("email");
            phone = rs.getString("phone");

            String city = rs.getString("city");
            String district = rs.getString("district");
            String road = rs.getString("road");
            address = city + district + road;
        }

    } catch (Exception e) {
        out.println("資料讀取錯誤：" + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>


<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員資料</title>
    <link rel="stylesheet" href="lin.css">
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
                <li><a href="shoppingcart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>

    <h1 style="border: 5px solid #d3c4b8; border-radius: 5px; display: inline-block; background-color: white;margin-left: 20px;">
        我的資料
    </h1>

    <div style="text-align: center;">
        <img src="picture/usigi.jpg" width="200px" style="border-radius: 50%;">
        <p>姓名: <%= realname %></p>
        <p>生日: <%= birthday %></p>
        <p>Email: <%= email %></p>
        <p>會員電話: <%= phone %></p>
        <p>會員地址: <%= address %></p>
        <a href="accountsettings.jsp"><button type="button">修改資料</button></a>
    </div>

    <footer style="text-align: center; margin-top: 30px; width: 100%; padding: 10px; position: relative;">
        <p>© 2024 月見甜鋪 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>

</html>
