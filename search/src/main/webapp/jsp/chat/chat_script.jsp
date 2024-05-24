<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>챗봇</title>
	</head>
	<script type="text/javascript" src="/jsp/chat/js/chat.js"></script>
	<link rel="stylesheet" type="text/css"href="<c:url value='/jsp/chat/css/style.css' />" media="all" />
	<body>
		<a id="chat_btn" href="javascript:void(0)" style="display: inline;" onclick="chatWindow()"><i class="xi-wechat"></i></a>
		
		<div class="chat-container" id="chat-container" style="display: none">
			<div class="chat-log" id="chat-log">
				<div class="message bot">무엇을 도와드릴까요?</div>
			</div>
			<input type="text" id="user-input" placeholder="메시지를 입력하세요..."> <!-- 사용자 입력 필드 -->
			<button type="button" id="send-button" onclick="qustionSubmit()">보내기</button> <!-- 메시지 전송 버튼 -->
			<div class="loading-indicator" id="loading-indicator">
				<div class="spinner"></div>
			</div>
		</div>
	</body>
</html>

