<%@ page import="java.sql.*" %>
<%
    String idStr = request.getParameter("id");
    String action = request.getParameter("action");
    if(idStr != null && action != null) {
        int id = Integer.parseInt(idStr);
        String url = "jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "1234";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        if("increase".equals(action)) {
            PreparedStatement ps = conn.prepareStatement("UPDATE cart_items SET quantity = quantity + 1 WHERE id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
            ps.close();
        } else if("decrease".equals(action)) {
            PreparedStatement ps = conn.prepareStatement("UPDATE cart_items SET quantity = quantity - 1 WHERE id = ? AND quantity > 1");
            ps.setInt(1, id);
            int affected = ps.executeUpdate();
            ps.close();

            if(affected == 0) {
                // 如果 quantity 是 1，減少時刪除商品
                ps = conn.prepareStatement("DELETE FROM cart_items WHERE id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
            }
        }
        conn.close();
    }
    response.sendRedirect("cart.jsp");
%>
