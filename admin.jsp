<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // 管理者驗證
    if (session.getAttribute("isAdmin") == null || !(Boolean)session.getAttribute("isAdmin")) {
        response.sendRedirect("enter.jsp");
        return;
    }
%>

<html>
<head>
    <title>管理者後台</title>
</head>
<body>
    <h1>歡迎，<%= session.getAttribute("user") %>！</h1>
    <h2>這是管理者後台</h2>

    <ul>
        <li><a href="member_list.jsp">查看會員列表</a></li>
        <li><a href="product_manage.jsp">管理商品</a></li>
        <li><a href="logout.jsp">登出</a></li>
    </ul>
</body>
</html>
