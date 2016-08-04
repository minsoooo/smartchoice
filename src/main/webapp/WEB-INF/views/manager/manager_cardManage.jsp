<!-- 
	일   시 : 2016.07.31
	작성자 : 배효열
	내   용 : 카드관리 뷰 페이지
	수   정 : 
	일   정 : 
 -->
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>카드관리</title>
</head>
<script>
	function fnRegiOpen(){
		location.href="/manager/manager_cardRegister";
	}
	
	function fnListOpen(){
		location.href="/manager/manager_cardList";
	}

</script>
<style>
#btnDiv{
	margin-top: 200px;
	margin-left:260px;

}

#regiAdmin {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left:20px;
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

#regiAdmin:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}

#listAdmin {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left:20px;
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

#listAdmin:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}
</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="btnDiv">
				<input type ="button" id ="regiAdmin" value ="신규카드등록" onclick="javascript:fnRegiOpen()"/>
				<input type ="button" id ="listAdmin" value ="카드 리스트" onclick="javascript:fnListOpen()"/>
			</div>
		</div>
	</div>
</body>
</html>