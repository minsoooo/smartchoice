<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" %>
<%@ taglib  prefix="c"  uri ="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>chooseAdmin</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			var success = $("#success").attr("value")
			if(success == "success"){
				alert("등록이 완료 되었습니다.")
			}
		}		
	);

	function fnUpdate(id){
		 var mng_id = $(id).attr("name");
		location.href ="/manager/manager_updateAdmin?mng_id="+mng_id;
	}
	
	function fnDel(id){
		var mng_id = $(id).attr("name");
		if(confirm("정말 삭제하시겠습니까?")){
			location.href ="/manager/manager_delAdmin?mng_id="+mng_id;
		}
	}
	
	function goPage(page_num){
		location.href="/manager/manager_listAdmin?page_num="+page_num;
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
 	margin-left:120px;
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

#pagingDiv{
	margin-top: 40px;
	margin-left:400px;
}
</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<span id="success" value ="${success }"/>
<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">직원 리스트</font>
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
						<th>이름</th><th>아이디</th><th>전화번호</th><th>레벨</th><th>직책</th>
						<th></th><th></th>
					</tr>
					<c:forEach items="${managerList}" var ="list">
						<tr >
							<td>${list.mng_name }</td><td>${list.mng_id }</td><td>${list.mng_pnum }</td><td>${list.mng_level }</td><td>${list.mng_position }</td>
							<td><input type ="button" class ="btn" value ="수정" id="btn" name ="${list.mng_id }" onclick="javascript:fnUpdate(this)"/></td><td><input type ="button" class ="btn" value ="삭제" id= "btn" name="${list.mng_id}"onclick="javascript:fnDel(this)"/></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="pagingDiv">	
				<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="true">
				    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
				    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
				    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
				    <jsp:param name="pageNo" value="${paging.pageNo}" />
				    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
				    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
				    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
				</jsp:include>
			</div>			
		</div>
	</div>
	
</body>
</html>