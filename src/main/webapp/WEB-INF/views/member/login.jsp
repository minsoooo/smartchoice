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

 			}
 		}		
 	);
 	
 	function fnRegiOpen(){
 		window.close();
 		opener.document.location.href ="/member/member"
 	}
 	
 	function fnSearchId(){
 		window.close();
 		window.open("/member/searchId","","width=350,height=200,top=+400,left=+600")
 	}
 	
 	function fnSearchPw(){
 		window.close();
 		window.open("/member/searchPw","","width=350,height=200,top=+400,left=+600")
 		
 	}
</script>
<style>
 #mem_id, #mem_pw{
 	width: 279px;
 	margin-bottom:1px;
 }
 
 #mainDiv{
 	margin-left: 35px
 }
 
.btn {
	display: inline-block;
	padding: 6px 12px;
	margin-bottom: 0;
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
	background-color:#8ba752;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
}
</style>
</head>
<body>
	<span id="check" value="${check}"></span>
	<spring:hasBindErrors name="memberDto"></spring:hasBindErrors>
	<form:errors name ="memberDto"></form:errors>
	<spring:hasBindErrors name="login"></spring:hasBindErrors>
	<form:errors name ="login"></form:errors>
	<div id="mainDiv">
		<form class="form-search" method="post" action="/member/login">
			<table style="margin-top:20px">
				<tr>
					<td>
					<input type="text" name="mem_id" placeholder="아이디" id="mem_id" required="required" class="input"/><br/>
					</td>
				</tr>
				<tr>	
					<td>
					<input type="password" name="mem_pw" placeholder="패스워드" id ="mem_pw"  required="required" class="input"/>
					</td>
				</tr>
				<tr>
					<td><br/>
					<input type="submit" value="로그인" class="btn" style="width:280px;"/><br/><br/>
					</td>
				</tr>
				<tr>
					<td id ="errorTd"><form:errors path="memberDto"/></td>
				</tr>
				<tr><td align="center">	
					<a href="javascript:fnRegiOpen()">회원가입 /</a>
					<a href="javascript:fnSearchId()">아이디 찾기 /</a>
					<a href="javascript:fnSearchPw()">비밀번호 찾기</a>
				</td></tr>	
			</table>		
		</form>
	</div>
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
