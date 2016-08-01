<%@ page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>SeachId</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			$("#btnSub").click(
				function(){
					var email1 = $("#email1").val();
					var email2 = $("#email2").val();
					if(email1 != "" && email2 != ""){
						var $form = $("#form")
						$form.submit();
					}else{
						alert("Email을 정확히 입력해 주세요")
					}
				}		
			);
			
			var check = $("#result").attr("value");
			if(check== "fail"){
				alert("아이디가 존재 하지 않습니다.")
			}
		}		
	);
</script>
<style>
#mainDiv{
	margin-top: 20px;
	margin-left :28px;
}
li{
	color:#548eb3;
	font-size: 20px;
}
#fontDiv{
	margin-top:40px
}
#fontDiv font{
	font-size: 20px;
}

#mem_id{
	font-size:40px;
	font-weight: bold;
	color:#669aba;
}
#mainDiv font{
	font-size: 20px;
	color:#669aba;
	font-weight: bold;
}
#content{
	margin-left: 35px;
}
#email1, #email2{
	margin-top:10px;
	width:119px;
}
#btnSub {
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
	background-color:#8ba752;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
}

#btnSub:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

</style>
</head>
<body>
<span id = "result" value ="${result }"></span>
<div id ="mainDiv">
			<ul><li><font id ="titleFont">아이디 찾기</font></li></ul>
</div>
<div id = "content">
	<form method ="post" action ="/member/searchId" id ="form">
		<c:choose>
			<c:when test='${result eq "success" }'>
				<div id ="fontDiv">
							<font>당신의 아이디는 </font><font id ="mem_id">${mem_id }</font><font>입니다.</font>
				</div>
			</c:when>
			<c:otherwise>
				<div id ="formDiv">
					<input type ="text" name ="email1" id ="email1" placeholder="Email입력"/>@<input type ="text" name ="email2" id ="email2"/>
					<input type ="button" value ="아이디 찾기" class="btn" id ="btnSub"/>
				</div>
			</c:otherwise>
		</c:choose>	
	</form>
</div>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>