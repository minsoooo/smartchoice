<%@ page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>LogIn.html</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script>	
</script>
<style>
 #mem_id, #mem_pw{
 	width: 279px;
 	margin-bottom:1px;
 }
 
 #mainDiv{
 	margin-left: 10px
 }
</style>
</head>
<body>
	<spring:hasBindErrors name="memberDto"></spring:hasBindErrors>
	<form:errors name ="memberDto"></form:errors>
	
	<spring:hasBindErrors name="login"></spring:hasBindErrors>
	<form:errors name ="login"></form:errors>
	<div id="mainDiv">
		<form class="form-search" method="post" action="/member/login">
			<table style="margin-top:20px">
				<tr>
					<td>
					<input type="text" name="mem_id" placeholder="아이디" id="mem_id" required="required"/><br/>
					</td>
				</tr>
				<tr>
					<td id ="errorTd"><form:errors path="memberDto.mem_id"/></td>
				</tr>
				<tr>	
					<td>
					<input type="password" name="mem_pw" placeholder="패스워드" id ="mem_pw"  required="required"/>
					</td>
				</tr>
				<tr>
					<td id ="errorTd"><form:errors path="memberDto.mem_pw"/></td>
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
					<a href="javascript:fnLogIn_id()">아이디 찾기 /</a>
					<a href="javascript:fnLogIn_password()">비밀번호 찾기</a>
				</td></tr>	
			</table>		
		</form>
	</div>
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
