const userDiv = document.getElementById('user');
let isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
userDiv.addEventListener('click', function() {
    if (isLoggedIn) {
        window.location.href = 'account.html'; 
    } else {
        window.location.href = 'enter.html';
    }
});
document.addEventListener("DOMContentLoaded", function () {
    const loginButton = document.getElementById("loginButton");

    loginButton.addEventListener("click", function () {
        const username = document.getElementById("username").value.trim();
        const password = document.getElementById("password").value.trim();

        if (!username || !password) {
            alert("帳號或密碼不可空白！");
            return;
        }

        // 模擬伺服器驗證
        const correctUsername = "123";
        const correctPassword = "123";

        if (username === correctUsername && password === correctPassword) {
            localStorage.setItem("isLoggedIn", "true");
            alert("登入成功！");
            window.location.href = "index.html"; // 登入後跳轉
        } else {
            alert("帳號或密碼錯誤，請重新輸入！");
        }
    });
});

