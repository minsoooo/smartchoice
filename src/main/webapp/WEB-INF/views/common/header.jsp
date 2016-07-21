<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script>
	function fnLogin(){
		window.open("/member/login","","width=350,height=200,top=+400,left=+600");
	}

</script>
</head>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#mem_id {
	font-size:15px;
	color: #669aba;
	margin-left: 40px;
	
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

#btnSignIn:hover, .#btnSignIn:focus, #btnSignOut:hover, .#btnSignOut:focus{
	background-color:#675c4c;
	color:#fff;
}

</style>
<body>
	<!-- ë¡œê³  -->
	<div class="container">
		<div class="row">
			<div class="span4" style="position:absolute;">
				<img src="/resources/images/logo.jpg"/>
			</div>
		</div>
	</div>
	
	<div  id="header1">
		<div class="container">

			<div class="row">
				<c:choose>
					<c:when test="${sessionScope.MEM_KEY eq null }">
						<div class="span3 offset9" id="header1Div">
							<input type="button" id="btnSignIn" class="btn" value="Sign In" 
							onclick="javascript:fnLogin()"/>
							<a href="/member/member">Join Now</a>
						</div>
					</c:when>
					
					<c:otherwise>
						<div class="span5 offset8" id="header1Div">
							<font id ="mem_id">${sessionScope.MEM_KEY.mem_id } ë‹˜ ì•ˆë…•í•˜ì„¸ìš”</font>
							<a href="/member/logout">Log Out</a>
						</div>
					</c:otherwise>
				</c:choose>			
			</div>
		</div>
	</div>
	
<<<<<<< HEAD
	<!-- ¸ŞÀÎ¸Ş´º -->
	<div  id="header2">
		<div class="container">
			<div class="row">
				<div class="span8 offset4">
					<a href="/planCard/planIntro.plan">Ä«µåÃßÃµ</a>
					<a href="/accountbook/index">ÁöÃâ°ü¸®</a>
					<a href="#">¸ÅÀåÃ£±â</a>
					<a href="#">ÀÌº¥Æ®</a>
					<a href="#">°øÁö»çÇ×</a>
=======
	<!-- ë©”ì¸ë©”ë‰´ -->
	<div  id="header2">
		<div class="container">
			<div class="row">
				<div class="span8 offset4">
					<a href="/planCard/planIntro.plan">ì¹´ë“œì¶”ì²œ</a>
					<a href="/accountbook/index">ì§€ì¶œê´€ë¦¬</a>
					<a href="#">ë§¤ì¥ì°¾ê¸°</a>
					<a href="#">ì´ë²¤íŠ¸</a>
					<a href="#">ê³µì§€ì‚¬í•­</a>

>>>>>>> refs/remotes/origin/master
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>