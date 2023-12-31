<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

<%String memberId = (String) session.getAttribute("member_id");%>


var textarea = document.getElementById("msgWrite");
var webSocket = new WebSocket('ws://localhost:8097/SosoMarket/broadcasting');

webSocket.onerror = function(event){
	onError(event)
};

webSocket.onopen = function(event){
	onOpen(event)
};

webSocket.onmessage = function(event) {
    onMessage(event)
};

function onOpen(event) {
    console.log("열림");
}

function send() {
	alert("hjk");
	var chat_id = "${prodVo.chat_id }";
	var chat_message = document.getElementById("msgWrite").value;
	var member_Id = "${prodVo.current_id }";
	var generation_date = "${prodVo.generation_date}"
	console.log(chat_id + "채팅 아이디");
	console.log(chat_message + "메시지");
	console.log(member_Id + "아이디");
	console.log(generation_date + "일자");
	var chat = "/SosoMarket/chatInsert.do?chat_id="+chat_id+"&chat_message="+chat_message+"&memberId="+memberId;
	// Ajax를 이용해 LikeList 호출
	$.ajax({
		url : chat,
		method : 'POST',
		data: { memberId: memberId,
				chat_id : chat_id,
				chat_message : chat_message}, // 전송할 데이터
		success : function(data) {
			if (data) {
				var message = "<div class='outgoing_msg'><div class='sent_msg'><p>"+chat_message+"</p><span class='time_date'>"+generation_date+"</span></div></div>";
				$("#msgWrite").val("");
				console.log(message);
				console.log($(".msg_history"));
				$(".msg_history").append(message);
				webSocket.send(chat_message, generation_date);
			}
		},
		error : function(error) {
			console.error('Error:', error);
		}
	});
};


function enterkey() {
    if (window.event.keyCode == 13) {
        send();
    }
}


webSocket.onmessage = function(event) {
	var receivedMessage = event.data; // 서버에서 받은 메시지
    var messageContainer = document.querySelector('.msg_history'); // 메시지를 표시할 컨테이너

    var message = "<div class='incoming_msg'><div class='received_msg'><div class='received_withd_msg'><p>"+receivedMessage+"</p><span class='time_date'></span></div></div></div>";

    // 메시지를 컨테이너에 추가
    messageContainer.innerHTML += message;
};



</script>
</head>

<body>
	<script>

/* 후기창 띄우기 */
document.getElementById("call_review").addEventListener("click", function(event) {
    event.preventDefault();
    var reviewDiv = document.getElementById("review");
    reviewDiv.classList.remove("hidden");
    }
});
function openReview() {
	var reviewDiv = document.getElementById("review");
    reviewDiv.classList.remove("hidden");
}


