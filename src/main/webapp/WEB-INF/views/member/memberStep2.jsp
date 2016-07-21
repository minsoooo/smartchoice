<%@ page contentType="text/html; charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>RegiMemberStep2</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			var cnt = 3;
			$("input[name=big_cate]:checkbox").change(
				function(){
					if( cnt==$("input[name=big_cate]:checkbox:checked").length ) {
			            $(":checkbox:not(:checked)").attr("disabled", "disabled");
			        } else {
			            $("input[name=big_cate]:checkbox").removeAttr("disabled");
			        }
				}		
			);
			
		}	
	);

</script>
</head>
<style>


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

#btnDiv{
	margin-top:10px
}
#subBtn{

}
#tableDiv{
	margin-left:75px;
	margin-top:20px;
	border : 2px solid #d9d5cc;
	width: 800px;
}
#stepDiv{
	margin-left:80px
}

#label{
	font-size: 13px;
	font-weight: bold;
	margin-left:15px;
	color : #669aba;
}
#categoryTable{
	background-color:#fff;
}

#categoryTable td{
	border-bottom: 1px solid #d9d5cc;
	width :200px;
	height : 80px;
	font-size: 40px;
	padding-left: 10px;
	padding-right: 10px;
	
}

#subBtn {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-left: 20px;
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
#subBtn:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}	
</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="container" id="content">
		<div class="row">
			<div class="span12">
				<div class = "span12" id = "stepDiv">
					<img src="/resources/images/step1_1.jpg" id="step1"/>
					<img src="/resources/images/step2_2.jpg" id="step2"/>
					<img src="/resources/images/step3_1.jpg" id="step3"/>
				</div>
				<form method ="post" action ="/member/memberStep2">
					<input type ="hidden" name ="mem_id" value ="${MemberDto.mem_id }"/>
					<input type ="hidden" name ="mem_pw" value ="${MemberDto.mem_pw }"/>
					<input type ="hidden" name ="mem_email" value ="${MemberDto.mem_email }"/>
					<input type ="hidden" name ="mem_level" value ="${MemberDto.mem_level }"/>
					
					<div class ="span10" id="tableDiv">
						<table id = "categoryTable">
							<tr>
								<c:forEach items="${cateList }" var="cate" step="1" varStatus="i">
									<td>
										<input type ="checkbox" name="big_cate" value="${cate.big_num }" id="${i.index}" style="float:left"/>
										<label  id ="label"for ="${i.index}" style="float:left">${cate.big_name}</label>
									</td>
									<c:if test="${(i.index+1)%4 == 0 }">
										<tr></tr>
									</c:if>
								</c:forEach>
							<tr/>
						</table>		
					</div>
					<div class = "span1 offset8" id ="btnDiv">
						<input type ="submit" value ="다음단계로" class="btn" id ="subBtn"/>
					</div>
				</form>	
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>