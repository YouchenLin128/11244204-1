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

        total = total.add(price.multiply(new BigDecimal(qty)));
    }
    rs.close();
    ps.close();
    conn.close();
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8" />
    <title>購物車</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Serif TC', serif;
        }
        .button {
            background-color: #c2a78d; 
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
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
            background-color: #c2a78d;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            margin: 0 3px;
        }
        .actions button:hover {
            background-color: #a4876d;
        }
        tfoot td {
            font-weight: bold;
            font-size: 18px;
            text-align: right;
            padding-right: 20px;
        }
    </style>
</head>
<body>
    <h1>🌙月見甜舖 - 購物車</h1>
    <table>
        <thead>
            <tr>
                <th>商品圖片</th>
                <th>商品代號</th>
                <th>商品名稱</th>
                <th>價格</th>
                <th>數量</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        <% for (Map<String,Object> item : cartItems) { %>
            <tr>
                <td><img src="<%= item.get("product_image") %>" alt="<%= item.get("product_name") %>" class="product-image"></td>
                <td><%= item.get("product_id") %></td>
                <td><%= item.get("product_name") %></td>
                <td>$<%= item.get("product_price") %></td>
                <td><%= item.get("quantity") %></td>
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
            </tr>
        </tfoot>
    </table>
</body>
</html>
