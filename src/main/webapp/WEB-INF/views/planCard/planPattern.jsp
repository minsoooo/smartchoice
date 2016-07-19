<!-- 
	카드추천 소비 패턴리스트 페이지  
		소비패턴을 통한, 회원의 관심사를 통한 카드추천 선택
	작성일 : 2016-07-18
	수정일 : 2016-07-18
	작성자 : 김상덕
	cardPlan Snapshot 1.1 by.santori
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>plan Intro</title>

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<form action="" method="post">
	
	
<div class="container" id="content">
	<div class="row">
		<div class="span12">
		
			<!-- ST content -->
			<!-- ST 가맹점 분리 -->
			<div class="span2" style="border-top:2px solid black">
				<c:forEach items="${bigDtoList}" var="bigClassDto">
					${bigClassDto.big_num}
					${bigClassDto.big_name}
				</c:forEach>
			</div>
			<!-- END 가맹점 분리 -->
			<!-- ST pattern List -->
			<div class="span7" style="border-top:2px solid black">
				여기서 대분류 땡겨와서 받고
			</div>
			<!-- END pattern List -->
			<div class="span2" style="border-top:2px solid black">3
			
			</div>
			<!-- END content -->
			
		</div>
	</div>
</div>
	
	
	


</form>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>
