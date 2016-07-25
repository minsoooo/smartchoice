<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			$("#btnSendCode").click(
					function() {		
						  if($("#email1").val() == "" || $("#email2").val() ==""){ 
							  alert("이메일을 입력하세요");
							  $("#check").attr("value", "false");
						  }else{
							  $.get("/member/code", {"email1":$("#email1").val(),"email2":$("#email2").val()},
									function(data){
										$("#checkCode").attr("value",data);
								 	}						  
								);
						  }	  				  
					  }				
				);
			
			$("#btnCheckCode").click(
					function(){
						var sendCode = $("#checkCode").attr("value")
						var inputCode = $("#inputCode").val();
						
						if(sendCode == inputCode){
							$("#check_email").attr("src", "/resources/images/check_green.png");
							$("#check").attr("value", "true");
						}else{
							alert("인증코드를 확인해 주세요")
							$("#check_email").attr("src", "/resources/images/check_red.png");
							$("#check").attr("value", "false");
						}
					}		
				);
			
			$("#btnSub").click(
					function(){
						var check = $("#check").attr("value");
						if(check == "true"){
							var $form = $("#form")
							$form.submit();
						}else{
							alert("입력 정보를 확인해 주세요!")
						}
					}
				
			);
		}		
	);
</script>
<style>
#content{margin-left:30px}
#mainDiv {margin-top:20px}
#fontDiv{margin-top:50px;font-weight: bold; margin-left:30px;}

#mem_pw{
	font-size: 30px;
	color:#669aba;
}
#warn{
	color :red;
}
#mainDiv font{
	font-size: 20px;
	color:#669aba;
	font-weight: bold;
}

#mem_id{
	width :237px;
}
#email1, #email2{
	margin-top:10px;
	width:105px;
}

#inputCode{
	width:70px;
	margin-top:14px;
}

#btnCheckCode{
	width : 80px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;	
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

	
#btnCheckCode:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}
#btnSendCode{
	width : 80px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
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
	background-color:#d9d8d6;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
	}
	
#btnSendCode:hover{
	background-color:#e5e5e3;
	border: 0;
	outline: 0;
}
#btnSub{
	width : 254px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
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
	background-color:#548eb3;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
	}
	
#btnSub:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}

</style>
</head>
<body>
<span id = "result" value ="${result }"></span>
<span id ="check" value ="false"></span>
<span id ="checkCode" value =""></span>
<div id ="content">
	<div id ="mainDiv">
				<ul><li><font id ="titleFont">비밀번호 찾기</font></li></ul>
	</div>
	
	<c:choose>
		<c:when test="${result eq 'success' }">
			<div id ="fontDiv">
				<font>당신의 새로운 비밀번호는 </font><br/><br/><font id ="mem_pw">${mem_pw }</font><font>입니다.</font>
				<br/><br/>
				<font id ="warn">비밀번호는 수정후 사용해 주세요.</font>
			</div>
		</c:when>
		<c:otherwise>
			<div id ="formDiv">
				<form method ="post" action="/member/searchPw" id ="form">
					<table id ="inputTable">
						<tr>
							<td><input type ="text" name ="mem_id" id ="mem_id" placeholder="아이디를 입력하세요"/></td><td></td>
						</tr>
						<tr>
							<td><input type ="text" name ="email1" id ="email1" placeholder="Email입력"/>@<input type="text" name ="email2" id="email2"/></td><td></td>
						</tr>
						<tr>
							<td>
								<input type ="button"  id="btnSendCode" value ="코드발송"/>
								<input type="text" id="inputCode" class="input-medium" required="required"/> 
								<input type ="button"  id="btnCheckCode" value ="코드인증"/>
							</td>
							<td><img src="" id="check_email"/></td>
						</tr>
					</table>
						<input type = "button" class ="btn" id ="btnSub" value ="비밀번호찾기"/>
				</form>
			</div>	
		</c:otherwise>
	</c:choose>
</div>


<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>