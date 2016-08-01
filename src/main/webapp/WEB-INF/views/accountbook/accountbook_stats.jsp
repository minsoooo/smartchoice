<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			var now_regi_month = $("#regi_month").attr("value");
			
			var prev_year = $("#prev_year").attr("value").trim();
			var prev_month = $("#prev_month").attr("value").trim();	
			var prev_prev_year = $("#prev_prev_year").attr("value").trim();
			var prev_prev_month = $("#prev_prev_month").attr("value").trim();
			
			var prev_regi_month = "", prev_prev_regi_month = "";	
			// 1달전과 2달전의 regi_month(2016-07 형식)를 만든다.
			if(prev_month.length < 2){
				prev_regi_month = prev_year + "-0" + prev_month;
			}
			else{
				prev_regi_month = prev_year + "-" + prev_month;
			}
			
			if(prev_prev_month.length < 2){
				prev_prev_regi_month = prev_prev_year + "-0" + prev_prev_month;
			}
			else{
				prev_prev_regi_month = prev_prev_year + "-" + prev_prev_month;
			}

			
			var now_big_name1, now_small_name1, now_sum1, 
			 	now_big_name2, now_small_name2, now_sum2, 
			 	now_big_name3, now_small_name3, now_sum3,
			 	
			 	prev_big_name1, prev_small_name1, prev_sum1, 
			 	prev_big_name2, prev_small_name2, prev_sum2, 
			 	prev_big_name3, prev_small_name3, prev_sum3,
			 	
			 	prev_prev_big_name1, prev_prev_small_name1, prev_prev_sum1, 
			 	prev_prev_big_name2, prev_prev_small_name2, prev_prev_sum2, 
			 	prev_prev_big_name3, prev_prev_small_name3, prev_prev_sum3;
			
			
			$.post("/accountbook/stats", {"regi_month":now_regi_month}).done(
				function(data){
					if(data[0] == null){
						alert("이번 달 지출내역이 없음");
					}
					else{
						alert("이번달 - " + data[0].small_name + " : " + data[0].sum + ", " 
								+ data[1].small_name + " : " + data[1].sum + ", " 
								+ data[2].small_name + " : "  + data[2].sum);	
						
						now_big_name1 = data[0].big_name;
						now_small_name1 = data[0].small_name;
						now_sum1 = data[0].sum;
						
						now_big_name2 = data[1].big_name;
						now_small_name2 = data[1].small_name;
						now_sum2 = data[1].sum;
						
						now_big_name3 = data[2].big_name;
						now_small_name3 = data[2].small_name;
						now_sum3 = data[2].sum;
					}
				}		
			);
			
			$.post("/accountbook/stats", {"regi_month":prev_regi_month}).done(
					function(data){
						if(data[0] == null){
							alert("지난 달 지출내역이 없음");
						}
						else{
							alert("지난달 - " + data[0].small_name + " : " + data[0].sum + ", " 
									+ data[1].small_name + " : " + data[1].sum + ", " 
									+ data[2].small_name + " : "  + data[2].sum);	
							
							prev_big_name1 = data[0].big_name;
							prev_small_name1 = data[0].small_name;
							prev_sum1 = data[0].sum;
							
							prev_big_name2 = data[1].big_name;
							prev_small_name2 = data[1].small_name;
							prev_sum2 = data[1].sum;
							
							prev_big_name3 = data[2].big_name;
							prev_small_name3 = data[2].small_name;
							prev_sum3 = data[2].sum;
						}
					}		
				);
			
			$.post("/accountbook/stats", {"regi_month":prev_prev_regi_month}).done(
					function(data){						
						if(data[0] == null){
							alert("지지난 달 지출내역이 없음");
						}
						else{
							alert("지지난달 - " + data[0].small_name + " : " + data[0].sum + ", " 
									+ data[1].small_name + " : " + data[1].sum + ", " 
									+ data[2].small_name + " : "  + data[2].sum);	
							
							prev_prev_big_name1 = data[0].big_name;
							prev_prev_small_name1 = data[0].small_name;
							prev_prev_sum1 = data[0].sum;
							
							prev_prev_big_name2 = data[1].big_name;
							prev_prev_small_name2 = data[1].small_name;
							prev_prev_sum2 = data[1].sum;
							
							prev_prev_big_name3 = data[2].big_name;
							prev_prev_small_name3 = data[2].small_name;
							prev_prev_sum3 = data[2].sum;
						}
					}		
				);
			
			var maxValue = prev_prev_sum1;
			
			if(maxValue < prev_sum1){
				maxValue = prev_sum1;
			}
			
			if(maxValue < now_sum1){
				maxValue = now_sum1;
			}
			
			
			$("#btnChart").click(
					function(){
						$('#chart').css("border", "1px solid #d4d1ca");

						$('#chart').highcharts({
							   title: {
								    text: '사용 내역 TOP3'
							   },
							   subtitle: {
								    text: '기준 달로부터 세 달'
							   },
							   chart: {
					               type: 'column'
					           },
					           xAxis: {
					        	   categories: ["1. " + prev_prev_small_name1, "2. " + prev_prev_small_name2, "3. " + prev_prev_small_name3,
					        	                "1. " + prev_small_name1, "2. " + prev_small_name2, "3. " + prev_small_name3,
					        	                "1. " + now_small_name1, "2. " + now_small_name2, "3. " + now_small_name3]
					           },
					           yAxis: {
					               title: {
					                   text: '단위 (원)'
					               },
					               max: maxValue
					           }, 
					           tooltip: {
					        	   formatter: function () {
					                   return '<b>' + this.x  + '</b><br/><b>'+ this.y + "</b> 원";
					               }
					           },

					           plotOptions: {
					               series: {
					                   pointWidth: 30
					               }
					           },

					           series: [
								{name: prev_prev_regi_month, color:'#d4d1ca'},
								{name: prev_regi_month, color:'#706b67'},
								
					           	{
					        	   name:now_regi_month + ' 기준',
					               data: [
					                      {y:prev_prev_sum1, color:'#d4d1ca'},
					                      {y:prev_prev_sum2, color:'#d4d1ca'},
					                      {y:prev_prev_sum3, color:'#d4d1ca'},
					                      
					                      {y:prev_sum1, color:'#706b67'},
					                      {y:prev_sum2, color:'#706b67'},
					                      {y:prev_sum3, color:'#706b67'},
					                      
					                      {y:now_sum1, color:'#8ba752'},
					                      {y:now_sum2, color:'#8ba752'},
					                      {y:now_sum3, color:'#8ba752'}
					                      
					           		],
					           		
					               color:'#8ba752'
					           	}]

					        });
						 
					}
			);
			
			
	
		}		
	);
