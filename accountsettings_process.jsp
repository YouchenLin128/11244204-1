<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");

    String idStr = String.valueOf(session.getAttribute("id"));
    if (idStr == null || idStr.equals("null") || idStr.isEmpty()) {
        response.sendRedirect("enter.jsp");
        return;
    }
    int id = Integer.parseInt(idStr);

    String realname = request.getParameter("realname");
    String email = request.getParameter("email");
    String birthday = request.getParameter("birthday");
    String phone = request.getParameter("phone");
    String city = request.getParameter("city");
    String district = request.getParameter("district");
    String road = request.getParameter("road");

    if (realname == null || realname.trim().isEmpty() ||
        email == null || email.trim().isEmpty() ||
        birthday == null || birthday.trim().isEmpty() ||
        phone == null || phone.trim().isEmpty() ||
        city == null || city.trim().isEmpty() ||
        district == null || district.trim().isEmpty() ||
        road == null || road.trim().isEmpty()) {
%>
        <script>
            alert("請完整填寫所有欄位！");
            history.back();
        </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/work?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC",
            "root", "1234");

        String sql = "UPDATE members SET realname=?, email=?, birthday=?, phone=?, city=?, district=?, road=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, realname.trim());
        pstmt.setString(2, email.trim());
        pstmt.setString(3, birthday.trim());
        pstmt.setString(4, phone.trim());
        pstmt.setString(5, city.trim());
        pstmt.setString(6, district.trim());
        pstmt.setString(7, road.trim());
        pstmt.setInt(8, id);

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            session.setAttribute("realname", realname);  // ← 加這行

%>
            <script>
                alert('更新成功！');
                window.location.href = 'account.jsp';
            </script>
<%
        } else {
%>
            <script>
                alert('更新失敗，請再試一次。');
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        String errorMsg = e.getMessage();
        if (errorMsg != null && errorMsg.contains("Duplicate entry") && errorMsg.contains("members.email")) {
%>
        <script>
            alert("錯誤：這個 Email 已經被註冊過了，請換一個！");
            history.back();
        </script>
<%
        } else {
%>
        <script>
            alert("系統錯誤：<%= errorMsg.replaceAll("'", "\\\\'") %>");
            history.back();
        </script>
<%
        }
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
