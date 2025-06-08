<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%!
    // 定義 hashPassword 方法，只寫一次
    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            return null; // 出錯回傳null
        }
    }
%>

<%
    String email = request.getParameter("email");
    String rawPassword = request.getParameter("password");
    
    if (email == null || rawPassword == null || email.trim().isEmpty() || rawPassword.trim().isEmpty()) {
        out.println("請輸入帳號及密碼！");
        return;
    }
    
    email = email.trim();
    rawPassword = rawPassword.trim();

    // 管理者帳號判斷（不經過 hash 與資料庫）
    if (email.equals("12345@gmail.com") && rawPassword.equals("12345")) {
        session.setAttribute("user", "管理者");
        session.setAttribute("isAdmin", true);
        response.sendRedirect("admin.jsp");
        return;
    }

    String password = hashPassword(rawPassword);
    if (password == null) {
        out.println("密碼加密錯誤！");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/work?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPassword = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "SELECT * FROM members WHERE Email = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("realname", rs.getString("realname"));
            session.setAttribute("id", rs.getInt("id"));
            session.setAttribute("member", email);
            response.sendRedirect("index.jsp");
        } else {
%>
            <script>
                alert("帳號或密碼錯誤！");
                window.location.href = "enter.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        out.println("發生錯誤：" + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

