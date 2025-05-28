<%@ page import="java.sql.*" %>
<%
    String idStr = request.getParameter("id");
    if(idStr != null) {
        int id = Integer.parseInt(idStr);
        String url = "jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "1234";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        PreparedStatement ps = conn.prepareStatement("DELETE FROM cart_items WHERE id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
        ps.close();
        conn.close();
    }
    response.sendRedirect("cart.jsp");
%>
