<%@ page import="java.sql.*, java.util.*, java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String confirm = request.getParameter("confirm");
    String recipientName = request.getParameter("RecipientName");
    String recipientPhone = request.getParameter("RecipientPhone");
    String recipientAddress = request.getParameter("RecipientAddress");
    boolean purchaseSuccess = false;

    String url = "jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "1234";
    Connection conn = null;
    

    // 先宣告這些變數，讓下方能使用
    List<Map<String, Object>> cartItems = new ArrayList<>();
    BigDecimal total = BigDecimal.ZERO;
    BigDecimal discount = BigDecimal.ZERO;
    BigDecimal threshold = new BigDecimal("500");
    BigDecimal discountAmount = new BigDecimal("10");
    BigDecimal finalTotal = BigDecimal.ZERO;

Integer id = (Integer) session.getAttribute("id");
if (id == null) {
    response.sendRedirect("enter.jsp");
    return;
}



Exception exception = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // 取出購物車商品
        PreparedStatement ps = conn.prepareStatement(
            "SELECT  ProductID, ProductName, Price, ProductImage, Quantity FROM cart_items WHERE id=?"
        );
        ps.setInt(1, id);  // 一定要加上這行！
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("ProductID", rs.getString("ProductID"));
            item.put("ProductName", rs.getString("ProductName"));
            BigDecimal price = rs.getBigDecimal("Price");
            item.put("Price", price);
            int qty = rs.getInt("Quantity");
            item.put("Quantity", qty);
            item.put("ProductImage", rs.getString("ProductImage"));
            BigDecimal subtotal = price.multiply(new BigDecimal(qty));
            item.put("Subtotal", subtotal);
            cartItems.add(item);
            total = total.add(subtotal);
        }
        rs.close();
        ps.close();

        // 計算折扣
        if (total.compareTo(threshold) >= 0) {
            discount = discountAmount;
        }

        finalTotal = total.subtract(discount);

        // 如果收到購買確認，且購物車不為空，執行購買流程
        if ("yes".equals(confirm) && !cartItems.isEmpty()) {
            Timestamp buyTime = new Timestamp(System.currentTimeMillis());
    PreparedStatement orderStmt = conn.prepareStatement(
        "INSERT INTO orders (id, finalTotal, buy_time, RecipientName, RecipientPhone, RecipientAddress) VALUES (?, ?, ?, ?, ?, ?)",
        Statement.RETURN_GENERATED_KEYS
    );
            orderStmt.setInt(1, id);
            orderStmt.setBigDecimal(2, finalTotal);
            orderStmt.setTimestamp(3, buyTime);
            orderStmt.setString(4, recipientName);
            orderStmt.setString(5, recipientPhone);
            orderStmt.setString(6, recipientAddress);
            orderStmt.executeUpdate();

    // 取得自動產生的 OrderID
    ResultSet generatedKeys = orderStmt.getGeneratedKeys();
    int orderId = -1;
    if (generatedKeys.next()) {
        orderId = generatedKeys.getInt(1);
    }
    orderStmt.close();

    // 再插入每個商品到 order_items
    for (Map<String, Object> item : cartItems) {
    // 插入到 order_items
    PreparedStatement itemStmt = conn.prepareStatement(
        "INSERT INTO order_items (OrderID, ProductID, ProductName, Quantity, Price, ProductImage) VALUES (?, ?, ?, ?, ?, ?)"
    );
    itemStmt.setInt(1, orderId);
    itemStmt.setString(2, item.get("ProductID").toString());
    itemStmt.setString(3, item.get("ProductName").toString());
    itemStmt.setInt(4, (Integer) item.get("Quantity"));
    itemStmt.setBigDecimal(5, (BigDecimal) item.get("Price"));
    itemStmt.setString(6, item.get("ProductImage").toString());
    itemStmt.executeUpdate();
    itemStmt.close();

    // 更新庫存
    PreparedStatement updateStockStmt = conn.prepareStatement(
        "UPDATE shop.product SET Stock = Stock - ? WHERE ProductID = ? AND Stock >= ?"
    );
    int qty = (Integer) item.get("Quantity");
    updateStockStmt.setInt(1, qty);
    updateStockStmt.setString(2, item.get("ProductID").toString());
    updateStockStmt.setInt(3, qty);
    int updatedRows = updateStockStmt.executeUpdate();
    updateStockStmt.close();

    if (updatedRows == 0) {
        throw new SQLException("庫存不足，ProductID: " + item.get("ProductID"));
    }
}

    PreparedStatement clearCartStmt = conn.prepareStatement(
                "DELETE FROM cart_items WHERE id=?"
            );
            clearCartStmt.setInt(1, id);
            clearCartStmt.executeUpdate();
            clearCartStmt.close();

            purchaseSuccess = true;
            // 購買成功，清空 cartItems 和重算
            cartItems.clear();
            total = BigDecimal.ZERO;
            discount = BigDecimal.ZERO;
            finalTotal = BigDecimal.ZERO;
        }


            

    } catch (Exception e) {
        exception = e;
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
    <% if (exception != null) { %>
    <div style="color: red; font-weight: bold;">
        發生錯誤：<br />
        <pre><%= exception.toString() %></pre>
    </div>
<% } 
out.println("confirm = " + confirm);
%>





<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8" />
    <title>購物車</title>
    <link rel="stylesheet" href="lin.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .button {
        background-color: #c2a78d; 
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 15px;}
        .cart-item {
            margin-bottom: 20px;
        }
        .cart-item img {
            width: 100px;
            height: auto;
            margin-right: 10px;
        }
        .cart-item div {
            display: inline-block;
            vertical-align: top;
        }
        .total-amount {
            font-size: 1.5em;
            font-weight: bold;
        }
        .container {
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #f3e8d6;
        }
        .product-image {
            width: 150px;
           
            object-fit: cover;
        }
        .actions button {
            padding: 5px 10px;
            border: none;
            background-color: #c2a78d; /* 按钮背景色 */
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }

        .actions button:hover {
            background-color: #c2a78d; 
        }

        .total {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
        }

        footer {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <h1>🌙月見甜舖</h1>
        <nav>
            <ul>
                <li><a href="index.jsp">首頁</a></li>
                <li><a href="about.jsp">關於我們</a></li>
                <li><a href="register.jsp">會員註冊</a></li>
                <li><a href="enter.jsp">會員登入</a></li>
                <li><a href="account.jsp">會員中心</a></li>
                <li><a href="cart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>
    <table>
        <thead>
            <tr>
                <th>商品圖片</th>
                <th>商品名稱</th>
                <th>價格</th>
                <th>數量</th>
                <th>金額</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        <% for (Map<String,Object> item : cartItems) { %>
            <tr>
                <td><img src="<%= item.get("ProductImage") %>" alt="<%= item.get("ProductName") %>" class="product-image"></td>
                <td><%= item.get("ProductName") %></td>
                <td>$<%= item.get("Price") %></td>
                <td><%= item.get("Quantity") %></td>
                <td><%= item.get("Subtotal") %></td>
                <td class="actions">
                    <form action="updateCart.jsp" method="post">
                        <input type="hidden" name="ProductID" value="<%= item.get("ProductID") %>" />
                        <button name="action" value="increase">+</button>
                        <button name="action" value="decrease">-</button>
                    </form>

                    <form action="deleteCart.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= id %>" />
                        <input type="hidden" name="productID" value="<%= item.get("ProductID") %>" />
                        <button>移除</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
        <tfoot>
            <%
out.println("目前購物車有 " + cartItems.size() + " 項商品。");
%>

            <tr>
                <td colspan="5" style="text-align: right;">總金額:</td>
                <td>$<%= total %></td>
                <% if (discount.compareTo(BigDecimal.ZERO) > 0) { %>
            <tr>
                <td colspan="5" style="text-align: right;" class="discount">滿500折扣:</td>
                <td class="discount">-$<%= discount %></td>
            </tr>
            <tr>
                <td colspan="5" style="text-align: right; font-weight: bold;">折扣後總金額:</td>
                <td><strong>$<%= finalTotal %></strong></td>
            </tr>
            <% } %>
            </tr>
        </tfoot>
    </table>
    <%boolean isCartEmpty = cartItems.isEmpty();%>
    <form method="post" onsubmit="return validateForm()">
    <input type="hidden" name="confirm" value="yes" />
    <div style="text-align:right; margin-right:70px;">
        <label>收件人姓名: <input type="text" name="RecipientName" required></label><br>
        <label>電話: <input type="text" name="RecipientPhone" required></label><br>
        <label>地址: <input type="text" name="RecipientAddress" required></label><br><br>
        <button type="submit" class="button"<%= isCartEmpty ? "disabled" : "" %>>確認購買</button>
    </div>
</form>

<script>
function validateForm() {
    const name = document.querySelector('[name="RecipientName"]').value.trim();
    const phone = document.querySelector('[name="RecipientPhone"]').value.trim();
    const address = document.querySelector('[name="RecipientAddress"]').value.trim();
    if (!name || !phone || !address) {
        alert("請填寫完整收件人資訊！");
        return false;
    }
    return true;
}
</script>

<% if (purchaseSuccess) { %>
    <div class="success-msg" style="text-align: center;margin-top: 10px;color: green;">購買成功！3秒後回到首頁...</div>
    <script>
        setTimeout(function() {
            window.location.href = 'index.jsp';
        }, 3000);
    </script>
<% } %>
</body>
</html>

