<%@ page import="java.sql.*, java.util.*, java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    // 連接資料庫並撈購物車資料
    String url = "jdbc:mysql://localhost:3306/work?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String password = "1234";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);

    int userId = 1;  // 假設 user_id = 1
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM cart_items WHERE user_id = ?");
    ps.setInt(1, userId);
    ResultSet rs = ps.executeQuery();

    List<Map<String, Object>> cartItems = new ArrayList<>();
    BigDecimal total = new BigDecimal("0");
    while(rs.next()) {
        Map<String, Object> item = new HashMap<>();
        item.put("id", rs.getInt("id"));
        item.put("product_id", rs.getString("product_id"));
        item.put("product_name", rs.getString("product_name"));
        BigDecimal price = rs.getBigDecimal("product_price");
        item.put("product_price", price);
        int qty = rs.getInt("quantity");
        item.put("quantity", qty);
        item.put("product_image", rs.getString("product_image"));
        cartItems.add(item);
        BigDecimal subtotal = price.multiply(new BigDecimal(qty));
        item.put("subtotal", subtotal); 

        total = total.add(price.multiply(new BigDecimal(qty)));
    }
    rs.close();
    ps.close();
    
    BigDecimal discount = BigDecimal.ZERO;
    BigDecimal threshold = new BigDecimal("500");
    BigDecimal discountAmount = new BigDecimal("10");

    if (total.compareTo(threshold) >= 0) {
        discount = discountAmount;
    }

    BigDecimal finalTotal = total.subtract(discount);
    String confirm = request.getParameter("confirm");
    boolean purchaseSuccess = false;
    if ("yes".equals(confirm)) {
        PreparedStatement insertPs = conn.prepareStatement(
            "INSERT INTO final_price (user_id, finalprice) VALUES (?, ?)");
        insertPs.setInt(1, userId);
        insertPs.setBigDecimal(2, finalTotal);
        insertPs.executeUpdate();
        insertPs.close();
         PreparedStatement clearCartStmt = conn.prepareStatement("DELETE FROM cart_items WHERE user_id = ?");
    clearCartStmt.setInt(1, userId);
    clearCartStmt.executeUpdate();
    clearCartStmt.close();

    conn.close();
    purchaseSuccess = true;
    }
    conn.close();
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
                <td><img src="<%= item.get("product_image") %>" alt="<%= item.get("product_name") %>" class="product-image"></td>
                <td><%= item.get("product_name") %></td>
                <td>$<%= item.get("product_price") %></td>
                <td><%= item.get("quantity") %></td>
                <td><%= item.get("subtotal") %></td>
                <td class="actions">
                    <form action="updateCart.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= item.get("id") %>" />
                        <button name="action" value="increase">+</button>
                        <button name="action" value="decrease">-</button>
                    </form>
                    <form action="deleteCart.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= item.get("id") %>" />
                        <button>移除</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
        <tfoot>
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
    <div style="text-align: right; margin-top: 20px;">
    <form method="post">
        <input type="hidden" name="confirm" value="yes" />
        <button type="submit" class="button" style="margin-right: 70px;"<%= isCartEmpty ? "disabled" : "" %>>確認購買</button>
    </form>
     <% if (isCartEmpty) { %>
        <p style="color:red;">購物車為空，無法購買。</p>
    <% } %>
</div>

<% if (purchaseSuccess) { %>
    <div class="success-msg" style="text-align: center;margin-top: 10px;color: red;">購買成功！3秒後回到首頁...</div>
    <script>
        setTimeout(function() {
            window.location.href = 'index.jsp';
        }, 3000);
    </script>
<% } %>
</body>
</html>
