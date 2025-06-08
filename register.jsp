<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員註冊</title>
    <link rel="stylesheet" href="lin.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            text-align: center;
            background-color: #f3e8d6;
            margin: 0;
        }
        a {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>
    <header>
        <h1>🌙月見甜舖</h1>
        <nav>
            <ul>
                <li><a href="index.jsp">首頁</a></li>
                <li><a href="about.html">關於我們</a></li>
                <li><a href="register.jsp">會員註冊</a></li>
                <li><a href="enter.jsp">會員登入</a></li>
                <li><a href="account.jsp">會員中心</a></li>
                <li><a href="shoppingcart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>
    
    <h1>會員註冊</h1>
    <form id="registration-form" action="register_process.jsp" method="post">
        姓名：<input type="text" name="realname" required placeholder="請輸入真實中文姓名"><br><br>
        Email：<input type="email" name="email" required placeholder="請輸入Email"><br><br>
        生日：<input type="date" name="birthday" required><br><br>
        請設定密碼：<input type="password" name="password1" required placeholder="請輸入密碼"><br><br>
        確認密碼：<input type="password" name="password2" required placeholder="請再一次輸入密碼"><br><br>

        電話：<input type="text" name="phone" placeholder="請輸入電話"><br><br>
        地址：
        <select id="city" name="city">
            <option value="">--請選擇市--</option>
            <option value="taipei">台北市</option>
            <option value="kaohsiung">高雄市</option>
            <option value="taichung">台中市</option>
        </select>
        <select id="district" name="district">
            <option value="">--請先選擇市--</option>
        </select><br><br>
        <input type="text" name="road" placeholder="請輸入地址（如忠孝東路一段100號）"><br><br>

        <button type="submit">立即註冊</button><br>
    </form>

    <div id="success-message" style="display: none;">
        <p style="color: green;text-align: center;">註冊成功</p>
    </div>

    <script>
        // 城市對應區域
        const locations = {
            taipei: ['中正區', '大安區', '信義區'],
            kaohsiung: ['苓雅區', '三民區', '左營區'],
            taichung: ['西區', '南區', '北區']
        };

        document.getElementById('city').addEventListener('change', function () {
            const city = this.value;
            const districtSelect = document.getElementById('district');
            districtSelect.innerHTML = '<option value="">--請選擇區--</option>';
            if (city && locations[city]) {
                locations[city].forEach(function (district) {
                    const option = document.createElement('option');
                    option.value = district;
                    option.textContent = district;
                    districtSelect.appendChild(option);
                });
            }
        });

        // 顯示成功訊息，並在1秒後跳轉回首頁
        function showSuccessMessage() {
            document.getElementById("registration-form").style.display = "none";
            document.getElementById("success-message").style.display = "block";
            setTimeout(function() {
                window.location.href = "index.jsp";
            }, 1000);
        }
    </script>

    <footer style="text-align: center; margin-bottom: 5px; position: fixed; bottom: 0; width: 100%; padding: 10px;">
        <p>© 2024 月見甜舖 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>
</html>
