<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" %>
<%@ taglib  prefix="c"  uri ="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>카드리스트</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
$(function(){

});

$(document).ready(
	function(){
		var success = $("#success").attr("value")
		if(success == "success"){
			alert("등록이 완료 되었습니다.")
		}
	}		
);

function fnUpdate(id){
	var card_code = $(id).attr("name");
	location.href ="/manager/manager_cardCor?card_code="+card_code;
}

function fnDel(id){
	var card_code = $(id).attr("name");
	if(confirm("정말 삭제하시겠습니까?")){
		location.href ="/manager/manager_deleteCard?card_code="+card_code;
	}
}

</script>
<style>
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
 
 #mngTable {
 	margin-top :30px;
 	margin-left:80px;
 }

 #mngTable th{
	font-size: 20px;
	font-weight: bold;
	color:#5c554b;
	border-bottom: 1px solid #d4d1ca;
	padding-bottom: 10px;
 }
 #mngTable td{
 	height:50px;
 	width :200px;
 	text-align: center;
 	border-bottom: 1px solid #d4d1ca;
 	color:#5c554b;
 	font-size: 15px;
 }
 #btn:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

#btn {
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

</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<span id="success" value =""/>
<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">카드 리스트</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="tableDiv">
				<table id ="mngTable">
					<tr>
						<th>카드사명</th><th>카드명</th><th>카드종류</th><th>카드코드</th><th>카드상태</th>
						<th></th><th></th>
					</tr>
					<c:forEach items="${cardList }" var ="list">
					<tr>
						<td>${list.comp_name }</td>
						<td>${list.card_name }</td>
						<td>
							<c:choose>
								<c:when test="${list.card_typeflag==0 }">
									신용카드
								</c:when>
								<c:when test="${list.card_typeflag==1 }">
									체크카드
								</c:when>
							</c:choose>
						</td>
						<td>${list.card_code }</td>
						<td>
							<c:choose>
								<c:when test="${list.card_useflag==0 }">
									삭제 된 카드
								</c:when>
								<c:when test="${list.card_useflag==1 }">
									사용 중 카드
								</c:when>
							</c:choose>
						</td>
						<td><input type ="button" class ="btn" value ="수정" id="btn" name ="${list.card_code }" onclick="javascript:fnUpdate(this)"/></td><td><input type ="button" class ="btn" value ="삭제" id= "btn" name="${list.card_code }" onclick="javascript:fnDel(this)"/></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>