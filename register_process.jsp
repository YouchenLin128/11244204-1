<%@ page import="java.sql.*, java.security.MessageDigest, java.math.BigInteger" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");


if ("POST".equalsIgnoreCase(request.getMethod())) {
    String realname = request.getParameter("realname");
    String email = request.getParameter("email");
    String birthday = request.getParameter("birthday");
    String password1 = request.getParameter("password1");
    String password2 = request.getParameter("password2");
    String phone = request.getParameter("phone");
    String city = request.getParameter("city");
    String district = request.getParameter("district");
    String road = request.getParameter("road");

    if (!password1.equals(password2)) {
        out.println("<script>alert('兩次密碼不一致'); history.back();</script>");
        return;
    }


    out.println("email: " + email + "<br>");
    out.println("realname: " + realname + "<br>");
    out.println("birthday: " + birthday + "<br>");
    out.println("phone: " + phone + "<br>");
    out.println("city: " + city + "<br>");
    out.println("district: " + district + "<br>");
    out.println("road: " + road + "<br>");

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

        String sql = "INSERT INTO members (realname, email, birthday, password, phone, city, district, road) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, realname);
        pstmt.setString(2, email);
        pstmt.setString(3, birthday);
        pstmt.setString(4, hashedPassword);
        pstmt.setString(5, phone);
        pstmt.setString(6, city);
        pstmt.setString(7, district);
        pstmt.setString(8, road);


        int result = pstmt.executeUpdate();
        if (result > 0) {
            session.setAttribute("member", email); // 自動登入
            response.sendRedirect("index.jsp");

            return;
        } else {
            out.println("<script>alert('註冊失敗'); history.back();</script>");
            return;
        }
    } catch (SQLIntegrityConstraintViolationException e) {
        out.println("<script>alert('此 Email 已經註冊'); history.back();</script>");
        return;
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<pre>" + e.toString() + "</pre>");
        return;
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
}

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
