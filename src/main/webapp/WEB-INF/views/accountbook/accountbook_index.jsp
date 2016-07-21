<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			$("#calTable td:first-child").css("color", "#de5a69");	// 일요일 색 지정
			$("#calTable td:last-child").css("color", "#3e7eb9");	// 토요일 색 지정
			
			// 달력을 클릭했을 때 해당 날짜의 정보 및 대분류 가져오기
			$("img").click(
				function(){
					var selectDate = $("#now_year").attr("value") + "년 " + $("#now_month").attr("value") + "월 " 
									+ $(this).attr("id") + "일";
					$("#expenseTr1 td").text(selectDate);		// 선택한 날짜를 출력

					$.get("/accountbook/bigCategory").done(	
						function(xml){	
							var xmlData = $(xml).find("big").each(	
								// bigCategory의 개수만큼 실행한다.
								function(){
									var big_name = $(this).find("bigname").text();
									var big_num = $(this).find("bignum").text();
									// big_num과 big_name을 가져온다.									
									
									var addOption = document.createElement("option");	 // option태그를 생성한다.
									addOption.value = big_num;		// option태그의 아이디값을 big_num으로 지정한다.
									addOption.appendChild(document.createTextNode(big_name));
									// option태그에 big_name의 값을 넣는다. 
									
									$("#bigCategory").append(addOption);	// select태그에 option태그를 추가한다.						
								}		
							);
						}	
					);
				}
			);
			
			// 대분류를 선택했을 때 그에 맞는 소분류 가져오기
			$("#bigCategory").change(
				function(){
					var big_num = $("#bigCategory option:selected").val();
					$("#smallCategory").empty();
					
					$.get("/accountbook/smallCategory",{"big_num":big_num}).done(	
						function(xml){	
							var xmlData = $(xml).find("small").each(	
								// smallCategory의 개수만큼 실행한다.
								function(){
									var small_num = $(this).find("smallnum").text();
									var small_name = $(this).find("smallname").text();
									// small_num과 small_name을 가져온다.			

									var addOption = document.createElement("option");	 // option태그를 생성한다.
									addOption.value = small_num;		// option태그의 아이디값을 small_num으로 지정한다.
									addOption.appendChild(document.createTextNode(small_name));
									// option태그에 small_name의 값을 넣는다. 
										
									$("#smallCategory").append(addOption);	// select태그에 option태그를 추가한다.						
								}		
							);
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

#form1{
	float:left;
	margin-left:50px;
	color:#5c554b;
	font-size:15px;
}

#expenseTable{
	margin-bottom:20px;
}

#expenseTable td{
	border-bottom:1px solid #d4d1ca;
	width:250px;
}

#expenseTr1{height:50px;}
#expenseTr2{height:200px;}
#expenseTr3{height:50px;}
#bigCategory{width:200px;}
#smallCategory{width:200px;}

#price{
	width:210px;
	text-align:right;	
}

#expenseTr1 td{
	font-size:20px;
	text-align: center;
}

#btnInsert, #btnDelete, #btnSubmit{
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
	width:120px;
	border: 0;
	outline: 0;
}

#btnInsert:hover, #btnDelete:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

#btnSubmit{
	margin-top:10px;
	background-color:#548eb3;
	font-size:16px;
	width:243px;
	height:40px;
}

#btnSubmit:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
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
						<a href="/accountbook/index?now_month=${prev_month}&now_year=${prev_year}">&lt;&lt;</a>
						&nbsp;&nbsp;<span id="dayTitle"> ${now_year}년 ${now_month}월</span>&nbsp;&nbsp; 
						<a href="/accountbook/index?now_month=${next_month}&now_year=${next_year}">&gt;&gt;</a>
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
											
								<td><%=tempDay%>
									<img src="/resources/images/cal_default.jpg" id="<%=tempDay%>"/>
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
				
				
				<!-- 지출내역 출력부분 -->
				<form method="post" action="" id="form1">
					<!-- 대분류와 소분류를 선택하면 그 아이디(big_num, small_num)를 담아서 전달하기 위함 -->
					<input type="hidden" id="selectBig" value=""/>
					<input type="hidden" id="selectSmall" value=""/>
				
					<table id="expenseTable">
						<tr id="expenseTr1">
							<td></td>	<!-- 선택한 날짜가 들어갈 공간 -->
						</tr>
						<tr id="expenseTr2">
							<td>	<!-- 지출목록을 보여줄 공간 -->
								<div>
																	
								</div>
							</td>
						</tr>
						<tr id="expenseTr3">
							<td>합계 : <div id="sum"></div></td>
						</tr>
					</table>
					
					<!-- 대분류 -->
					대분류 <select id="bigCategory" >
					
					</select><br/>
					
					<!-- 소분류 -->
					소분류 <select id="smallCategory">
						
					</select><br/>
					
					<input type="text" id="price" name="price"/> 원<br/>
					
					<input type="button" value="추 가" class="btn" id="btnInsert" />
					<input type="button" value="삭 제" class="btn" id="btnDelete" /> <br/>
					<input type="submit" value="완 료 하 기" class="btn" id="btnSubmit" />
				</form>
			</div>
		</div>
	</div>
		
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
</body>
</html>