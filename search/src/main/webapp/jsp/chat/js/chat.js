$(document).ready(function(){
	$("#user-input").keyup(function(){
		if (window.event.keyCode == 13) {
			event.preventDefault(); // 폼 기본 제출 동작 막기
			qustionSubmit();
		}
	});
});

// 챗봇 대화 화면
function chatWindow(){
	if ($('#chat-container').css('display') != 'none') {
		$('#chat-container').css('display','none');
	} else {
		$('#chat-container').css('display','block');
	}
}

// 사용자 입력 폼 제출 이벤트 처리
function qustionSubmit() {
	disableUserInput(); // 사용자 입력 비활성화
	const message = $('#user-input').val(); // 사용자 입력 값
	displayMessage(message, 'user'); // 사용자 입력 표시
	showLoadingIndicator(); // 로딩 표시 활성화
	
	const botResponse = sendData(message); // 챗봇 응답 받아오기
}

// 챗봇 응답 받아오기
function sendData(message) {
	$.ajax({
		 type : 'post'
		,url : "http://192.168.2.118:8090/chatbot"
		,dataType : 'json'
		,data: { "message" : message }
		,success : function(result) {
			hideLoadingIndicator(); // 로딩 표시 비활성화
			displayMessage(result.result, 'bot'); // 챗봇 응답 표시
			enableUserInput(); // 사용자 입력 활성화
			$('#user-input').val(''); // 입력 필드 초기화
		}
		,error : function(request, status, error) {
			hideLoadingIndicator();
			alert('연결에 실패했습니다.');
		}
	});
}
 
// 사용자 입력 비활성화
function disableUserInput() {
	$('#user-input').attr('disabled','disabled');
}
 
// 사용자 입력 활성화
function enableUserInput() {
	$('#user-input').removeAttr('disabled');
}
 
// 로딩 표시 활성화
function showLoadingIndicator() {
	document.getElementById('loading-indicator').style.display = 'flex';
}
 
// 로딩 표시 비활성화
function hideLoadingIndicator() {
	document.getElementById('loading-indicator').style.display = 'none';
}

// 메시지를 채팅 로그에 표시
function displayMessage(message, sender) {
	const messageElement = document.createElement('div');
	messageElement.classList.add('message', sender);
	messageElement.textContent = message;
	$('#chat-log').append(messageElement);
}