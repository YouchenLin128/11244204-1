<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 取得表單資料
    String productId = request.getParameter("product_id");
    String productName = request.getParameter("product_name");
    String totalPriceStr = request.getParameter("total_price");
    String reviewContent = request.getParameter("review_content");
    String memberName = request.getParameter("member_name");
    if (memberName == null || memberName.trim().equals("")) {
        memberName = "訪客";
    }
    int rating = Integer.parseInt(request.getParameter("rating"));
    int totalPrice = Integer.parseInt(totalPriceStr);
    String reviewTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/work?serverTimezone=UTC", "root", "1234");

        String insertQuery = "INSERT INTO reviews (member_name, product_id, product_name, total_price, review_content, review_time, rating) VALUES (?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(insertQuery);
        stmt.setString(1, memberName);
        stmt.setString(2, productId);
        stmt.setString(3, productName);
        stmt.setInt(4, totalPrice);
        stmt.setString(5, reviewContent);
        stmt.setString(6, reviewTime);
        stmt.setInt(7, rating);
        stmt.executeUpdate();

        out.println("<script>alert('留言成功！'); window.location.href='" + request.getContextPath() + "/index.jsp';</script>");       
    } catch (Exception e) {
        out.println("留言失敗：" + e.getMessage());
        e.printStackTrace(new java.io.PrintWriter(out));
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