</script>

	<div class="msg_info">
		<!-- 상품 사진 -->
		<div class="prod_img">
			<img src="./upload/${photoVO.prodPhotoName }.png?after" alt="photo">
		</div>
		<!-- 상품 이름/상태/가격 -->
		<div class="prod_txt">
			<p class="prod_name">
				${prodVo.product_name }
				<!-- 상품 상태 -->
				<c:choose>
					<c:when test="${prodVo.product_status eq '0'}">
						<span style="color: #4685D0;">판매중</span>
					</c:when>
					<c:when test="${prodVo.product_status eq '1'}">
						<span>판매완료</span>
					</c:when>
					<c:when test="${prodVo.product_status eq '2'}">
						<span style="color: #29CF78;">예약중</span>
					</c:when>
				</c:choose>
			</p>
			<p class="prod_pric">${prodVo.product_price }원</p>
		</div>
		<div class="prod_stat_sel">
			<ul class="prod_stat_ul">
				<!-- 상품 상태 변경 -->
				<!-- 판매중, 예약중이며 로그인 계정 == 판매자 계정일 때 -->
				<c:if test="${prodVo.buyer_id != memberId}">
					<c:choose>
						<c:when test="${prodVo.product_status eq 0}">
							<li class="prod_stat_li"><a
								href="/SosoMarket/ProdStat.do?product_status='1'&product_id=${prodVo.product_id }&chat_id=${prodVo.chat_id }">판매</a></li>
							<li class="prod_stat_li"><a
								href="/SosoMarket/ProdStat.do?product_status='2'&product_id=${prodVo.product_id }">예약</a></li>
						</c:when>
						<c:when test="${prodVo.product_status eq 2}">
							<li class="prod_stat_li"><a
								href="/SosoMarket/ProdStat.do?product_status='1'&product_id=${prodVo.product_id }">판매
									완료</a></li>
							<li class="prod_stat_li"><a
								href="/SosoMarket/ProdStat.do?product_status='0'&product_id=${prodVo.product_id }">예약
									취소</a></li>
						</c:when>
					</c:choose>
				</c:if>
				<c:if
					test="${prodVo.product_status == 1 && (prodVo.buy_mem_id == memberId || prodVo.buy_mem_id == prodVo.other_mem_id)}">
					<li class="prod_stat_li long"><a id="call_review" href="#"
						onclick="openReview()">거래 후기 작성</a></li>
				</c:if>
			</ul>
		</div>
	</div>

	<!-- 채팅창 내부 -->
	<div class="msg_history">
		<c:forEach var="vo" items="${list }">
			<c:choose>
				<c:when test="${vo.member_id eq memberId }">
					<div class="outgoing_msg">
						<div class="sent_msg">
							<p>${vo.chat_message }</p>
							<span class="time_date">${vo.generation_date }</span>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="incoming_msg">
						<div class="received_msg">
							<div class="received_withd_msg">
								<p>${vo.chat_message }</p>
								<span class="time_date">${vo.generation_date }</span>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<div class="type_msg">
		<div class="input_msg_write">
			<input type="text" class="write_msg" id="msgWrite"
				placeholder="메시지 보내기" onkeyup="enterkey()" />
			<button class="msg_send_btn" type="button" id="chatbtn"
				onclick="send()">
				<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
			</button>
		</div>
	</div>

	<!-- 후기 -->
	<div id="review" class="hidden">
		<div class="review_container">
			<h3>${prodVo.other_mem_id }님과의거래는어떠셨나요?</h3>
			<form method="post" id="reviewForm">
				<div class="review_sel">
					<input type="radio" id="good" name="score" value="2"
						class="custom-radio"> <label for="good">좋았어요!</label>
				</div>
				<div class="review_sel">
					<input type="radio" id="soso" name="score" value="1"
						class="custom-radio"> <label for="soso">무난했어요~</label>
				</div>
				<div class="review_sel">
					<input type="radio" id="bad" name="score" value="3"
						class="custom-radio"> <label for="bad">별로였어요..</label>
				</div>
				<br>
				<button class="primary-btn" onclick="submitReview()">후기 남기기</button>
			</form>
			<button class="close_btn" onclick="closeReview()">
				<img src="https://cdn.icon-icons.com/icons2/2518/PNG/512/x_icon_150997.png" alt=""> 
			</button>
		</div>
	</div>
</body>
<script>



/* 후기창 열기 */
function openReview() {
	var reviewDiv = document.getElementById("review");
    reviewDiv.classList.remove("hidden");
}

/* 후기창 닫기 */
function closeReview() {
	var reviewDiv = document.getElementById("review");
    reviewDiv.classList.add("hidden");
}

/* 후기 등록 */
function submitReview() {
    var score = document.querySelector('input[name="score"]:checked').value;
    var member_id = "${prodVo.other_mem_id }";
    var product_id = "${prodVo.product_id }";

    $.ajax({
        type: "POST",
        url: "/SosoMarket/ReviewServlet",
        data: {
            score: score,
            member_id: member_id,
            product_id: product_id
        },
        success: function(result) {
            // 성공 시 알람창 띄우기
            if (result == 1) {
            	alert("후기가 성공적으로 등록되었습니다.");
            } else {
            	alert("후기 등록에 실패하였습니다. 다시 등록해주세요.");
            }
        }
    });
}


</script>

</html>
