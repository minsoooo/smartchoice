<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>mgr_header</title>
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			var mng_level = $("#mng_level").attr("value")
		}		
	);
	function fnLogout(){
		location.href ="/manager/manager_logout"
	}
	//mng_level 확인 function
	function fnChooseAdmin(){
		var mng_level = $("#mng_level").attr("value")
		if(mng_level >= 3){
			location.href ="/manager/manager_chooseAdmin";
		}else{
			alert("접근 권한이 없습니다.관리자에게 문의하세요.")
		}
	}
	
	function fnChooseMember(){
		var mng_level = $("#mng_level").attr("value")
		if(mng_level >= 2){
			location.href ="/manager/manager_listMember?page_num=1";
		}else{
			alert("접근 권한이 없습니다.관리자에게 문의하세요.")
		}
	}	
	function fnStatistic(){
		var mng_level = $("#mng_level").attr("value")
		if(mng_level >= 2){
			location.href ="/manager/manager_stats";
		}else{
			alert("접근 권한이 없습니다.관리자에게 문의하세요.")
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
	font-size:15px;
	font-weight:bold;
	margin-right:20px;
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
	<span id ="mng_level" value ="${sessionScope.MNG_KEY.mng_level }"></span>
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
						<div class="span5 offset7" id="header1Div">
							<font id ="mem_id">${sessionScope.MNG_KEY.mng_name } 관리자 님 안녕하세요</font>
							<input type="button" id="btnSignOut" class="btn" value="Sign Out" 
							onclick="javascript:fnLogout()"/>
						</div>
			</div>
		</div>
	</div>
	<!-- 메인메뉴 -->
	<div  id="header2">
		<div class="container">
			<div class="row">
				<div class="span8 offset4">
					<a href="#">카드등록</a>
					<a href="#">혜택수정</a>
					<a href="#">분류관리</a>
					<a href="javascript:fnChooseMember()">회원관리</a>
					<a href="javascript:fnChooseAdmin()">직원관리</a>
					<a href="#">이벤트등록</a>
					<a href="javascript:fnStatistic()">통계보기</a>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>