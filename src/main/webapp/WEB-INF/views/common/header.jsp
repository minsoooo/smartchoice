
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	function fnLogin(){
		window.open("/member/login","","width=350,height=200,top=+300,left=+500");
	}
	
	function fnLogout(){
		location.href ="/member/logout";
	}
	function fnMngLogout(){
		location.href ="/manager/logout";
	}
	function fnUpdate(){
		window.open("/member/update","","width=350,height=200,top=+300,left=+500");
	}
	
	function fnAccount(){
		var mem_num = $("#mem_num").attr("value")
		var mng_num = $("#mng_num").attr("value")
		if(mem_num != ""){
			location.href ="/accountbook/index"
		}else if(mng_num != ""){
			alert("접근 권한이 없습니다.")
		}else{
			alert("로그인이 필요합니다.");
			fnLogin();
		}
	}


</script>
</head>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#mem_id {
	font-size:15px;
	color: #669aba;
	font-weight:bold;
	margin-left: 40px;
	margin-right:20px;
	
}
#header1{
	background-color:#4e4a41;
	height:50px;
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

#header1Div{
	margin-top:8px;
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
	font-size:20px;
	font-weight:bold;
	margin-right:40px;
	font-family: 'Noto Sans KR', sans-serif;
}

#header2 .span8{
	margin-top:23px;
}

#btnSignIn, #btnSignOut{
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

#btnSignIn:hover, #btnSignIn:focus, #btnSignOut:hover, #btnSignOut:focus{

	background-color:#675c4c;
	color:#fff;
}

</style>

<body>
	<span id ="mem_num" value ="${sessionScope.MEM_KEY.mem_num }"></span>
	<span id ="mng_num" value ="${sessionScope.MNG_KEY.mng_num }"></span>
	<!-- 로고 -->
	<div class="container">
		<div class="row">
			<div class="span4" style="position:absolute;">
				<a href ="/"><img src="/resources/images/logo.jpg"/></a>
			</div>
		</div>
	</div>
	
	<div  id="header1">
		<div class="container">

			<div class="row">
				<c:choose>
					<c:when test="${sessionScope.MEM_KEY ne null }">
						<div class="span6 offset6" id="header1Div">
							<font id ="mem_id">${sessionScope.MEM_KEY.mem_id } 님 안녕하세요</font>
							<a href="javascript:fnUpdate()">개인정보수정</a><input type="button" id="btnSignOut" class="btn" value="Sign Out" 
							onclick="javascript:fnLogout()"/>
						</div>
					</c:when>
					<c:when test="${sessionScope.MNG_KEY ne null }">
						<div class="span6 offset6" id="header1Div">
							<font id ="mem_id">${sessionScope.MNG_KEY.mng_name } 관리자 님 안녕하세요</font>
							<input type="button" id="btnSignOut" class="btn" value="Sign Out" 
							onclick="javascript:fnMngLogout()"/>
						</div>
					</c:when>
					<c:otherwise>
						<div class="span3 offset9" id="header1Div">
							<input type="button" id="btnSignIn" class="btn" value="Sign In" 
							onclick="javascript:fnLogin()"/>
							<a href="/member/member">Join Now</a>
						</div>
						

					</c:otherwise>
				</c:choose>			
			</div>
		</div>
	</div>
	<!-- 메인메뉴 -->
	<div  id="header2">
		<div class="container">
			<div class="row">
				<div class="span8 offset4">
					<a href="/planCard/planIntro.plan">카드추천</a>
					<a href="javascript:fnAccount()">지출관리</a>
					<a href="#">매장찾기</a>
					<a href="#">이벤트</a>
					<a href="#">공지사항</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>