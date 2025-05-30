// 商品圖片切換
const images = ["picture2/水信玄餅.jpg", "picture2/水信玄餅2.jpg",];
let currentImageIndex = 0;
const productImage = document.getElementById("productImage");
document.querySelector(".prev").addEventListener("click", () => {
    currentImageIndex = (currentImageIndex - 1 + images.length) % images.length;
    productImage.src = images[currentImageIndex];
});
document.querySelector(".next").addEventListener("click", () => {
    currentImageIndex = (currentImageIndex + 1) % images.length;
    productImage.src = images[currentImageIndex];
});

// 商品數量增減
const decreaseButton = document.querySelector(".quantity-decrease");
const increaseButton = document.querySelector(".quantity-increase");
const quantityInput = document.querySelector(".quantity-selector input");

decreaseButton.addEventListener("click", () => {
    let currentQuantity = parseInt(quantityInput.value);
    if (currentQuantity > 1) {
        quantityInput.value = currentQuantity - 1;
    }
});

increaseButton.addEventListener("click", () => {
    let currentQuantity = parseInt(quantityInput.value);
    quantityInput.value = currentQuantity + 1;
});

const favoriteButton = document.querySelector(".add-to-favorites .heart");
favoriteButton.addEventListener("click", () => {
    const isFavorited = localStorage.getItem("favorited");
    if (isFavorited === "true") {
        favoriteButton.textContent = "♡";
        favoriteButton.classList.remove("red");
        localStorage.removeItem("favorited");
    } else {
        favoriteButton.textContent = "♥";
        favoriteButton.classList.add("red");
        localStorage.setItem("favorited", "true");
    }
});

// 保留收藏狀態
window.addEventListener("load", () => {
    if (localStorage.getItem("favorited") === "true") {
        favoriteButton.textContent = "♥";
        favoriteButton.classList.add("red");
    }
});


// 詳細內容區標籤切換
const detailTabs = document.querySelectorAll(".detail-tabs button");
const tabContents = document.querySelectorAll(".tab-content");

detailTabs.forEach(tab => {
    tab.addEventListener("click", () => {
        // 移除所有按鈕的 active 樣式
        detailTabs.forEach(btn => btn.classList.remove("active"));
        // 隱藏所有內容
        tabContents.forEach(content => (content.style.display = "none"));

        // 設定當前按鈕和內容
        tab.classList.add("active");
        const targetTabContent = document.getElementById(tab.getAttribute("data-tab"));
        targetTabContent.style.display = "block";
    });
});

// 推薦商品動態生成
const recommendedProducts = [
    {
        name: "蕨餅",
        price: "NT$ 150",
        img: "picture2/蕨餅.jpg",
        link: "./warabi-mochi.jsp"
    },
    {
        name: "草莓大福",
        price: "NT$ 150",
        img: "picture2/草莓大福.jpg",
        link: "./strawberry-daifuku.jsp"
    },
    {
        name: "醬油糰子",
        price: "NT$ 150",
        img: "picture2/醬油糰子.jpg",
        link: "./soy-sauce-dango.jsp"
    }
];

const recommendationsContainer = document.querySelector(".recommendations");
recommendedProducts.forEach(product => {
    console.log("link:", product.link); // 🔍 確認是否正確是 .jsp
    const productElement = document.createElement("div");
    productElement.className = "recommendation";
    productElement.innerHTML = `
        <a href="${product.link}">
            <img src="${product.img}" alt="${product.name}">
            <h4>${product.name}</h4>
            <p>${product.price}</p>
        </a>
    `;
    recommendationsContainer.appendChild(productElement);
});

// script.js

document.addEventListener("DOMContentLoaded", () => {
    // ========== 評論功能 ==========
    const reviewForm = document.getElementById("review-form");
    const reviewMessage = document.getElementById("review-message");
    const existingReviews = document.querySelector(".existing-reviews");
    const localStorageKey = "productReviewData";

    function loadReviews() {
        try {
            const storedReviews = JSON.parse(localStorage.getItem(localStorageKey)) || [];
            storedReviews.forEach(review => {
                addReviewToPage(review.name, review.stars, review.comment);
            });
        } catch (error) {
            console.error("Error loading reviews:", error);
            localStorage.removeItem(localStorageKey);
        }
    }

    function addReviewToPage(name, stars, comment) {
        const newReview = document.createElement("div");
        newReview.classList.add("review");
        newReview.innerHTML = `
            <p><strong>${name}</strong></p>
            <p>${"⭐".repeat(stars)}${"☆".repeat(5 - stars)}</p>
            <p>${comment}</p>
        `;
        existingReviews.appendChild(newReview);
    }

    function saveReview(name, stars, comment) {
        const storedReviews = JSON.parse(localStorage.getItem(localStorageKey)) || [];
        storedReviews.push({ name, stars, comment });
        localStorage.setItem(localStorageKey, JSON.stringify(storedReviews));
    }

    reviewForm.addEventListener("submit", (e) => {
        e.preventDefault();

        const stars = parseInt(document.getElementById("stars").value);
        const comment = document.getElementById("comment").value;
        const name = "烏薩奇";

        addReviewToPage(name, stars, comment);
        saveReview(name, stars, comment);

        reviewMessage.style.display = "block";
        reviewForm.reset();
        setTimeout(() => {
            reviewMessage.style.display = "none";
        }, 3000);
    });

    loadReviews();
    const tabs = document.querySelectorAll(".detail-tabs button");
    const tabContents = document.querySelectorAll(".tab-content");

    tabs.forEach((tab) => {
        tab.addEventListener("click", () => {
            tabs.forEach((t) => t.classList.remove("active"));
            tab.classList.add("active");
            tabContents.forEach((content) => {
                content.style.display =
                    content.id === tab.dataset.tab ? "block" : "none";
            });
        });
    });
});

