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
			
			var now_small_num1, now_small_num2, now_small_num3;
			
			$.post("/accountbook/stats", {"regi_month":now_regi_month}).done(
				function(data){
					if(data[0] == null){
						console.log("이번 달 지출내역이 없음");
					}
					else{
						console.log("이번달 - " + data[0].small_name + " : " + data[0].sum + ", " 
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
						
						// 이번 달 할인내역을 알기위해 small_num을 저장
						now_small_num1 = data[0].small_num;
						now_small_num2 = data[1].small_num;
						now_small_num3 = data[2].small_num;
					}
				}		
			);
			
			$.post("/accountbook/stats", {"regi_month":prev_regi_month}).done(
					function(data){
						if(data[0] == null){
							console.log("지난 달 지출내역이 없음");
						}
						else{
							console.log("지난달 - " + data[0].small_name + " : " + data[0].sum + ", " 
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
							console.log("지지난 달 지출내역이 없음");
						}
						else{
							console.log("지지난달 - " + data[0].small_name + " : " + data[0].sum + ", " 
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
			
			var max_dc_money = 0;	// 할인받은 금액 중 가장 큰 값을 저장하기 위함
			var max_dc_smallnum;

			
			// '할인내역조회' 버튼을 누른 경우
			$("#btnDCInfo").click(
					function(){
						var totalMoney = 0;
						
						$.post("/accountbook/totalMoney", {"regi_month":now_regi_month}).done(
								function(data){
									totalMoney = parseInt(data);
								}		
						);
						
						$.post("/accountbook/discountInfo", 
							{"small_num1":now_small_num1, "small_num2":now_small_num2, "small_num3":now_small_num3,
								"sum1":now_sum1, "sum2":now_sum2, "sum3":now_sum3
							}).done(								
								function(data){
									$("#dcTable").empty();
									
									
									var dcSum = 0;	// 총 할인 금액
									
									$.each(data, function(idx, item) {	
										dcSum += item.dc_discountMoney;		
									});
									
									
									var dcInfo = "<tr><td>나의 카드</td><td id='cardInfo'>" + data[0].comp_name + "<br/>" + data[0].card_name + "</td></tr>"
												+"<tr><td>이번 달 <br/>총 사용 금액</td><td id='totalMoney'>"	+ totalMoney + "원</td></tr>"		
												+"<tr><td>이번 달 <br/>예상 할인 금액</td><td id='dcSum'><font style='font-size:25px;color:#de5a69;font-weight:bold'>- " + dcSum + "</font>원</td></tr>"
												+"<tr><td style='height:100px'>상세 할인 내역</td><td style='vertical-align:top'><div id='dcInfo'></div></td></tr>";
									
									$("#dcTable").append(dcInfo);			
												
									if(data[0] == null){									
										$("#dcInfo").text("할인 내역이 없습니다.");
									}
									else{
										$.each(data, function(idx, item) {	
											if(max_dc_money < item.dc_discountMoney){
												max_dc_money = item.dc_discountMoney;
												max_dc_smallnum = item.dc_smallnum;
											}
											
											var p = "<p>" + item.small_name + " : <font>&nbsp;&nbsp;- " + item.dc_discountMoney + "</font>원</p>"
											$("#dcInfo").append(p);
										});
									}
									
									var myCard = "<img src='/resources/images/card/" + $("#card_img").val() + "'/>";
									$("#myCard").append(myCard);
								}			
							);
					}
			);
			
			// '카드추천' 버튼을 누른 경우
			$("#btnRecommendCard").click(
				function(){
					$.post("/accountbook/recommendCard", 
							{"max_small_num":max_dc_smallnum, "small_num1":now_small_num1, "small_num2":now_small_num2, 
								"small_num3":now_small_num3, "money":max_dc_money, "regi_month":now_regi_month}).done(
						function(data){
							$("#recommendCard").empty();
							$("#cardDCInfo").empty();
							var img = "<img src='/resources/images/card/" + data[0].card_img + "'/>";
							$("#recommendCard").append(img);
							var card_name = "<br/><font>" + data[0].comp_name + " " + data[0].card_name + "</font><br/>";
							$("#recommendCard").append(card_name);
							
							if($("#card_code").val() == data[0].dc_cardcode){
								var card_code = "<font style='color:#de5a69; font-size:13px'>&nbsp;* 현재 사용 중인 카드입니다. </font>";
								$("#recommendCard").append(card_code);
							}
							
							$("#cardDcInfo").css("height", "110px");
							var text = "<font style='font-size:20px'> * 주요 할인 정보 * </font><br/><br/>";
							$("#cardDCInfo").append(text);
							
							$.each(data, function(idx, item) {	
								
								// '%'로 할인받는 경우
								if(item.dc_classify == 0){
									var p = "<p>" + item.small_name + " " + item.dc_value + "% 할인 (월 최대 " + item.dc_max + "원)</P>";
								}
								else{
									var p = "<p>" + item.small_name + " " + item.dc_value + "원 할인 (월 최대 " + item.dc_max + "원)</P>";
								}
								
								$("#cardDCInfo").append(p);
							});
							
							$('#cardDCInfo').css("background-color", "#fff").css("border", "1px solid #d4d1ca");							
						}
					);
				}		
			);
			
			// '차트보기' 버튼을 누른 경우
			$("#btnChart").click(
					function(){						
						$('#chart').css("border", "1px solid #d4d1ca");
						$('#chart').css("height", "400px");
						
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
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#content{
	margin-top:50px;
	margin-bottom:50px;
}

#btnChart, #btnDCInfo, #btnRecommendCard{
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

#btnRecommendCard{
	margin-bottom:20px;
	margin-left:20px;
	width:150px;
	background-color: #548eb3;
}

#btnRecommendCard:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}

#btnChart:hover, #btnDCInfo:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

#dcTable{
	margin-top:20px;
	width:400px;
	height:300px;
	color:#5c554b;
	font-size:15px;
	text-align:center;
	background-color: #fff;
}

#dcTable td{
	padding-top:10px;
	padding-bottom:10px;
	border:1px solid #d4d1ca;
}

#cardInfo{
	font-size:18px;
	font-weight:bold; 
}

#totalMoney, #dcSum{
	text-align:right;
	padding-right: 10px;
	font-size: 18px;
}

#dcInfo{
	color:#5c554b;
	font-size:18px;
	text-align: left;
	margin-left:20px;
}

#chart{
	width:900px;
	margin-top:20px;
}

