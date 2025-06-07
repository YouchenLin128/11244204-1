<%@ page import="java.sql.*" %>
<%
Integer id = (Integer) session.getAttribute("id");
if (id == null) {
    response.sendRedirect("enter.jsp");
    return;
}

String productId = request.getParameter("productID");

if (productId != null) {
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC", "root", "1234");

        PreparedStatement ps = conn.prepareStatement("DELETE FROM cart_items WHERE id = ? AND ProductID = ?");
        ps.setInt(1, id);
        ps.setString(2, productId);
        ps.executeUpdate();
        ps.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }
}
response.sendRedirect("cart.jsp");
%>
