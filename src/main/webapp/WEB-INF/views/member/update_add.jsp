<!-- 
	작성자 : 박민수
	작성일 : 2016-07-22
	설명 : 회원 정보 가져와서 뿌려주기 / 수정까지 
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
				// member 관심사 가져와서 체크해주기 
				var idFav1 ="#"+$("#mem_fav1").attr("value");
				var idFav2 ="#"+$("#mem_fav2").attr("value");
				var idFav3 ="#"+$("#mem_fav3").attr("value");
				$(idFav1).attr("checked","checked")
				$(idFav2).attr("checked","checked")
				$(idFav3).attr("checked","checked")
				$(":checkbox:not(:checked)").attr("disabled", "disabled");
				
				//company랑 card 선택해주기
				var flag =0;
				var idCompany = "#card"+$("#comp_num").attr("value");
				var idCard = "#"+$("#mem_cardcode").attr("value");
				$(idCompany).attr("selected","selected");
				$(idCard).attr("selected","selected");
				
			var cnt = 3; //3 개이상 선택되면 비활성화 
			$("input[name=big_cate]:checkbox").change(
				function(){
					if( cnt==$("input[name=big_cate]:checkbox:checked").length ) {
			            $(":checkbox:not(:checked)").attr("disabled", "disabled");
			        } else {
			            $("input[name=big_cate]:checkbox").removeAttr("disabled");
			        }
				}		
			);
			$("#companyList").change(
				function(){
					$("#cardList").empty();
					var comp_num = $("option:selected").attr("value")
					$.get("/member/cardList",{"card_compnum":comp_num}).done(
						function(xmlData){
							var card = $(xmlData).find("card");
							if(card.length){
								$(card).each(
										function(){
											var card_name = $(this).find("card_name").text();
											var card_code = $(this).find("card_code").text();
											var insertCode ="<option id ='"+card_code+"' value ='"+card_code+"'>"+card_name+"</option>";
											$(insertCode).appendTo("#cardList")
										}
										
								)
							}
						}		
					);
				}
		
			);
			
		}
	);
	function fnDelMember(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			var mem_num =$("#mem_num").attr("value");
			location.href ="/member/delete?mem_num="+mem_num;
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
#titleHr{
	border: 1px solid #d4d1ca;
}
#titleFont{
	color :#97b162;
	font-size: 20px;
	font-weight:bold;
}

#cardDiv{
	margin-bottom: 20px
}
li {
	color: #97b162;
}

#label{
	font-family:'Noto Sans KR', sans-serif;
	font-size: 13px;
	margin-left:15px;
	color : #5c554b;
}
#categoryTable{
	margin-left:30px;
	background-color:#fff;
	border : 1px solid #d9d5cc;
}

#categoryTable td{
	border-bottom: 1px solid #d9d5cc;
	width :200px;
	height : 80px;
	font-size: 40px;
	padding-left: 10px;
	padding-right: 10px;
	
}

#id_font, #email_font{
	color:#5c554b ;
	font-size:15px;
	font-weight: bold;
	margin-left:40px;
	margin-right:20px;
}
#companyList, #cardList{
	margin-left:30px
}

#subBtn {
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
#subBtn:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}	

#delBtn {
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
#delBtn:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}	
</style>
<body style="background-color:#f5f4f0">
	<span id ="mem_fav1" value ="${sessionScope.MEM_KEY.mem_fav1}"></span>
	<span id ="mem_fav2" value ="${sessionScope.MEM_KEY.mem_fav2}"></span>
	<span id ="mem_fav3" value ="${sessionScope.MEM_KEY.mem_fav3}"></span>
	<span id ="mem_cardcode" value="${sessionScope.MEM_KEY.mem_cardcode }"></span>
	<span id ="comp_num" value ="${sessionScope.MEM_KEY.comp_num }"></span>
	<span id = "mem_num" value ="${sessionScope.MEM_KEY.mem_num }"></span>
	<span id ="check" value ="${check }"></span>
	<span id ="check_pass" value ="false"></span>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">회원기본정보</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>

	<div class ="container">
		<div class ="row">
			<div class = "span12" id ="basicDiv">
				<font>ID : </font><font id ="id_font">${sessionScope.MEM_KEY.mem_id }</font><font>Email : </font><font id ="email_font">${sessionScope.MEM_KEY.mem_email }</font>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">관심분야수정</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
<form id ="form" method ="post" action="/member/update_add">	
	<div class ="container">
		<div class ="row">
			<div class = "span12" id ="formDiv">
				<input type ="hidden" name ="mem_num" value ="${sessionScope.MEM_KEY.mem_num }"/>
				<input type ="hidden" name ="mem_id" value ="${sessionScope.MEM_KEY.mem_id }"/>
				<input type ="hidden" name ="mem_pw" value ="${sessionScope.MEM_KEY.mem_pw }"/>				
				<table id ="categoryTable">
					<tr>
						<c:forEach items="${cateList }" var="cate" step="1" varStatus="i">
							<td>
								<input type ="checkbox" name="big_cate" value="${cate.big_num }" id="${cate.big_num }" style="float:left"/>
								<label  id ="label"for ="${cate.big_num }" style="float:left">${cate.big_name}</label>
							</td>
							<c:if test="${(i.index+1)%4 == 0 }">
								<tr></tr>
							</c:if>
						</c:forEach>
					</tr>
				</table>
			</div>
		</div>
	</div>				
	<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">내등록 카드 수정</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="span12" id ="cardDiv">
				<select id="companyList" name="comp_num">
					<c:forEach items ="${compList }" var ="company">
						<option id ="card${company.comp_num }" value ="${company.comp_num }">${company.comp_name }</option>
					</c:forEach>
				</select>
				<select id="cardList" name ="mem_cardcode">
					<c:forEach items ="${cardList }" var ="card">
						<option id ="${card.card_code }" value ="${card.card_code }">${card.card_name }</option>
					</c:forEach>
				</select>	
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="buttonDiv">
				<input type ="submit" value ="수정하기" id ="subBtn"/><input type ="button" value ="회원탈퇴" id ="delBtn" onclick="javascript:fnDelMember()"/>
			</div>
		</div>
	</div>
</form>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>