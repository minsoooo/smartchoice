<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" %>
<%@ taglib  prefix="c"  uri ="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>listMember</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			
			$("#cate").change(
					function(){
						
						var value =$("#cate option:selected").attr("value");
						location.href="/manager/manager_viewListMember?page_num=1&keyword=mem_fav&value="+value;
					}
			);
			
			$("#comp").change(
					function(){
						alert("Test")
						var value =$("#comp option:selected").attr("value");
						location.href="/manager/manager_viewListMember?page_num=1&keyword=comp_num&value="+value;
					}
			);
		}		
	);
	function fnDel(id){
		var mem_id = $(id).attr("name");
		if(confirm("정말 삭제하시겠습니까?")){
			location.href ="/manager/manager_delMember?mem_id="+mem_id;
		}
	}
	
	function goPage(page_num){
		location.href="/manager/manager_listMember?page_num="+page_num;
	}
</script>
<style>
#cate{
	margin-right:10px;
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

#searchDiv{
	margin-left:300px;
}
 #titleDiv{
	margin-left:100px;
 	margin-top:50px;
 }
 
 #memTable {
 	margin-top :30px;
 	margin-left:120px;
 }

 #memTable th{
	font-size: 18px;
	font-weight: bold;
	color:#5c554b;
	border-bottom: 1px solid #d4d1ca;
	padding-bottom: 10px;
	margin-left:5px;
	width:200px;
 }
 #memTable td{
 	height:50px;
 	text-align: center;
 	border-bottom: 1px solid #d4d1ca;
 	color:#5c554b;
 	font-size: 13px;
 }
 #btn:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

#btn {
	width : 60px;
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
}
</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">회원 리스트</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="searchDiv">
				<select id ="cate">
					<option>관심사별 보기</option>
					<c:forEach items="${cateList }" var ="cate">
						<option id ="cate${cate.big_num }" value ="${cate.big_num }">${cate.big_name }</option>
					</c:forEach>
				</select>
				
				<select id ="comp">
					<option>카드사별 보기</option>
					<c:forEach items="${compList }" var ="comp">
						<option id ="comp${comp.comp_num }" value ="${comp.comp_num }">${comp.comp_name }</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="tableDiv">
				<table id ="memTable">
					<tr>
						<th>번호</th><th>아이디</th><th>이메일</th><th>레벨</th><th>관심사</th>
						<th></th><th></th><th>카드사</th><th>카드명</th><th>생년월일</th><th></th>
					</tr>
					<c:forEach items="${memberList}" var ="list">
						<tr >
							<td>${list.mem_num }</td><td>${list.mem_id }</td><td>${list.mem_email }</td><td>${list.mem_level }</td><td>${list.fav1_name }</td>
							<td>${list.fav2_name }</td><td>${list.fav3_name }</td><td>${list.comp_name}</td><td>${list.card_name }</td><td>${list.mem_birthdate }</td>
							<td><input type ="button" class ="btn" value ="삭제" id= "btn" name ="${list.mem_id }" onclick="javascript:fnDel(this)"/></td>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" id ="pagingDiv">	
				<center>
					<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="true">
					    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
					    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
					    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
					    <jsp:param name="pageNo" value="${paging.pageNo}" />
					    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
					    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
					    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
					</jsp:include>
				</center>
			</div>			
		</div>
	</div>
	
</body>
</html>