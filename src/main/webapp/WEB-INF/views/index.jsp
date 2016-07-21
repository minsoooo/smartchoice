<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			if($("#regiCheck").attr("value") == "true"){
				alert("회원 가입이 완료 되었습니다.")
			}
		}		
	);
</script>
<style>
body{
	background-color:#f5f4f0;
}

#content{
	margin-top:50px;
	margin-bottom:50px;
}
</style>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<span id ="regiCheck" value ="${regiCheck }"></span>
	<div class="container" id="content">
		<div class="row">
			<div class="span12">
			
				<!-- 내용 들어갈 부분 -->
			
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
</html>