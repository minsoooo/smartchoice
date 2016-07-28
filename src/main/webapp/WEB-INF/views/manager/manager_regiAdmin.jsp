<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<title>chooseAdmin</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){

			$("#level").change(
				function(){

					var level =$("#level option:selected").attr("value");
					if(level == "1"){
						$("#position").attr("value","관리자")
					}else if(level =="2"){
						$("#position").attr("value","총관리자")						
					}else if(level =="3"){
						$("#position").attr("value","개발자")
					}else{
						$("#position").attr("value","")
					}
				}	
			);
			
			$("#checkId").click(
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
		}			
	);
	
	function fnRegiAdmin(){
		var check =	$("#check").attr("value");
		if(check =="true"){
			var $form = $("#form")
			$form.submit();
		}else{
			alert("입력값을 확인해 주세요")
		}
	}
</script>
<style>

#inputTable{
	margin-left:250px;
}
#id{
 width:180px;
}
#pass1,#pass2,#name{
	width: 280px;
}	
#position, #level{
	width: 138px;
	margin-right: 5px;
}
#phone1, #phone2, #phone3{
	width:80px;
}
li{
	font-size: 20px;
	color :#97b162;
}
#titleFont{
	color :#97b162;
	font-size: 30px;
	font-weight:bold;
}
#titleHr{
	border: 1px solid #d4d1ca;
}

 #titleDiv{
	margin-left:100px;
 	margin-top:50px;
 }
 #formDiv{
 	margin-left:100px;
 	margin-top:40px;
 }
 
 #checkId {
	width : 95px;
	display: inline-block;
	padding: 6px 12px;
	margin-left:;
	margin-bottom: 10px;
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

#btnSub {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left: 300px;
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
#checkId:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}
	
</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<span id="check" value =""></span>
<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">직원등록</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="formDiv">
				<form method="post" action ="/manager/manager_regiAdmin" id ="form">
					<table id ="inputTable">
						<tr>
							<td>
								<input type ="text" name ="mng_id" id ="id" placeholder="아이디입력"/>
								<input type ="button" id ="checkId" value ="중복확인"/>							
							</td>
							<td><img id ="check_result"/></td>
						</tr>
						<tr>
							<td>
								<input type ="password"  id ="pass1" placeholder="비밀번호입력"/>							
							</td>
							<td><img id ="check_pass1"/></td>
						</tr>
						<tr>
							<td>
								<input type ="password" name ="mng_pw" id ="pass2" placeholder="비밀번호확인"/>							
							</td>
							<td><img id ="check_pass2"/></td>
						</tr>
						<tr>
							<td>
								<input type ="text" name ="mng_name" id ="name" placeholder="이름입력"/>							
							</td>
						</tr>
						<tr>
							<td>
								<select name="phone1" id ="phone1">
									<option value ="010">010</option>
									<option value ="011">011</option>	
									<option value ="017">017</option>
									<option value ="018">018</option>
									<option value ="019">019</option>		
								</select> - <input type="text" name="phone2" id ="phone2"/> - <input type="text" name="phone3" id ="phone3"/>							
							</td>
						</tr>
														
						<tr>
							<td>
								<select name ="mng_level" id ="level">
									<option>직원레벨</option>
									<option value ="1">1</option>
									<option value ="2">2</option>
									<option value ="3">3</option>
								</select><input type ="text" name ="mng_position" id ="position" readonly="readonly" placeholder="직책" value=""/>								
							</td>
						</tr>
					</table>
					<input type ="button" value ="등록하기 " id ="btnSub" onclick="javascript:fnRegiAdmin()"/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>