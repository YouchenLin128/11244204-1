<%@ page import="java.security.MessageDigest" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>


<%!
    // 用 Record Declaration 宣告方法，不能有 throws，自己處理例外
    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for(byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            return null; // 出錯回傳null
        }
    }
%>

<%
    String email = request.getParameter("email").trim();
    String rawPassword = request.getParameter("password").trim();
    String password = hashPassword(rawPassword);

    if (password == null) {
        out.println("密碼加密錯誤！");
        return;
    }

    // 以下資料庫連線、查詢代碼保持不變
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
            session.setAttribute("user", rs.getString("realname"));
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
