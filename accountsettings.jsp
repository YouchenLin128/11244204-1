

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<!DOCTYPE html>
<html lang="zh-Hant">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>帳戶設定</title>
    <link rel="stylesheet" href="lin.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@400;700&display=swap" rel="stylesheet">
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
                <li><a href="cart.jsp">購物車</a></li>
            </ul>
        </nav>
    </header>
    <h1 id="title">帳戶設定</h1>
    <form id="myForm" action="accountsettings_process.jsp" method="post" style="text-align: center;">
        姓名:<input type="text" name="realname" placeholder="請輸入真實姓名" required><br><br>
        Email:<input type="email" name="email" placeholder="請輸入Email" required><br><br>
        生日:<label for="birthday"></label> <input type="date" id="birthday" name="birthday" required><br><br>
        電話:<input type="text" name="phone" placeholder="請輸入電話" required><br><br>
        地址:
        <select id="city" name="city" required>
            <option value="">--請選擇市--</option>
            <option value="taipei">台北市</option>
            <option value="kaohsiung">高雄市</option>
            <option value="taichung">台中市</option>
        </select>
        <select id="district" name="district" required>
            <option value="">--請先選擇市--</option>
        </select><br><br>
        <input type="text" name="road" placeholder="請輸入地址" required><br><br>
        <button type="submit">提交</button>
    </form>
    <script>
        const locations = {
            taipei: ['中正區', '大安區', '信義區'],
            kaohsiung: ['苓雅區', '三民區', '左營區'],
            taichung: ['西區', '南區', '北區']
        };
        document.getElementById('city').addEventListener('change', function () {
            const city = this.value;
            const districtSelect = document.getElementById('district');
            districtSelect.innerHTML = '<option value="">--請選擇區--</option>';
            if (city) {
                const districts = locations[city];
                if (districts) {
                    districts.forEach(district => {
                        const option = document.createElement('option');
                        option.value = district;
                        option.textContent = district;
                        districtSelect.appendChild(option);
                    });
                }
            }
        });

    </script>
    <footer style="text-align: center; margin-bottom: 5px; position: fixed; bottom: 0; width: 100%; padding: 10px;">
        <p>© 2024 月見甜鋪 | 甜點讓生活更美好</p>
        <p>聯絡我們：<a href="mailto:contact@mooncakeshop.com">contact@mooncakeshop.com</a></p>
    </footer>
</body>

</html>