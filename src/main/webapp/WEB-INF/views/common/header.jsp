<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap.min.css" />
</head>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#header1{
	background-color:#4e4a41;
	height:50px;
	text-align:right;
}

#header2{
	background-color:#5c554b;
	height:70px;
}

#btnSignIn{
	margin-right:20px;
	border: 0;
	outline: 0;
}
#btnSignOut{
	margin-left:20px;
}

#header1 a{
	color:#d9d5cc;
}

#header1 a:hover, #header1 a:focus, #header1 a:active, 
#header2 a:hover, #header2 a:focus, #header2 a:active{
	color:#fff;
	text-decoration:none;
}

#header2 a{
	color:#d9d5cc;
	font-size:22px;
	font-weight:bold;
	margin-right:85px;
	font-family: 'Noto Sans KR', sans-serif;
}

#header2 .span12{
	margin-top:23px;
	text-align:right;
}

.btn {
	display: inline-block;
	padding: 6px 12px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: 400;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: none;
	background-color:#5c554b;
	color:#d9d5cc; 
	border: 1px solid transparent;
	border-radius: 4px
}

.btn:hover, .btn:focus{
	background-color:#675c4c;
	color:#fff;
}

</style>
<body>
	<!-- 로고 -->
	<div class="container">
		<div class="row">
			<div class="span3" style="position:absolute;">
				<img src="/resources/images/logo.jpg"/>
			</div>
		</div>
	</div>

	
	<div  id="header1">
		<div class="container">
			<div class="row">				
				<!-- 로그인 및 회원가입 -->
				<div class="span2" style="margin-top:8px;">
					<input type="button" id="btnSignIn" class="btn" value="Sign In" />
					<a href="#">Join Now</a>
				</div>
				
				<!-- 아이디 및 로그아웃 
				<div class="span2" style="margin-top:8px;">
					<font style="color:#d9d5cc">아이디</font>
					<input type="button" id="btnSignOut" class="btn" value="Sign Out" />
				</div>
				-->
			</div>
		</div>
	</div>
	
	<!-- 메인메뉴 -->
	<div  id="header2">
		<div class="container">
			<div class="row">
				<div class="span12">
					<a href="#">카드추천</a>
					<a href="/accountbook/index">지출관리</a>
					<a href="#">매장찾기</a>
					<a href="#">이벤트</a>
					<a href="#">공지사항</a>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>