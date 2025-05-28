<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 取得表單資料
    String email = request.getParameter("email").trim();
    String password = request.getParameter("password").trim();
    String password_confirm = request.getParameter("password_confirm").trim();

    if (!password.equals(password_confirm)) {
%>
    <script>
        alert("密碼與確認密碼不符，請重新輸入！");
        history.back();
    </script>
<%
        return;
    }

    // 加密密碼（直接寫在此，不定義函式）
    String hashedPassword = "";
    try {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] bytes = md.digest(password.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        hashedPassword = sb.toString();
    } catch (Exception e) {
        out.println("密碼加密錯誤：" + e.getMessage());
        return;
    }

    // 連線資料庫參數
    String url = "jdbc:mysql://localhost:3306/work?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPassword = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // 先確認帳號是否存在
        String checkSql = "SELECT * FROM members WHERE Email = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
%>
    <script>
        alert("帳號不存在，請確認輸入的 Email！");
        history.back();
    </script>
<%
            return;
        }
        rs.close();
        pstmt.close();

        // 更新密碼
        String updateSql = "UPDATE members SET password = ? WHERE Email = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setString(1, hashedPassword);
        pstmt.setString(2, email);

        int rowCount = pstmt.executeUpdate();
        if (rowCount > 0) {
%>
    <script>
        alert("密碼已更新成功，請重新登入！");
        window.location.href = "enter.jsp";
    </script>
<%
        } else {
%>
    <script>
        alert("密碼更新失敗，請稍後再試！");
        history.back();
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
