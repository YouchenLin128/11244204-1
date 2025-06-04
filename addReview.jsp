<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新增評論</title>
</head>
<body>
    <h2>新增商品評論</h2>
    <form action="submitReview.jsp" method="post">
        會員名稱：<input type="text" name="member_name"><br>
        商品名稱：<input type="text" name="product_name"><br>
        商品總價格：<input type="text" name="total_price"><br>
        評論內容：<br><textarea name="review_content" rows="5" cols="50"></textarea><br>
        <input type="submit" value="送出">
    </form>
</body>
</html>
