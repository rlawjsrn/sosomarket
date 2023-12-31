<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Google font -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
	rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet"
	href="resources/css/bootstrap.min.css?after" />

<!-- Slick -->
<link type="text/css" rel="stylesheet"
	href="resources/css/slick.css?after" />
<link type="text/css" rel="stylesheet"
	href="resources/css/slick-theme.css?after" />

<!-- nouislider -->
<link type="text/css" rel="stylesheet"
	href="resources/css/nouislider.min.css?after" />

<!-- Font Awesome Icon -->
<link rel="stylesheet" href="resources/css/font-awesome.min.css?after">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet"
	href="resources/css/style.css?after" />

</head>
<script type="text/javascript">
	
</script>

<%
String memberId = null;
if (session.getAttribute("memberId") != null) {
	memberId = (String) session.getAttribute("memberId");
}

if (memberId != null) {
%>
<script>
	        
		</script>
<%
}
%>

<body>
	<!-- HEADER -->
	<header>
		<!-- TOP HEADER -->
		<div id="top-header">
			<div class="container">
				<ul class="header-links pull-left">
					<li><a href="#"><i class="fa fa-map-marker"></i> 회사 인증하기</a></li>
				</ul>

				<%
				if (memberId == null) {
				%>
				<ul class="header-links pull-right">
					<li><a href="/SosoMarket/LoginMove.do"><i
							class="fa fa-user-o"></i> 회원가입/로그인</a></li>
				</ul>
				<%
				} else {
				%>
				<ul class="header-links pull-right">
					<li><a id="memberId" href="#"><i class="fa fa-user-o"></i>
							<%=memberId%></a> <a href="/SosoMarket/Logout.do"> /로그아웃</a></li>
				</ul>
				<%
				}
				%>

			</div>
		</div>
		<!-- /TOP HEADER -->

		<!-- MAIN HEADER -->
		<div id="header">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- LOGO -->
					<div class="col-md-3">
						<div class="header-logo">
							<a href="/SosoMarket/Home.do" class="logo"> <img
								src="resources/img/logo.png" alt="">
							</a>
						</div>
					</div>
					<!-- /LOGO -->

					<!-- SEARCH BAR -->
					<div class="col-md-6">
						<div class="header-search">
							<form>
								<select class="input-select">
									<option value="0">전체</option>
									<option value="1">소소거래</option>
									<option value="1">사내이야기</option>
								</select> <input class="input" placeholder="필요한 상품을 검색하세요!">
								<button class="search-btn">검색</button>
							</form>
						</div>
					</div>
					<!-- /SEARCH BAR -->

					<!-- ACCOUNT -->
					<div class="col-md-3 clearfix">
						<div class="header-ctn">
							<!-- Wishlist -->
							<div>
							
								<a class="" data-toggle="" aria-expanded="true"
									href="/SosoMarket/ChatList.do?member_id=<%=memberId %>">
									<i class="fa fa-comment-o"></i>
									<span>소소톡</span>
								</a>
							</div>
							<!-- /Wishlist -->

							<!-- Cart -->
							<div class="dropdown">
								<a class="" data-toggle=""
									aria-expanded="true" href="/SosoMarket/MyPageHome.do?memberId=<%=memberId %>"> <i
									class="fa fa-shopping-cart"></i> <span>마이마켓</span>
								</a>
							</div>
							<!-- /Cart -->
						</div>
					</div>
					<!-- /ACCOUNT -->
				</div>
				<!-- row -->
			</div>
			<!-- container -->
		</div>
		<!-- /MAIN HEADER -->
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<nav id="navigation">
		<!-- container -->
		<div class="container">
			<!-- responsive-nav -->
			<div id="responsive-nav">
				<!-- NAV -->
				<ul class="main-nav nav navbar-nav">
					<li><a href="/SosoMarket/ProdList.do">소소거래</a></li>
					<li><a href="/SosoMarket/CommunityPostList.do">사내이야기</a></li>
					<c:if test="${memberId eq 'admin'}">
						<li><a href="/SosoMarket/AdminMain.do">관리자페이지</a></li>
					</c:if>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
		<!-- /container -->
	</nav>
	<!-- /NAVIGATION -->

	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>


	<script>
        // 자바스크립트로 memberId 값에 따라 링크 보이기/숨기기
        var memberId = "<%=memberId%>";

		if (memberId) {
			document.getElementById('loginLink').style.display = 'none';
			document.getElementById('loggedIn').style.display = 'block';
			document.getElementById('memberIdSpan').innerText = memberId;
		}
	</script>

</body>

</html>
