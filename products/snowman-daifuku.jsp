<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Step 0: import library --> 
<%@ page import = "java.sql.*, java.util.*" %> 

<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>雪人大福</title>
    <link rel="stylesheet" href="product.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
    <script defer src="script.js"></script>
</head>
<body>
    <!-- 固定在頁面頂部的推播區域，包含訊息 -->
    <div class="ad-banner">
        <b>
            <p>📣即日起至6/30，購買任何商品滿500元現折10元！</p>
        </b>
    </div>

    <!-- header 區塊 -->
    <header>
        <h1>🌙月見甜舖</h1>
        <nav>
            <ul>
                <li><a href="../index.jsp">首頁</a></li>
                <li><a href="../about.html">關於我們</a></li>
                <li><a href="../register.jsp">會員註冊</a></li>
                <li><a href="../enter.jsp">會員登入</a></li>
                <li><a href="../account.jsp">會員中心</a></li>
                <li><a href="../cart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <div class="container">
            <!-- 側邊欄 -->
            <aside class="sidebar">
                <h2>甜點分類</h2>
                <ul id="categories">
                    <ul class="subcategory">
                        <%!
                        String[] categoryArray;
                        %>
                        <%
                        // Step 1: 連接資料庫
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                        Connection con = DriverManager.getConnection(url, "root", "1234");
                        
                        if (con.isClosed()) {
                            out.println("連線建立失敗");
                        } else {

                            request.setCharacterEncoding("UTF-8");

                            // 宣告 Statement
                            Statement stmt = con.createStatement();

                            // 第一次查詢資料筆數
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM category");
                            rs.next();
                            int count = rs.getInt(1);
                            rs.close();

                            // 使用全域變數
                            categoryArray = new String[count];

                            // 第二次查詢實際資料
                            rs = stmt.executeQuery("SELECT CategoryName FROM category");
                            int index = 0;
                            while (rs.next()) {
                                categoryArray[index] = rs.getString("categoryName");
                                index++;
                            }

                            rs.close();
                            stmt.close();
                            con.close();
                        }
                        %>
                        <li><a href="../sidebar/christmas.jsp"><%=categoryArray[0]%></a></li>
                        <li><a href="../sidebar/season.jsp"><%=categoryArray[1]%></a></li>
                        <li><a href="../sidebar/classical.jsp"><%=categoryArray[2]%></a></li>
                        <li><a href="../sidebar/creative.jsp"><%=categoryArray[3]%></a></li>
                    </ul>
                
                </ul>
            </aside>

            <!-- 商品詳情 -->
            <%!
                String productID = "";
                String productName = "";
                String productPrice = "";
                String productDescription = "";
                String content1 = "";
                String content2 = "";
                String stock = "";
                String pictureName = "";
                String productImage = "";
            %>

            <%
                // Step 1: 連接資料庫
                Class.forName("com.mysql.jdbc.Driver");
                url = "jdbc:mysql://localhost/shop?serverTimezone=UTC";
                con = DriverManager.getConnection(url, "root", "1234");
                if (con.isClosed()) {
                    out.println("連線建立失敗");
                } else {
                    request.setCharacterEncoding("UTF-8");
                    String product = "SELECT * FROM product WHERE ProductName = '雪人大福'";
                    ResultSet pd = con.createStatement().executeQuery(product);

                    if(pd.next()) {
                        productName = pd.getString("ProductName");
                        productPrice = pd.getString("Price");
                        productDescription = pd.getString("Description");
                        content1 = pd.getString("Content1");
                        content2 = pd.getString("Content2");
                        stock = pd.getString("Stock");
                        pictureName = pd.getString("PictureName");
                        productID = pd.getString("ProductID");
                        productImage = pd.getString("ProductImage");
                    }
                    pd.close();
                    con.close();
                }
            %>

            <section class="product-detail">
                <div class="product-gallery">
                    <button class="prev">←</button>
                        <img id="productImage" src="picture2/<%=pictureName%>" alt="雪人大福">
                    <button class="next">→</button>
                </div>
                <h2 class="product-title"><%=productName%></h2>
                <div class="product-info">
                    <div class='null'></div>
                    <p class="price">NT$ <%=productPrice%></p>
                    <p class='quantity'>庫存：<%=stock%></p>
                </div>
                <p class="description">
                    <%=productDescription%>
                </p>
                <form action="<%= request.getContextPath() %>/addToCart.jsp" method="post">
                    <input type="hidden" name="ProductID" value="<%= productID %>">
                    <input type="hidden" name="ProductName" value="<%= productName %>">
                    <input type="hidden" name="ProductPrice" value="<%= productPrice %>">
                    <input type="hidden" name="ProductImage" value="<%= productImage %>">

                
                    <div class="quantity-selector"> 數量：
                        <button type="button" class="quantity-decrease">-</button>
                        <input type="number" name="Quantity" min="1" value="1" required>
                        <button type="button" class="quantity-increase">+</button>
                    </div>

                    <div class="product-actions">
                        <button type="submit" class="add-to-cart">加入購物車</button>
                        <button type="button" class="add-to-favorites">
                            <span class="heart">♡</span> 收藏商品
                        </button>
                    </div>
                </form>
            </section>
        </div>

        <!-- 詳細內容與小分類頁 -->
        <section class="product-tabs">
            <div class="detail-tabs">
                <button class="active" data-tab="details">商品詳細內容</button>
                <button data-tab="shipping">出貨與付款方式</button>
                <button data-tab="notice">下單注意事項</button>
                <button data-tab="assess">顧客評價</button>
            </div>
            <div class="tab-content" id="details">
                <h3>商品詳細內容</h3>
                <p><%=content1%></p>
            </div>
            <div class="tab-content" id="shipping" style="display: none;">
                <h3>出貨與付款方式</h3>
                <p>付款方式：信用卡、轉帳、行動支付(Linepay)、到店取貨付款。<br>出貨時間：下單後 3 個工作天內出貨。</p>
            </div>
            <div class="tab-content" id="notice" style="display: none;">
                <h3>下單注意事項</h3>
                <p>本商品需冷藏保存，避免高溫環境放置，請於收到商品後7天內食用完畢。</p>
            </div>
            <div class="tab-content" id="assess" style="display: none;">
                <!-- 評論區塊 -->
                <div class="reviews">
                    <h3>顧客評論</h3>

                    <!-- 現有評論 -->
                    <div class="existing-reviews">
                        <div class="review">
                            <p><strong>小碩</strong></p>
                            <p>⭐⭐⭐⭐⭐</p>
                            <p>太好吃了，推薦！</p>
                        </div>
                        <div class="review">
                            <p><strong>小哲</strong></p>
                            <p>⭐⭐⭐⭐☆</p>
                            <p>小孩很喜歡！已回購~</p>
                        </div>
                    </div>

                    <!-- 新增評論表單 -->
                    <div class="add-review">
                        <h4>新增評論</h4>
                        <form id="review-form">
                            <div class="rating">
                                <label for="stars">給予評分：</label>
                                <select id="stars" name="stars" required>
                                    <option value="">選擇評分</option>
                                    <option value="5">⭐⭐⭐⭐⭐</option>
                                    <option value="4">⭐⭐⭐⭐☆</option>
                                    <option value="3">⭐⭐⭐☆☆</option>
                                    <option value="2">⭐⭐☆☆☆</option>
                                    <option value="1">⭐☆☆☆☆</option>
                                </select>
                            </div>
                            <textarea id="comment" name="comment" placeholder="請輸入您的評論" rows="4" required></textarea>
                            <button type="submit">送出評論</button>
                        </form>
                        <p id="review-message" style="display: none; color: green;">評論已新增！</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 推薦商品 -->
        <section class="recommended-products">
            <h3>推薦商品</h3>
            <div class="recommendations">
                <!-- 這裡將由 JS 動態生成推薦商品 -->
            </div>
        </section>


        <script>
            document.querySelector('.add-to-cart').addEventListener('click', function () {
        // 獲取商品資訊
        const productTitle = document.querySelector('.product-title').textContent;
        const productPrice = parseInt(document.querySelector('.price').textContent.replace('NT$', ''));
        const quantity = parseInt(document.querySelector('.quantity-selector input').value);
        const productImage = document.getElementById('productImage').src;
    
        // 創建商品物件
        const product = {
            name: productTitle,
            price: productPrice,
            quantity: quantity,
            image: productImage,
        };
    
        // 獲取現有購物車數據
        let cart = JSON.parse(localStorage.getItem('cart')) || [];
    
        // 檢查是否已存在該商品
        const existingProductIndex = cart.findIndex(item => item.name === product.name);
        if (existingProductIndex !== -1) {
            // 若商品已存在，則更新數量
            cart[existingProductIndex].quantity += product.quantity;
        } else {
            // 否則新增商品
            cart.push(product);
        }
    
        // 儲存更新後的購物車
        localStorage.setItem('cart', JSON.stringify(cart));
    
        // 更新購物車數量顯示
        let count = cart.reduce((total, item) => total + item.quantity, 0);
        const cartText = document.getElementById('cart-text');
        if (cartText) {
            cartText.textContent = `購物車`;
        }
    
        // 顯示成功訊息
        alert(`${productTitle} 已加入購物車！`);
    });
        </script>
    

    <footer>
        <p>© 2024 月見甜鋪</p>
    </footer>
</body>
</html>
