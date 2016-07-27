<%@ page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>LogIn.html</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
 	$(document).ready(
 		function(){
 			var check = $("#check").attr("value")
 			if(check =="success"){
 				window.close();
 				opener.document.location.href="/"
 			}else if(check =="fail"){
 				alert("아이디 또는 비밀번호가 틀렸습니다.")
 			}
 		}		
 	);
</script>
<style>
 #mem_id, #mem_pw{
 	width: 279px;
 	margin-bottom:1px;
 }
 
 #mainDiv{
 	margin-left: 35px
 }
 
#btnLogin {
	display: inline-block;
	padding: 6px 12px;
	margin-bottom: 0;
	width : 280px;
	font-size: 14px;
	font-weight: bold;
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
	background-color:#548eb3;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
}

#btnLogin:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}
</style>
</head>
<body>
	<span id="check" value="${check}"></span>
	<div id="mainDiv">
		<form class="form-search" method="post" action="/manager/manager_login">
			<table style="margin-top:20px">
				<tr>
					<td>
					<input type="text" name="mng_id" placeholder="아이디" id="mem_id" required="required" class="input"/><br/>
					</td>
				</tr>
				<tr>	
					<td>
					<input type="password" name="mng_pw" placeholder="패스워드" id ="mem_pw"  required="required" class="input"/>
					</td>
				</tr>
				<tr>
					<td><br/>
					<input type="submit" value="관리자 로그인" class="btn" id ="btnLogin"/><br/><br/>
					</td>
				</tr>
			</table>		
		</form>
	</div>
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
