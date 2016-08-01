<!-- 
	작성자 : 박민수
	작성일 : 2016-07-24
	설명   : 회원 기본정보 수정
 -->

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>update.jsp</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
				// check 값이 넘어오면 성공창 띄워주기
			var check =$("#check").attr("value")
			if(check == "success"){
				alert("수정을 완료했습니다.")
			}
			var email1 = $("#mem_email").attr("value").split("@")[0];
			var email2 = $("#mem_email").attr("value").split("@")[1];
			$("#email1").attr("value",email1);
			$("#email2").attr("value",email2);
			
			var oldPw = $("#mem_pw").attr("value");
			
			$("#oldPw").keyup(
				function(){
					var inputPass = $("#oldPw").val();
					if(oldPw == inputPass){
						$("#check_oldPw").attr("src", "/resources/images/check_green.png");	
						$("#check_pass").attr("value", "true");
					}else{
						$("#check_oldPw").attr("src", "/resources/images/check_red.png");	
						$("#check_pass").attr("value", "false");
					}
				}		
			);
			
			$("#pass1").keyup(
					function(){				
						if($("#pass1").val().length >= 6 && $("#pass1").val().length <= 12){
							$("#check_pass1").attr("src", "/resources/images/check_green.png");	
							$("#check_pass").attr("value", "true");
						}				
						else{
							$("#check_pass1").attr("src", "/resources/images/check_red.png");	
							$("#check_pass").attr("value", "false");
						}
					}		
				);
				
				$("#pass2").blur(
					function(){
						if($("#pass1").val().length >= 6 && $("#pass1").val().length <= 12 && ($("#pass1").val() == $("#pass2").val())){
							$("#check_pass2").attr("src", "/resources/images/check_green.png");
							$("#check_pass").attr("value", "true");
						}
						else if($("#pass1").val().length > 0 && ($("#pass1").val() != $("#pass2").val())){
							$("#check_pass2").attr("src", "/resources/images/check_red.png");	
							$("#check_pass").attr("value", "false");
						}
					}			
				);
				
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
								$("#email_check").attr("src", "/resources/images/check_green.png");
								$("#check").attr("value", "true");
							}else{
								alert("인증코드를 확인해 주세요")
								$("#email_check").attr("src", "/resources/images/check_red.png");
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
	
	function fnDelMember(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			var mem_id =$("#mem_id").attr("value");
			location.href ="/member/delete?mem_id="+mem_id;
		}
		
	}
</script>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#titleDiv{
	margin-top:40px;
}
#buttonDiv{
	margin-bottom: 50px
}
#tableDiv{
	margin-left :330px;
	margin-top:40px;
	margin-bottom:40px;
}
#titleHr{
	border: 1px solid #d4d1ca;
}
#titleFont{
	color :#97b162;
	font-size: 20px;
	font-weight:bold;
}
#id, #oldPw, #pass1, #pass2{
	width : 268px;
}
#email1, #email2{
	margin-top:10px;
	width:120px;
}

#btnSub {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left: 240px;
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
#btnSub:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}	

#btnDel {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left: 20px;
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
#btnDel:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}

#inputCode{
	width:98px;
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
</style>
<body style="background-color:#f5f4f0">
	<span id ="mem_pw" value ="${sessionScope.mem_pw }"></span>
	<span id = "mem_id" value ="${sessionScope.MEM_KEY.mem_id }"></span>
	<span id ="mem_email" value ="${sessionScope.MEM_KEY.mem_email }"></span>
	<span id ="check" value ="${check }"></span>
	<span id ="check_pass" value ="false"></span>
	<span id ="checkCode" value =""></span>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">기본정보수정</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>

<form id ="form" method ="post" action="/member/update_basic">
	<input type ="hidden" name ="mem_num" value ="${sessionScope.MEM_KEY.mem_num }"/>
	<input type ="hidden" name ="mem_id" value ="${sessionScope.MEM_KEY.mem_id }"/>	
	<div class = "container">
		<div class ="row">
			<div class ="span12" id ="tableDiv">
				<table>
					<tr>
						<td><input type ="text" value ="${sessionScope.MEM_KEY.mem_id }" id ="id" readonly="readonly"/></td>
					</tr>
					<tr>
						<td><input type ="password" id ="oldPw" placeholder="기존비밀번호" /></td>
						<td><img src ="" id="check_oldPw"/></td>
					</tr>
					<tr>
						<td><input type ="password" id ="pass1" placeholder="새로운비밀번호" /></td>
						<td><img src ="" id="check_pass1"/></td>
					</tr>
					<tr>
						<td><input type ="password" id ="pass2"  name ="mem_pw" placeholder="비밀번호확인" /></td>
						<td><img src ="" id="check_pass2"/></td>
					</tr>
					<tr>
						<td><input type ="text" id ="email1" name ="email1"/>@<input type ="text" id ="email2" name ="email2"/></td>
					</tr>
					<tr>
						<td>
							<input type ="button"  id="btnSendCode" value ="코드발송"/>
							<input type="text" id="inputCode" class="input-medium" required="required"/> 
							<input type ="button"  id="btnCheckCode" value ="코드인증"/>
						</td>
						<td><img src="" id="email_check"/></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="buttonDiv">
				<input type ="submit" value ="수정하기" id ="btnSub"/><input type ="button" value ="회원탈퇴" id ="btnDel" onclick="javascript:fnDelMember()"/>
			</div>
		</div>
	</div>
</form>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>