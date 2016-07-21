<%@ page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>RegiMemberStep2</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			
			$("span").click(
				function(){
					var tr =0;
					$("#cardTr").empty();
					var comp_num = $(this).attr("value");
					$.get("/member/cardList",{"card_compnum":comp_num}).done(
						function(xmlData){
							var card = $(xmlData).find("card");
							if(card.length){
								$(card).each(
										function(){
											tr +=1;
											var setTr ="<tr></tr>";
											if(tr%3 == 0){
												$(setTr).appendTo("#cardTr")
											}
											var card_name = $(this).find("card_name").text();
											var card_code = $(this).find("card_code").text();
											var card_img = "/resources/images/"+ $(this).find("card_img").text();
											var insertCode ="<td><img src ='"+card_img+"' id ='cardImg'/><br/><label for ='"+card_code+"'><input type ='radio' name='mem_cardcode'"
											+"value ='"+card_code+"' id ='"+card_code+"'/>"+card_name+"</label></td>"
											$(insertCode).appendTo("#cardTr")
										}
								)
									
								
							}
							$("#cardTable td").css("width","250px").css("height","140px").css("border","1px solid #d9d5cc")
							.css("text-align","center").css("font-size","15px").css("padding-bottom","5px")
							$("#cardTable img").css("width","250px").css("height","120px").css("margin-bottom","10px");
						}		
					);
				}		
			);
			
		}	
	);

</script>
</head>
<style>
#cardDiv{
	margin-top:30px;
}
#cardTable{
	border:2px solid #5c554b;
	margin-left : 94px;
	background-color:#fff;
	
}
#cardTable label{
	font-weight: bold
	
}

#cardTable input[type="radio"]{
	margin-right: 10px;
	margin-bottom: 5px;
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

#btnDiv{
	margin-top:10px
}
#subBtn{

}
#tableDiv{
	margin-left:75px;
	margin-top:20px;
	border : 2px solid #d9d5cc;
	width: 800px;
}
#stepDiv{
	margin-left:80px
}

#compTable{
	background-color:#fff;
}

#compTable td{
	border: 1px solid #d9d5cc;
	width :200px;
	height : 80px;
	font-size: 20px;
	padding-top: 10px;
	padding-left: 30px;
	padding-right: 10px;
	cursor: pointer;
	
}

#subBtn {
	width : 200px;
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

#subBtn:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="container" id="content">
		<div class="row">
			<div class="span12">
			<div class ="container">
				<div class ="row">
					<div class = "span12" id = "stepDiv">
						<img src="/resources/images/step1_1.jpg" id="step1"/>
						<img src="/resources/images/step2_1.jpg" id="step2"/>
						<img src="/resources/images/step3_2.jpg" id="step3"/>
					</div>
				</div>
			</div>
				
				<form method ="post" action ="/member/memberStep3">
					<input type ="hidden" name ="mem_id" value ="${MemberDto.mem_id }"/>
					<input type ="hidden" name ="mem_pw" value ="${MemberDto.mem_pw }"/>
					<input type ="hidden" name ="mem_email" value ="${MemberDto.mem_email }"/>
					<input type ="hidden" name ="mem_level" value ="${MemberDto.mem_level }"/>
					<input type ="hidden" name ="mem_fav1" value ="${MemberDto.mem_fav1 }"/>
					<input type ="hidden" name ="mem_fav2" value ="${MemberDto.mem_fav2 }"/>
					<input type ="hidden" name ="mem_fav3" value ="${MemberDto.mem_fav3 }"/>
					<div class = "container">
						<div class ="row">
							<div class ="span10" id="tableDiv">
								<table id = "compTable">
									<tr>
										<c:forEach items="${compList }" var="comp" step="1" varStatus="i">
											<td>	
												<ul><li><span id ="comp_num" value ="${comp.comp_num }">${comp.comp_name }</span></li></ul>
											</td>
											<c:if test="${(i.index+1)%4 == 0 }">
												<tr></tr>
											</c:if>
										</c:forEach>
									<tr/>
								</table>		
							</div>
						</div>
					</div>	
					<div class ="container">
						<div class = "row">
							<div id = "cardDiv">
								<table id ="cardTable">
									<tr id="cardTr">
									
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class = "span1 offset8" id ="btnDiv">
						<input type ="submit" value ="가입완료" class="btn" id ="subBtn"/>
					</div>
				</form>	
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>