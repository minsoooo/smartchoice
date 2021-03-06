<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<script>
	function fnMngLogin(){
		window.open("/manager/manager_login","","width=350,height=200,top=+300,left=+500");
	}
	
	function fnOpenMain(){
		location.href ="/manager/manager_main";
	}
</script>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
#footer{
	background-color:#d4d1ca;
	font-family: 'Noto Sans KR', sans-serif;
}
#copyright{
	color:#706b67;
	margin-right:20px;
	font-size:13px;
}

#foot1{
	margin-top:30px;
	margin-left:220px;
}

#foot1 a{
	color:#706b67;
	font-size:11px;
	margin-right:50px;
}

#foot1 a:hover{
	color:#97b162;
	text-decoration:none;
}

#foot2{
	text-align:right;
}

</style>
<body>
	<div id="footer">
		<div class="container">
			<div class="row">
				<div class="span4" style="position:absolute;">
					<a href ="/"><img src="/resources/images/logo_3.png" style="width:160px;"/></a>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="span1"></div>
				<div class="span10">
					<div id="foot1">
						<a href="#">회사소개</a>
						<a href="#">이용약관</a>
						<a href="#">사이트맵</a>
						<c:choose>
							<c:when test="${sessionScope.MNG_KEY eq null }">
								<a href="javascript:fnMngLogin()" style="font-weight:bold;">관리자 로그인</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:fnOpenMain()" style="font-weight:bold;">관리자 페이지</a>									
							</c:otherwise>						
						</c:choose>
					</div>
					<hr style="border:1px solid #c2bdb7;">
					
					<div id="foot2">
						<font id="copyright">Copyright 2016 $mart Choice. All rights reserved.</font><br/><br/>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>