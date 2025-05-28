<%@ page import="java.sql.*, java.security.MessageDigest, java.math.BigInteger" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");

if ("POST".equalsIgnoreCase(request.getMethod())) {
    String realname = request.getParameter("realname");
    String email = request.getParameter("Email");
    String birthday = request.getParameter("birthday");
    String password1 = request.getParameter("password1");
    String password2 = request.getParameter("password2");

    if (!password1.equals(password2)) {
        out.println("<script>alert('兩次密碼不一致'); history.back();</script>");
        return;
    }

    String hashedPassword = "";
    try {
        hashedPassword = hashPassword(password1);
    } catch (Exception e) {
        out.println("<script>alert('密碼加密錯誤'); history.back();</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/work?serverTimezone=UTC", "root", "1234");

        String sql = "INSERT INTO members (realname, email, birthday, password) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, realname);
        pstmt.setString(2, email);
        pstmt.setString(3, birthday);
        pstmt.setString(4, hashedPassword);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('註冊成功'); location.href='index.jsp';</script>");
            return;
        } else {
            out.println("<script>alert('註冊失敗'); history.back();</script>");
            return;
        }
    } catch (SQLIntegrityConstraintViolationException e) {
        out.println("<script>alert('此 Email 已經註冊'); history.back();</script>");
        return;
    } catch (Exception e) {
        out.println("<script>alert('系統錯誤：" + e.getMessage() + "'); history.back();</script>");
        return;
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
}

// 密碼加密函數
%>
<%! 
public String hashPassword(String password) throws Exception {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
    BigInteger number = new BigInteger(1, hashBytes);
    StringBuilder hashedText = new StringBuilder(number.toString(16));
    while (hashedText.length() < 64) {
        hashedText.insert(0, '0');
    }
    return hashedText.toString();
}
%>