</script>

<style>
#content{
	margin-top:50px;
	margin-bottom:100px;
}

#btnChart{
	display: inline-block;
	padding: 6px 12px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: 400;
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
	color:#fff; 
	border: 1px solid transparent;
	border-radius: 4px;
	width:200px;
	border: 0;
	outline: 0;
	
}

#btnChart:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}


#DCDiv{
	margin-top:30px;
	margin-bottom:50px;
}
</style>

<body style="background-color:#f5f4f0">

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">
				<input type="hidden" value="${regi_month}" id="regi_month" />
				<input type="hidden" value="${now_year}" id="now_year" />
				<input type="hidden" value="${now_month}" id="now_month" />
				
				<!-- 1달 전과 2달 전 설정 -->
				<c:choose>
					<c:when test="${now_month-1 eq 0}">
						<c:set var="prev_month" value="12"></c:set>
						<c:set var="prev_year" value="${now_year-1}"></c:set>
						<c:set var="prev_prev_month" value="11"></c:set>
						<c:set var="prev_prev_year" value="${now_year-1}"></c:set>
					</c:when>	
					<c:when test="${now_month-2 eq 0}">
						<c:set var="prev_month" value="${now_month-1}"></c:set>
						<c:set var="prev_year" value="${now_year}"></c:set>
						<c:set var="prev_prev_month" value="12"></c:set>
						<c:set var="prev_prev_year" value="${now_year-1}"></c:set>
					</c:when>				
					<c:otherwise>
						<c:set var="prev_month" value="${now_month-1}"></c:set>
						<c:set var="prev_year" value="${now_year}"></c:set>
						<c:set var="prev_prev_month" value="${now_month-2}"></c:set>
						<c:set var="prev_prev_year" value="${now_year}"></c:set>
					</c:otherwise>				
				</c:choose>
				
				<input type="hidden" value="${prev_month}" id="prev_month" />
				<input type="hidden" value="${prev_year}" id="prev_year" />
				<input type="hidden" value="${prev_prev_month}" id="prev_prev_month" />
				<input type="hidden" value="${prev_prev_year}" id="prev_prev_year" />
				
				<div id="DCDiv">
					<span id="DCResult"></span>
					<input type="button" value="사 용 내 역 조 회" id="btnChart" />				
				</div>
				 <div id="chart" style="height:400px; width:900px"></div>
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
</body>
</html>