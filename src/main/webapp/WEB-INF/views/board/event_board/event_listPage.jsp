<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<!DOCTYPE html>
<html>
<head>
<title>이벤트 게시판</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>	
	$(document).ready(
		function(){		
			var year = $("#now_year").val();
			var month = $("#now_month").val();
			var today = $("#today").val();
			
			$("#calTable td:first-child").css("color", "#de5a69");	// 일요일 색 지정
			$("#calTable td:last-child").css("color", "#3e7eb9");	// 토요일 색 지정
			
			var text = "<font style='font-size:20px; font-weight:bold; margin-left:40px; color:#de5a69'>TODAY'S EVENT</font><br/><br/>";
			$("#todayEvent").empty();
			$("#todayEvent").append(text);
			$.post("/board/event_board/event_select", {"year":year, "month":month, "date":today}).done(
				function(data){
					$.each(data, function(idx, item) {	
						var a= "<a href='#?num=" + item.eboard_num + "'> * " + item.eboard_title + "</a>"
						+ "<p>기간 : " + item.eboard_start + " ~ " + item.eboard_end + "</p>";
				
						$("#todayEvent").append(a);
					});	
				}		
			);
			
			$(".count").click(
				function(){
					$("#eventList").empty();
					$("#now_date").attr("value", $(this).attr("id"));	// 선택한 '일'을 히든태그에 저장해둠		
					
					
					var date = $("#now_date").val();
					var selectDate = year + "년 " + month + "월 " + date + "일 EVENT!";
					$("#tr1 td").text(selectDate);
			
					
					$.post("/board/event_board/event_select", {"year":year, "month":month, "date":date}).done(
						function(data){
							$.each(data, function(idx, item) {									
								var a= "<a href='/board/event_board/event_readPage?check=user&num=" + item.eboard_num + "'> * " + item.eboard_title + "</a>"
										+ "<p>기간 : " + item.eboard_start + " ~ " + item.eboard_end + "</p>";
								
								$("#eventList").append(a);
							});
						}		
					);
				}
			);
			
			
		}
	);
	
</script>

</head>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
#content{
	margin-top:100px;
	margin-bottom:100px;
}
#cal{
	float:left;
	margin-left:50px;
}
#calTable{
	height:500px;
	background-color:#fff;
	margin-top:20px;
	color:#5c554b;
}

#calTable td{
	border:1px solid #d4d1ca;
	width:60px;
	vertical-align:top;
	padding-left:5px;
	padding-top:5px;
}
#calTitle{
	margin-left:20px;
}
#calTitle a{
	font-size:25px;
	color:#5c554b;
}
#calTitle a:hover{
	color:#8ba752;
	text-decoration:none;
}
#calTitle span{
	font-size:18px;
	color:#5c554b;
}
#calDay td{
	font-size:20px;
	text-align:center;
	vertical-align:middle;
	padding-left:0px;
	padding-top:0px;
}

#eventInfo{
	float:left;
	margin-left:50px;
	color:#5c554b;
	font-size:15px;
}

#eventTable td{
	border-bottom:1px solid #d4d1ca;
	width:250px;
}
#tr1{height:50px;}

#tr2{
	height:250px;
}

#tr1 td{
	font-size:20px;
	text-align: center;
	font-weight:bold;
}
#calTable div{
	width:55px;
	height:50px;
	color:#8ba752;
	font-size:14px;
	font-weight:bold;
	text-align: center;
	padding-top:20px;
}
#calTable div:hover{
	cursor:pointer;
}
#eventList{
	height:230px;
	padding-left:10px;
	overflow:auto;
	margin-top:20px;
}
#todayEvent{
	margin-top:20px;
	width:250px;
	height:220px;
	background-color: #fff;
	border: 1px solid #d4d1ca;
	padding-left:10px;
	overflow:auto;
	padding-top:10px;
}

#eventList a{
	color:#8ba752;
	font-weight:bold;
	font-size:16px;
}

#countNum{
	font-size:13px;
	font-weight:normal;
}
</style>
<body style="background-color:#f5f4f0; font-family: 'Noto Sans KR', sans-serif;">

<%!
	public static final int START_DATE = 1;	//시작일을 저장하는 constant
