<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // 檢查是否已有登入的 session
    String id = (String) session.getAttribute("id"); // 或改成 "user" 根據你 login.jsp 的設計

    if (id == null || id.equals("")) {
        // 尚未登入，導向登入頁面
        response.sendRedirect("enter.jsp"); // 你可以改為 login.jsp 或其他登入頁面
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>會員專區</title>
</head>
<body>
    <h2>歡迎回來，<%= id %>！</h2>
    <p>這是會員專屬頁面，只有登入的會員才能看到這裡的內容。</p>

    <p><a href="logout.jsp">登出</a></p>
</body>
</html>
