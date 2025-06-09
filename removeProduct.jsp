<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    int productId = Integer.parseInt(request.getParameter("ProductID"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/shop?serverTimezone=UTC", "root", "1234");

        String sql = "UPDATE product SET Stock = 0 WHERE ProductID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, productId);

        int rowsUpdated = pstmt.executeUpdate();
        if (rowsUpdated > 0) {
            out.println("<script>alert('商品已成功下架！'); location.href='admin.jsp';</script>");
        } else {
            out.println("<script>alert('找不到該商品'); location.href='admin.jsp';</script>");
        }
    } catch (Exception e) {
        out.println("錯誤：" + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
