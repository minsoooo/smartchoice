<%@ page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>RegiMemberStep2</title>
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
	width : 250px;
	margin-left:10px;
}

#tableDiv{
	margin-top:20px;
	border : 2px solid #5c554b;
	width: 600px;
	
}
#stepDiv{
	margin-left:80px
}
#categoryTable{
	margin-top:20px;
}

#label{
	font-size: 30px;
	margin-left:10px;
}
#categoryTable td{
	width :60px;
	height : 80px;
	font-size: 40px;
	padding-left: 50px;
	padding-right: 50px;
	
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
					<img src="/resources/images/step1_1.jpg" id="step1"/>
					<img src="/resources/images/step2_2.jpg" id="step2"/>
					<img src="/resources/images/step3_1.jpg" id="step3"/>
				</div>
				<div class ="span10 offset2" id="tableDiv">
					<table id = "categoryTable">
						<tr>
							<c:forEach items="${array }" var="arr" step="1" varStatus="i">
								<td>
									<input type ="checkbox" name="" value="" id="${i.index}" style="float:left"/>
									<label  id ="label"for ="${i.index}" style="float:left">${arr}</label>
								</td>
								<c:if test="${(i.index+1)%4 == 0 }">
									<tr></tr>
								</c:if>
							</c:forEach>
						<tr/>
					</table>	
				</div>
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>