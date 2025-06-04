<%@ page import="java.sql.*, java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String url = "jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String password = "1234";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);

    String userId = "1"; // 固定userId，實際請改為session取

    String productId = request.getParameter("ProductID");
    String action = request.getParameter("action"); // 取得增減操作

    if (productId != null && action != null) {
        // 先撈出目前數量與價格
        PreparedStatement psCheck = conn.prepareStatement(
            "SELECT Quantity, Price FROM cart_items WHERE UserID=? AND ProductID=?"
        );
        psCheck.setString(1, userId);
        psCheck.setString(2, productId);
        ResultSet rs = psCheck.executeQuery();

        if (rs.next()) {
            int oldQty = rs.getInt("Quantity");
            BigDecimal price = rs.getBigDecimal("Price");

            int newQty = oldQty;
            if ("increase".equals(action)) {
                newQty = oldQty + 1;
            } else if ("decrease".equals(action)) {
                newQty = oldQty - 1;
                if (newQty < 1) newQty = 1; // 數量不得小於1
            }

            BigDecimal newSubtotal = price.multiply(new BigDecimal(newQty));

            PreparedStatement psUpdate = conn.prepareStatement(
                "UPDATE cart_items SET Quantity=?, Subtotal=? WHERE UserID=? AND ProductID=?"
            );
            psUpdate.setInt(1, newQty);
            psUpdate.setBigDecimal(2, newSubtotal);
            psUpdate.setString(3, userId);
            psUpdate.setString(4, productId);
            psUpdate.executeUpdate();
            psUpdate.close();
        }
        rs.close();
        psCheck.close();
    }
    conn.close();

    response.sendRedirect("cart.jsp");
%>
