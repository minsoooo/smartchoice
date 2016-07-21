<%@ page contentType="text/html; charset=UTF-8"%>
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
				alert("회원가입을 축하합니다.");

			}
		}		
	);
</script>
<style>
#content{
	margin-top:50px;
	margin-bottom:50px;
}
</style>
<body style="background-color:#f5f4f0">

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<span id ="regiCheck" value ="${regiCheck }"></span>
	<div class="container" id="content">
		<div class="row">
			<div class="span12" style="border:1px solid red">
				
				 
				
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
</html>