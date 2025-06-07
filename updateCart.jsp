<%@ page import="java.sql.*" %>
<%
Integer id = (Integer) session.getAttribute("id");
if (id == null) {
    response.sendRedirect("enter.jsp");
    return;
}

String productId = request.getParameter("ProductID");
String action = request.getParameter("action");

if (productId != null && action != null) {
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC", "root", "1234");

        PreparedStatement ps;
        if ("increase".equals(action)) {
            ps = conn.prepareStatement("UPDATE cart_items SET Quantity = Quantity + 1 WHERE id = ? AND ProductID = ?");
        } else if ("decrease".equals(action)) {
            ps = conn.prepareStatement("UPDATE cart_items SET Quantity = Quantity - 1 WHERE id = ? AND ProductID = ? AND Quantity > 1");
        } else {
            response.sendRedirect("cart.jsp");
            return;
        }
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
