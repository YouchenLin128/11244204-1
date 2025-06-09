<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    String name = request.getParameter("ProductName");
    int categoryID = Integer.parseInt(request.getParameter("CategoryID"));
    int price = Integer.parseInt(request.getParameter("Price"));
    String description = request.getParameter("Description");
    String content1 = request.getParameter("Content1");
    String content2 = request.getParameter("Content2");
    int stock = Integer.parseInt(request.getParameter("Stock"));
    String image = request.getParameter("ProductImage");
    String picName = request.getParameter("PictureName");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/shop?serverTimezone=UTC", "root", "1234");

        String sql = "INSERT INTO product (ProductName, CategoryID, Price, Description, Content1, Content2, Stock, ProductImage, PictureName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setInt(2, categoryID);
        pstmt.setInt(3, price);
        pstmt.setString(4, description);
        pstmt.setString(5, content1);
        pstmt.setString(6, content2);
        pstmt.setInt(7, stock);
        pstmt.setString(8, image);
        pstmt.setString(9, picName);

        pstmt.executeUpdate();
        out.println("<script>alert('商品新增成功！'); location.href='admin.jsp';</script>");
    } catch (Exception e) {
        out.println("錯誤：" + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
