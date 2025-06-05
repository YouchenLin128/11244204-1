<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %> 
<%@ page import="jakarta.servlet.http.HttpServletResponse" %> 
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html> 
<html>
<head>
    <title>Cookie Example</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>Cookie 資訊</h1>
    
    <%
        // 宣告變數並初始化
        String lastBrowseTimeValue = null; 
        boolean lastBrowseCookieFound = false; 
    
        // --- 1. 嘗試從請求中獲取所有 Cookie ---
        Cookie cookies[] = request.getCookies();
    
        // --- 2. 檢查是否有任何 Cookie，並遍歷尋找 'last_browse_time' ---
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("last_browse_time".equals(cookie.getName())) {
                    lastBrowseTimeValue = cookie.getValue(); // 抓取最後瀏覽時間
                    lastBrowseCookieFound = true; // 標記為已找到
                    break; // 找到後即可跳出迴圈，因為我們只關心這個特定的 Cookie
                }
            }
        }
    
        //  準備當前時間
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss"); 
        
        
        String currentTime = sdf.format(now);
    
        //設定 Cookie 的有效期限 (10 分鐘) 
        int cookieMaxAge = 10 * 60; 
    
        //創建或更新 'last_browse_time' Cookie ---
        Cookie browseTimeCookie; // 宣告 Cookie 變數
    
        if (lastBrowseCookieFound) {
            // 如果找到了 'last_browse_time' Cookie，則更新其值和過期時間
            browseTimeCookie = new Cookie("last_browse_time", currentTime);
            System.out.println("Updating existing 'last_browse_time' cookie. Old value: " + lastBrowseTimeValue); 
        } else {
            // 如果沒有找到 'last_browse_time' Cookie，則創建一個新的
            browseTimeCookie = new Cookie("last_browse_time", currentTime);
            System.out.println("Creating new 'last_browse_time' cookie."); 
        }
    
        // 設定共同屬性
        browseTimeCookie.setMaxAge(cookieMaxAge); // 設定為 10 分鐘
        browseTimeCookie.setPath("/"); // 整個網站都可見
        browseTimeCookie.setHttpOnly(true); // 推薦：防止客戶端腳本訪問
    
        
        // 實際將 Cookie 加入到 HTTP 回應中 ***
        response.addCookie(browseTimeCookie); 
    
        
    %>
    
    
    <%
    if (lastBrowseCookieFound) {
        
        String displayLastBrowseTime = lastBrowseTimeValue != null ? lastBrowseTimeValue.replace('_', ' ') : "未知時間";
        out.println("<p>您上一次瀏覽的時間是: <b>" + displayLastBrowseTime + "</b></p>");
        out.println("<p>現在您的瀏覽時間已更新為: <b>" + currentTime.replace('_', ' ') + "</b></p>");
    } else {
        out.println("<p>這是您第一次瀏覽本頁 (或之前的 Cookie 已過期)。</p>");
        out.println("<p>您的瀏覽時間已記錄為: <b>" + currentTime.replace('_', ' ') + "</b></p>");
    }
    %>

    <p>這個頁面會根據您是否有 `last_browse_time` Cookie 來更新或創建它。</p>
    <p>您可以在瀏覽器的開發者工具中查看 Cookie 的設定。</p>

</body>
</html>