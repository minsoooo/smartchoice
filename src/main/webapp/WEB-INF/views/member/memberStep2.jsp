<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>RegiMember</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
</script>
</head>
<style>
body{
	background-color:#f5f4f0;
}

#imgTd{
	width : 20px
}
#content{
	margin-top:50px;
	margin-bottom:50px;
}

#step1, #step2, #step3{
	height: 150px;
	width : 250px;
}

#stepDiv{
	margin-left:200px
}

#formDiv{
	margin-top :20px;
	margin-left:420px;
}
input{
	height:30px;

}
#id, #pass1, #pass2{
	width : 300px;
	margin-bottom:5px;
	
}
#email1,#email2{
	width : 139px;
	margin-bottom:5px;
}

#email_check{
	width : 168px;
}

.btn {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left: 50px;
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
	outline: 0
</style>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<span id ="check" value = "false"></span>
	<span id ="checkCode" value =""></span>
	<div class="container" id="content">
		<div class="row">
			<div class="span12">
				<div class = "span12" id = "stepDiv">
					<img src="/resources/images/step1_2.jpg" id="step1"/>
					<img src="/resources/images/step2_1.jpg" id="step2"/>
					<img src="/resources/images/step3_1.jpg" id="step3"/>
				</div>
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>