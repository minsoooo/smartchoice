<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>RegiMember</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			$("#btnIdCheck").click(
					function() {		
						  if($("#id").val() == ""){ 
							  alert("아이디를 입력하세요");
							  $("#check_result").attr("src", "/resources/images/check_red.png");
							  $("#check").attr("value", "false");
						  }else{
							  $.get("/member/check", {"mem_id":$("#id").val()},
									function(data){
										if(data =="true"){
											alert("사용가능한 아이디 입니다.")
											 $("#check_result").attr("src", "/resources/images/check_green.png");
											 $("#check").attr("value", "true");
										}else{
											alert("사용불가능한 아이디 입니다.")
											$("#check_result").attr("src", "/resources/images/check_red.png");
											$("#check").attr("value", "false");
										}
								 	}						  
								);
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
										alert(data)
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
			
			$("#btnNext").click(
				function(){
					var check = $("#check").attr("value")
					if(check == "true"){
						var $form = $("#form");
						$form.submit();
					}else{
						alert("입력정보를 확인해 주세요")
					}
				}		
			);
			
			
			
			$("#pass1").keyup(
					function(){				
						if($("#pass1").val().length >= 6 && $("#pass1").val().length <= 12){
							$("#check_pass1").attr("src", "/resources/images/check_green.png");	
							$("#check").attr("value", "true");
						}				
						else{
							$("#check_pass1").attr("src", "/resources/images/check_red.png");	
							$("#check").attr("value", "false");
						}
					}		
				);
				
				$("#pass2").blur(
					function(){
						if($("#pass1").val().length >= 6 && $("#pass1").val().length <= 12 && ($("#pass1").val() == $("#pass2").val())){
							$("#check_pass2").attr("src", "/resources/images/check_green.png");
							$("#check").attr("value", "true");
						}
						else if($("#pass1").val().length > 0 && ($("#pass1").val() != $("#pass2").val())){
							$("#check_pass2").attr("src", "/resources/images/check_red.png");	
							$("#check").attr("value", "false");
						}
					}			
				);
			
			
			
			$("#btnIdCheck").hover(
					function(){
						$("#btnIdCheck").attr("src", "/resources/images/btn_id_check2.jpg");				
					},
					function(){
						$("#btnIdCheck").attr("src", "/resources/images/btn_id_check.jpg");				
					}
				);
				
				$("#btnSendCode").hover(
					function(){
						$("#btnSendCode").attr("src", "/resources/images/btn_send_code2.jpg");				
					},
					function(){
						$("#btnSendCode").attr("src", "/resources/images/btn_send_code.jpg");				
					}
				);
				
				$("#btnCheckCode").hover(
					function(){
						$("#btnCheckCode").attr("src", "/resources/images/btn_check_code2.jpg");				
					},
					function(){
						$("#btnCheckCode").attr("src", "/resources/images/btn_check_code.jpg");				
					}
				);
		}	
	);
	

</script>
</head>
<style>
body{
	background-color:#f5f4f0;
}

#imgTd{
	width : 20px
}
#content{
	margin-top:50px;
	margin-bottom:50px;
}

#step1, #step2, #step3{
	width : 250px;
	margin-left:10px;
}

#stepDiv{
	margin-left:60px
}

#formDiv{
	margin-top :20px;
	margin-left:300px;
}
input{
	height:30px;

}
#id, #pass1, #pass2{
	width : 300px;
	margin-bottom:5px;
	
}
#email1,#email2{
	width : 132px;
	margin-bottom:5px;
}

#inputCode{
	margin-top:11px;
	width : 168px;
}

#btnNext{
	width : 180px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left: 100px;
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
	outline: 0
</style>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<span id ="check" value = "false"></span>
	<span id ="checkCode" value =""></span>
	<div class="container" id="content">
		<div class="row">
			<div class="span12">
				<div class = "span12" id = "stepDiv">
					<img src="/resources/images/step1_2.jpg" id="step1"/>
					<img src="/resources/images/step2_1.jpg" id="step2"/>
					<img src="/resources/images/step3_1.jpg" id="step3"/>
				</div>
				<div id ="formDiv" class="span12">
					<form method="post" action="/member/member" id ="form">
						<table>
							<tr>		
								<td>
									<input type="text" id="id" name="mem_id" placeholder="아이디  (6~12자로 입력해주세요)" required="required" />			
									<img src="/resources/images/btn_id_check.jpg" id="btnIdCheck"/><br/>		
								</td>
								<td><img src="" id="check_result"/></td>
							</tr>
							<tr>		
								<td>
									<input type="password" id="pass1"placeholder="비밀번호 (6~12자로 입력해주세요) " required="required" /><br/>
												
								</td>
								<td><img src="" id="check_pass1"/></td>
							</tr>
							<tr>
								<td>
									<input type="password" id="pass2" name="mem_pw" placeholder="비밀번호 확인" required="required" />
								</td>
								<td><img src="" id="check_pass2"/></td>
							</tr>
							<tr>
								<td>
									<input type="text" id="email1" name ="email1" placeholder="이메일" required="required" /> @ 
									<input type="text" id="email2" name ="email2" class="input-medium" required="required" />		
								</td>
								<td></td>
							</tr>
							<tr>
								<td>
									<img src="/resources/images/btn_send_code.jpg" id="btnSendCode"/>
									<input type="text" id="inputCode" class="input-medium" required="required" /> 
									<img src="/resources/images/btn_check_code.jpg" id="btnCheckCode"/>
								</td>
								<td><img src="" id="check_email"/></td>
							</tr>
							<tr>
								<td>
									<input type ="button" value ="다음단계로" class="btn" id="btnNext"/>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>