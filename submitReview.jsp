<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String memberName = request.getParameter("member_name");
    String productName = request.getParameter("product_name");
    String reviewContent = request.getParameter("review_content");
    int rating = Integer.parseInt(request.getParameter("rating"));
    int productId = Integer.parseInt(request.getParameter("product_id")); // 轉為 int 以便驗證

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Step 1: 驗證 product_id 是否存在於 shop.product
        Connection shopConn = DriverManager.getConnection("jdbc:mysql://localhost/shop?serverTimezone=UTC", "root", "1234");
        PreparedStatement checkProduct = shopConn.prepareStatement("SELECT productID FROM product WHERE id = ?");
        checkProduct.setInt(1, productId);
        ResultSet productCheck = checkProduct.executeQuery();

        if (!productCheck.next()) {
            throw new Exception("⚠️ 商品編號無效，無法新增評論。");
        }

        productCheck.close();
        checkProduct.close();
        shopConn.close();

        // Step 2: 驗證該會員是否購買過此商品（在 work 資料庫中）
        conn = DriverManager.getConnection("jdbc:mysql://localhost/work?serverTimezone=UTC", "root", "1234");

        // 查找該會員的 member_id
        PreparedStatement getMemberId = conn.prepareStatement("SELECT member_id FROM members WHERE member_name = ?");
        getMemberId.setString(1, memberName);
        rs = getMemberId.executeQuery();

        int memberId = -1;
        if (rs.next()) {
            memberId = rs.getInt("id");
        } else {
            throw new Exception("⚠️ 找不到會員帳號，請重新登入。");
        }
        rs.close();
        getMemberId.close();

        // 檢查是否曾購買該商品
        PreparedStatement checkPurchase = conn.prepareStatement(
            "SELECT oi.product_id FROM orders o " +
            "JOIN order_items oi ON o.order_id = oi.order_id " +
            "WHERE o.member_id = ? AND oi.product_id = ?"
        );
        checkPurchase.setInt(1, memberId);
        checkPurchase.setInt(2, productId);
        rs = checkPurchase.executeQuery();

        if (!rs.next()) {
%>
            <script>
                alert("⚠️ 您尚未購買過此商品，無法評論。");
                history.back();
            </script>
<%
            rs.close();
            checkPurchase.close();
            conn.close();
            return; // 結束執行
        }
        rs.close();
        checkPurchase.close();

        // Step 3: 寫入評論資料
        String insertSQL = "INSERT INTO reviews (member_name, product_id, product_name, review_content, rating, review_time) VALUES (?, ?, ?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(insertSQL);
        pstmt.setString(1, memberName);
        pstmt.setInt(2, productId);
        pstmt.setString(3, productName);
        pstmt.setString(4, reviewContent);
        pstmt.setInt(5, rating);

        int row = pstmt.executeUpdate();
        if (row > 0) {
%>
            <script>
                alert("✅ 評論成功送出！");
                window.history.back();
            </script>
<%
        } else {
%>
            <p style="color: red;">⚠️ 評論寫入失敗。</p>
<%
        }

    } catch (Exception e) {
%>
        <p style="color: red;">發生錯誤：<%= e.getMessage() %></p>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
