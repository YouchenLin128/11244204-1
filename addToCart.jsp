<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String productId = request.getParameter("ProductID");
    String productName = request.getParameter("ProductName");
    String priceStr = request.getParameter("ProductPrice");
    String quantityStr = request.getParameter("Quantity");
    String productImage = request.getParameter("ProductImage");

    // 從 session 拿 orderId (存的是字串)
    String orderIdStr = (String) session.getAttribute("orderId");
    Integer orderId = null;
    if (orderIdStr != null) {
        try {
            orderId = Integer.valueOf(orderIdStr);
        } catch (NumberFormatException e) {
            orderId = null; // 格式錯誤就視為無
        }
    }

    if(productId == null || productName == null || priceStr == null || quantityStr == null) {
        out.println("缺少必要參數");
        return;
    }

    double price = 0;
    int quantity = 0;
    try {
        price = Double.parseDouble(priceStr);
        quantity = Integer.parseInt(quantityStr);
    } catch(NumberFormatException e) {
        out.println("價格或數量格式錯誤");
        return;
    }

    double subtotal = price * quantity;
    int userId = 1; // 假設使用者ID固定

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/work?serverTimezone=UTC";
        String user = "root";
        String password = "1234";

        Connection conn = DriverManager.getConnection(url, user, password);
        String sql;
        PreparedStatement pstmt;

        if (orderId == null) {
            // 第一次加入商品，先插入沒有 OrderID 的紀錄（假設資料表允許 OrderID NULL 或是先不帶）
            // 或是先插入訂單主表取得新 OrderID，再加入明細（較好設計）
            // 這裡用假設先插入 cart_items 且讓 OrderID 自動生成 (若有設計 auto_increment)
            sql = "INSERT INTO cart_items (UserID, ProductID, ProductName, Price, Quantity, Subtotal, ProductImage) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, userId);
            pstmt.setString(2, productId);
            pstmt.setString(3, productName);
            pstmt.setDouble(4, price);
            pstmt.setInt(5, quantity);
            pstmt.setDouble(6, subtotal);
            pstmt.setString(7, productImage);

            pstmt.executeUpdate();

            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
                // 存回 session，要用字串
                session.setAttribute("orderId", String.valueOf(orderId));
            }

            rs.close();
            pstmt.close();

        } else {
            // 已有 orderId ，使用同一訂單號插入
            sql = "INSERT INTO cart_items (UserID, ProductID, ProductName, Price, Quantity, Subtotal, ProductImage) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, userId);
            pstmt.setString(2, productId);
            pstmt.setString(3, productName);
            pstmt.setDouble(4, price);
            pstmt.setInt(5, quantity);
            pstmt.setDouble(6, subtotal);
            pstmt.setString(7, productImage);

            pstmt.executeUpdate();
            pstmt.close();
        }

        conn.close();
        response.sendRedirect("cart.jsp");

    } catch (Exception e) {
        out.println("錯誤：" + e.getMessage());
    }
%>
