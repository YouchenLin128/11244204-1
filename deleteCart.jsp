<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String productId = request.getParameter("productID");
    String userIdStr = request.getParameter("userID");

    out.println("收到的 productID=" + productId + "<br>");
    out.println("收到的 userID=" + userIdStr + "<br>");

    if (productId == null || productId.trim().isEmpty()) {
        out.println("錯誤：缺少 productID");
        return;
    }
    if (userIdStr == null || userIdStr.trim().isEmpty()) {
        out.println("錯誤：缺少 userID");
        return;
    }

    int userId = Integer.parseInt(userIdStr);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "1234";
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "DELETE FROM cart_items WHERE UserID=? AND ProductID=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setString(2, productId);

        int rows = ps.executeUpdate();
        ps.close();
        conn.close();

        out.println("刪除影響行數：" + rows + "<br>");

        if (rows > 0) {
            response.sendRedirect("cart.jsp");
        } else {
            out.println("找不到指定商品，刪除失敗");
        }

    } catch (Exception e) {
        out.println("刪除錯誤：" + e.getMessage());
    }
%>
