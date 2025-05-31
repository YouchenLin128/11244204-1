<%
    session.invalidate(); // 清除所有 session 資料
    response.sendRedirect("enter.jsp"); // 登出後導回登入頁
%>
