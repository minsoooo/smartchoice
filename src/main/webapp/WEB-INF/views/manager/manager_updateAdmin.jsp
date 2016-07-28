<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<title>updateAdmin</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			var mng_pnum = $("#mng_pnum").attr("value");
			var mng_level = $("#mng_level").attr("value");
			var mng_position = $("#mng_position").attr("value");
			
			var phone1 = mng_pnum.split("-")[0];
			var phone2 = mng_pnum.split("-")[1];
			var phone3 = mng_pnum.split("-")[2];
			
			if(phone1 =="010"){
				$("#010").attr("selected","selected");
			}else if(phone1 =="011"){
				$("#011").attr("selected","selected");
			}else if(phone1 =="017"){
				$("#017").attr("selected","selected");
			}else if(phone1 =="018"){
				$("#018").attr("selected","selected");
			}else if(phone1 =="019"){
				$("#019").attr("selected","selected");
			}
			
			$("#phone2").attr("value",phone2);
			$("#phone3").attr("value",phone3);
			
			if(mng_level =="1"){
				$("#1").attr("selected","selected")
			}else if(mng_level =="2"){
				$("#2").attr("selected","selected")
			}else{
				$("#3").attr("selected","selected")
			}
			
			$("#position").attr("value",mng_position);
			
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
		}			
	);
</script>
<style>

#inputTable{
	margin-left:250px;
}
#id,#name{
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

	
</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<span id ="mng_pnum" value ="${manager.mng_pnum }"></span>
<span id ="mng_level" value ="${manager.mng_level }"></span>
<span id ="mng_position" value ="${manager.mng_position }"></span>
<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">직원정보수정</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="formDiv">
				<form method="post" action ="/manager/manager_updateAdmin" id ="form">
					<input type ="hidden" name ="mng_num" value ="${manager.mng_num }"/>
					<table id ="inputTable">
						<tr>
							<td>
								<input type ="text" name ="mng_id" id ="id" readonly="readonly" value ="${manager.mng_id }"/>						
							</td>
						</tr>
						<tr>
							<td>
								<input type ="text" name ="mng_name" id ="name" readonly="readonly" value ="${manager.mng_name }"/>							
							</td>
						</tr>
						<tr>
							<td>
								<select name="phone1" id ="phone1">
									<option id ="010" value ="010">010</option>
									<option	id ="011" value ="011">011</option>	
									<option id ="017" value ="017">017</option>
									<option id ="018" value ="018">018</option>
									<option id ="019" value ="019">019</option>		
								</select> - <input type="text" name="phone2" id ="phone2"/> - <input type="text" name="phone3" id ="phone3"/>							
							</td>
						</tr>										
						<tr>
							<td>
								<select name ="mng_level" id ="level">
									<option>직원레벨</option>
									<option id="1" value ="1">1</option>
									<option id="2" value ="2">2</option>
									<option id="3" value ="3">3</option>
								</select><input type ="text" name ="mng_position" id ="position" readonly="readonly" placeholder="직책" value=""/>								
							</td>
						</tr>
					</table>
					<input type ="submit" class="btn" value ="수정하기 " id ="btnSub" "/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>