%>

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	<div class="container" id="content">
		<div class="row">
			<div class="span12">	
				
				<!-- 선택된 년,월을 가져옴(now_year, now_month) -->
				<input type="hidden" value="${now_year}" id="now_year" />
				<input type="hidden" value="${now_month}" id="now_month" />
				<input type="hidden" value="" id="now_date" />	<!-- 선택한 '일'을 저장할 공간 -->
				
				<c:choose>
					<c:when test="${now_month-1 eq 0}">
						<c:set var="prev_month" value="12"></c:set>
						<c:set var="prev_year" value="${now_year-1}"></c:set>
					</c:when>					
					<c:otherwise>
						<c:set var="prev_month" value="${now_month-1 }"></c:set>
						<c:set var="prev_year" value="${now_year}"></c:set>
					</c:otherwise>				
				</c:choose>
				
				<c:choose>
					<c:when test="${now_month+1 eq 13}">
						<c:set var="next_month" value="1"></c:set>
						<c:set var="next_year" value="${now_year+1}"></c:set>
					</c:when>					
					<c:otherwise>
						<c:set var="next_month" value="${now_month+1}"></c:set>
						<c:set var="next_year" value="${now_year}"></c:set>
					</c:otherwise>
				</c:choose>
				
				
				<!-- 달력 출력 -->
				<div id="cal">
					<div id="calTitle">
						<a href="/board/event_board/event_listPage?now_month=${prev_month}&now_year=${prev_year}">&lt;&lt;</a>
						&nbsp;&nbsp;<span id="dayTitle"> ${now_year}년 ${now_month}월</span>&nbsp;&nbsp; 
						<a href="/board/event_board/event_listPage?now_month=${next_month}&now_year=${next_year}">&gt;&gt;</a>
					</div>
							
					<div id="calContent">
						<table id="calTable">
							<tr id="calDay">
								<td>Sun</td>
								<td>Mon</td>
								<td>Tue</td>
								<td>Wed</td>
								<td>Thu</td>
								<td>Fri</td>
								<td>Sat</td>
							</tr>
							<tr>
								<%
									Calendar cal = Calendar.getInstance();
									int now_year = (Integer)request.getAttribute("now_year");									
									int now_month = (Integer)request.getAttribute("now_month");
									int now_date = cal.get(Calendar.DATE);
								%>
								<input type="hidden" id="today" value="<%=now_date%>"/>
								<% 
									cal.set(now_year, now_month-1, 1);	
									cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE)); // 선택한 월의 마지막 날짜를 구해서 설정
								
									for (int tempDay = 1;; tempDay++) {
										//증가하는 임시날짜를 달력객체 설정
										cal.set(Calendar.DAY_OF_MONTH, tempDay);
										
										if (tempDay != cal.get(Calendar.DAY_OF_MONTH)) {
											//설정된 날짜와 임시날짜가 다르다면 끝 일이므로 반복문을 빠져나간다.		     
											//끝의공백추가
											// 뒷부분 공백처리
											for (int i = cal.get(Calendar.DAY_OF_WEEK); i <= 7; i++) {
												if (cal.get(Calendar.DAY_OF_WEEK) == 1) { //밑에 남는 칸들 제거됨
													break;	
												}
								%>
								
								<td class="blank">&nbsp;</td>
											
								<%
											}
											break;
										} //end if
													
										switch (tempDay) {
											case START_DATE: //가독성을 높인당 constant
												//1일을 출력하기 전에 공백을 출력한다.
												int week = cal.get(Calendar.DAY_OF_WEEK);
	
												for (int blank = 1; blank < week; blank++) {
								%>
											
								<td class="blank">&nbsp;</td>
								
								<%
												} //end for
										}//end switch
								%>
											
								<td>
									<%=tempDay%>
									<%request.setAttribute("tempDay", tempDay); %>
									<div id='<%=tempDay%>' class="count">
										<c:if test="${countList[tempDay] != 0}">
											EVENT							
										</c:if>
									</div>	
									
									
								</td>
	
								<%
									//설정된 일자가 토요일이면 행을 변경한다.
										switch (cal.get(Calendar.DAY_OF_WEEK)) {
											case Calendar.SATURDAY:
								%>
										
							</tr>
							<tr>
								<%
										}
									}
									//end for
								%>									
						</table>
					</div>	
				</div>	
				
				
				<div id="eventInfo">
					<table id="eventTable">
						<tr id="tr1">
							<td></td>	<!-- 선택한 날짜가 들어갈 공간 -->
						</tr>
						<tr id="tr2">
							<td>	
								<div id="eventList">
									<center>날짜를 클릭하시면 <br/>이벤트 정보를 보실 수 있습니다!</center>
								</div>
							</td>
						</tr>
					</table>	
					
					<div id="todayEvent">
						
					</div>			
				</div>
				
			</div>
		</div>
	</div>
		
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
</body>
</html>
