<%@ page import="java.sql.*, java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 資料庫連線參數
    String url = "jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String password = "1234";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);

    // 取得使用者操作
    int itemId = Integer.parseInt(request.getParameter("id"));
    String action = request.getParameter("action");

    // 查出原本的數量與價格
    PreparedStatement selectStmt = conn.prepareStatement("SELECT quantity, product_price FROM cart_items WHERE id = ?");
    selectStmt.setInt(1, itemId);
    ResultSet rs = selectStmt.executeQuery();

    if (rs.next()) {
        int quantity = rs.getInt("quantity");
        BigDecimal price = rs.getBigDecimal("product_price");

        if ("increase".equals(action)) {
            quantity++;
        } else if ("decrease".equals(action) && quantity > 1) {
            quantity--;
        }

        BigDecimal subtotal = price.multiply(new BigDecimal(quantity));

        // 更新數量與小計
        PreparedStatement updateStmt = conn.prepareStatement(
            "UPDATE cart_items SET quantity = ?, subtotal = ? WHERE id = ?"
        );
        updateStmt.setInt(1, quantity);
        updateStmt.setBigDecimal(2, subtotal);
        updateStmt.setInt(3, itemId);
        updateStmt.executeUpdate();
        updateStmt.close();
    }

    rs.close();
    selectStmt.close();
    conn.close();

    response.sendRedirect("cart.jsp");
%>
