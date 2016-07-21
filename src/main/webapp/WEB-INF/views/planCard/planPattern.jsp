<!-- 
	카드추천 소비 패턴리스트 페이지  
		소비패턴을 통한, 회원의 관심사를 통한 카드추천 선택
	작성일 : 2016-07-18
	수정일 : 2016-07-18
	작성자 : 김상덕
	cardPlan Snapshot 1.3 by.santori
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>plan Intro</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			
			$("span").click(
				function(){
					alert($(this).attr("value"));
					$("#smallList").empty();
					var blgclass_num = $(this).attr("value");
					
					$.get("/planCard/getSmallclass",{"blgclass_num":blgclass_num}).done(
						function(xmlData){
							var category = $(xmlData).find("category");
						}
					);
				}		
			);
			
		}	
	);

</script>
</head>
<body style="background-color:#f5f4f0;">
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<form action="" method="post">
	
	
<div class="container" id="content">
	<div class="row">
		<div class="span12">
		
			<!-- ST content -->
			<!-- ST 가맹점 분리 -->
			<div class="span2" style="border-top:2px solid black">
				<c:forEach items="${bigDtoList}" var="bigClassDto" step="1" varStatus="i">
					<div>
						<span id ="big_num" value ="${bigClassDto.big_num}">${bigClassDto.big_name}	</span>
					</div>
				</c:forEach>
			</div>
			<!-- END 가맹점 분리 -->
			
			<!-- ST pattern List -->
			<div class="span7" style="border-top:2px solid black">
				
				<div id="smallList">
									
				</div>
				
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