#recommendCard{
	color:#5c554b;
	font-size:20px;
	font-weight:bold;
	margin-left:20px;
	float:left;
}

#recommendCard img{
	margin-bottom:10px;
	width:320px;
	height:180px;
}

#cardDCInfo{
	padding-left:20px;
	padding-top:20px;
	width: 350px;
	color:#5c554b;
	margin-left:100px;
	float:left;
	height:160px;
}

#myCard{
	width:300px;
	height:180px;
	margin-left:80px;
	margin-top:80px;
	float:left;
}


</style>

<body style="background-color:#f5f4f0; font-family: 'Noto Sans KR', sans-serif;">

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">
				<input type="hidden" value="${sessionScope.MEM_KEY.mem_cardcode}" id="card_code" />
				<input type="hidden" value="${sessionScope.MEM_KEY.card_img}" id="card_img" />
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

				<input type="button" value="할 인 내 역  조 회" id="btnDCInfo" />	
				
				<div>
					<div style="float:left">
						<table id="dcTable">
							<tr>
								<td style="width:152px">나의 카드</td><td></td>
							</tr>
							<tr>
								<td>이번 달 <br/>총 사용 금액</td><td></td>
							</tr>		
							<tr>
								<td>이번 달 <br/>예상 할인 금액</td><td></td>
							</tr>
							<tr>
								<td style='height:100px'>상세 할인 내역</td><td></td>
							</tr>
						</table>
					</div>
					<div id='myCard'></div>
				</div>
				
			</div>
		</div>
	</div>
	
	<div class="container" id="content">
		<div class="row">
			<div class="span12">
				<input type='button' id='btnRecommendCard' value='카 드 추 천'/><br/>
				<div id="recommendCard"></div>
				<div id="cardDCInfo"></div>
				
				<hr style="border:1px solid #d4d1ca; margin-top:270px" />
				
				<input type="button" value="차 트 보 기" id="btnChart" />	
				<div id="chart"></div>
			</div>
		</div>
	</div>
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
</body>
</html>