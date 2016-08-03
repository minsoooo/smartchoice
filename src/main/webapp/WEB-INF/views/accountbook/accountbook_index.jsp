<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	var select_tr, list_big_num, list_small_num, list_money;
	$(document).ready(
		function(){
			var now_year = $("#now_year").attr("value").trim();
			var now_month = $("#now_month").attr("value").trim();	// 현재 달력에 표시된 년,월을 받음
			
			var regi_month = "";			
			if(now_month.length < 2){
				regi_month = now_year + "-0" + now_month;
			}
			else{
				regi_month = now_year + "-" + now_month;
			}	// regi_month(2016-07의 형태)를 만든다.
			
			var regi_days = $("#regi_days").attr("value").split(",");	// 지출을 등록한 날을 split하여 배열에 담음
			
			for(var i = 0; i < regi_days.length; i++){
				var id = "#"+regi_days[i];
				$(id).attr("src", "/resources/images/cal_img.jpg");		// 해당 날의 이미지를 바꿈
				$(id).attr("value", "check");
			}
			
			$("#calTable td:first-child").css("color", "#de5a69");	// 일요일 색 지정
			$("#calTable td:last-child").css("color", "#3e7eb9");	// 토요일 색 지정

			// 달력을 클릭했을 때 해당 날짜의 정보 및 대분류 가져오기
			$("img").click(
				function(){
					$("#now_date").attr("value", $(this).attr("id"));	// 선택한 '일'을 히든태그에 저장해둠

					$("#listTable").empty();		// 지출목록 초기화
					$("#price").val("");	// 금액 입력 초기화
					$("#sumDiv").empty();			// 합계초기화
					$("#bigCategory").empty();	
					$("#smallCategory").empty();	// 대분류, 소분류 초기화
					
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
									addOption.id = "big" + big_num;
									addOption.value = big_num;		// option태그의 value값을 big_num으로 지정한다.
									addOption.appendChild(document.createTextNode(big_name));
									// option태그에 big_name의 값을 넣는다. 
									
									$("#bigCategory").append(addOption);	// select태그에 option태그를 추가한다.						
								}		
							);
						}	
					);
					
					// 소분류에 초기값으로 '대중교통'에 해당하는 소분류를 설정
					$.get("/accountbook/smallCategory",{"big_num":1}).done(	
							function(xml){	
								var xmlData = $(xml).find("small").each(	
									function(){
										var small_num = $(this).find("smallnum").text();
										var small_name = $(this).find("smallname").text();			

										var addOption = document.createElement("option");	 
										addOption.id = "small" + small_num;
										addOption.value = small_num;
										addOption.appendChild(document.createTextNode(small_name));
											
										$("#smallCategory").append(addOption);						
									}		
								);
							}
					);
					
					
					var now_day = $("#now_date").attr("value").trim();					
					
					// 등록한 지출목록이 있는 경우
					if($(this).attr("value") != ""){			
						$.get("/accountbook/getAccountBook", {"regi_month":regi_month, "regi_day":now_day}).done(
							function(xml){
								var xmlData = $(xml).find("accountbook").each(	
									function(){
										var big_name = $(this).find("bigname").text();
										var big_num = $(this).find("bignum").text();
										var small_name = $(this).find("smallname").text();
										var small_num = $(this).find("smallnum").text();
										var money = $(this).find("money").text();
										
										//alert(big_name +", " + small_name +", " + money);
										
										var addList = "<tr onclick='fnTr(this)' check=''>"
											+ "<td id='big' name='"+ big_num + "'>" + big_name + "</td>"
											+ "<td id='small' name='" + small_num + "'>" + small_name + "</td>"
											+ "<td id='money' name='" + money + "'>" + money + "원</td></tr>"
											
										$("#listTable").append(addList);			
									}
								);
								
								var sum = 0;	// 합계
								$("#listTable tr").each(
									function(){
										sum += parseInt($(this).children("td:eq(2)").attr("name"));
									}		
								);							
								$("#sumDiv").text(sum + " 원");		// 합계 출력	
							}		
						);
					}
					
				}
			);
			
			// 대분류를 선택했을 때 그에 맞는 소분류 가져오기
			$("#bigCategory").change(
				function(){
					var big_num = $("#bigCategory option:selected").val();
					$("#smallCategory").empty();	// 소분류 초기화
					
					$.get("/accountbook/smallCategory",{"big_num":big_num}).done(	
						function(xml){	
							var xmlData = $(xml).find("small").each(	
								// smallCategory의 개수만큼 실행한다.
								function(){
									var small_num = $(this).find("smallnum").text();
									var small_name = $(this).find("smallname").text();
									// small_num과 small_name을 가져온다.			

									var addOption = document.createElement("option");	 // option태그를 생성한다.
									addOption.id = "small" + small_num;
									addOption.value = small_num;		// option태그의 value값을 small_num으로 지정한다.
									addOption.appendChild(document.createTextNode(small_name));
									// option태그에 small_name의 값을 넣는다. 
										
									$("#smallCategory").append(addOption);	// select태그에 option태그를 추가한다.						
								}		
							);
						}
					);
				}
			);
			
			
			
			
			// '추가'버튼을 눌렀을 경우
			$("#btnInsert").click(
				function(){
					var select_big = $("#bigCategory option:selected").text();
					var select_small = $("#smallCategory option:selected").text();
					var money = $("#price").val();
					
					/*
						<tr onclick='fnTr(this)' check=''>		// check값은 클릭 시 배경색을 바꾸기 위함
							<td id="big" name="1">대중교통</td>
							<td id="small" name="1">버스</td>
							<td id="money" name="10000">10000</td>
						</tr>
					*/

					var addList = "<tr onclick='fnTr(this)' check=''>"
							+ "<td id='big' name='"+ $("#bigCategory option:selected").val() + "'>" + select_big + "</td>"
							+ "<td id='small' name='" + $("#smallCategory option:selected").val() + "'>" + select_small + "</td>"
							+ "<td id='money' name='" + money + "'>" + money + "원</td></tr>"
							
					$("#listTable").append(addList);
					
					var sum = 0;	// 합계
					$("#listTable tr").each(
						function(){
							sum += parseInt($(this).children("td:eq(2)").attr("name"));
						}		
					);							
					$("#sumDiv").text(sum + " 원");		// 합계 출력
				}		
			);
			
			$("#listTable").click(
					function(){
						if(list_big_num != null){	// 지출목록 중 하나를 선택했을 경우
						
							if($(select_tr).attr("check") == ""){
								$(select_tr).css("background-color", "#8ba752").css("color", "#fff");
								$(select_tr).attr("check","select");
							}
							else{
								$(select_tr).css("background-color", "").css("color", "");
								$(select_tr).attr("check","");
							}
						}
					}		
			);

			
			// '삭제'버튼을 눌렀을 경우
			$("#btnDelete").click(
				function(){										
					$("#listTable tr[check='select']").remove();
					
					var sum = 0;	// 합계
					$("#listTable tr").each(
						function(){
							sum += parseInt($(this).children("td:eq(2)").attr("name"));
						}		
					);							
					$("#sumDiv").text(sum + " 원");		// 합계 출력
				}		
			);
			
			
			// '저장하기'버튼을 눌렀을 경우
			$("#btnSubmit").click(
				function(){
					if (confirm("저장하시겠습니까??") == true){  // 확인  
						var accountList = new Array();	// 선택한 날짜의 전체 지출 목록을 저장할 공간, Object를 배열로 저장				
						
						var now_year = $("#now_year").attr("value").trim();
						var now_month = $("#now_month").attr("value").trim();
						var regi_month = "";
						
						if(now_month.length < 2){
							regi_month = now_year + "-0" + now_month;
						}
						else{
							regi_month = now_year + "-" + now_month;
						}
						
						
						// 지출목록을 모두 지우고 저장하려는 경우
						if($("#listTable tr").length == 0){
							var obj = new Object();
							obj.regi_month = regi_month;
							obj.regi_day = $("#now_date").attr("value").trim();
							accountList.push(obj);		// 날짜정보만 Array에 추가
						}
						else{ 
							// 지출목록이 있는 경우
							$("#listTable tr").each(	// 목록의 개수만큼 실행
								function(){
									var obj = new Object();			// key, value 형태로 저장
									
									obj.abook_bignum = $(this).children("td:eq(0)").attr("name");
									obj.abook_smallnum = $(this).children("td:eq(1)").attr("name");
									obj.abook_money = $(this).children("td:eq(2)").attr("name");
									obj.regi_month = regi_month;
									obj.regi_day = $("#now_date").attr("value").trim();
									accountList.push(obj);		// 날짜와 지출목록의 정보를 Array에 추가
								}		
							);
						}			
					
						$.ajax({		// 해당 날짜의 지출목록을 보냄
							url:"/accountbook/insertList",
							type:"POST",
							data:JSON.stringify(accountList),	// json string형식
							dataType:"json",
							contentType: "application/json",
							success:function(){
								location.href="/accountbook/index?now_year="+now_year+"&now_month=" +now_month;
							},
							error:function(){
								location.href="/accountbook/index?now_year="+now_year+"&now_month=" +now_month;
							}
						});		
					}
					else{	// 취소
						return false;
					}
				}
			);
			
			
			// 통계보기 버튼을 클릭한 경우
			$("#btnStats").click(
				function(){
					location.href="/accountbook/stats?regi_month=" + regi_month + "&now_year=" + now_year + "&now_month=" +now_month;
				}		
			);
			
			
		}
	);
	
	// 숫자만 입력하게 함
	$(document).on("keyup", "#price", function(){
		$(this).val($(this).val().replace(/[^0-9]/gi, ""));	
	});
	
	//지출목록 중 하나를 선택했을 경우
	function fnTr(tr){
		select_tr = tr;			// 현재 선택한 행의 주소를 담음
		var td = tr.childNodes;	// 선택한 행을 가져옴
		
		list_big_num = td[0].getAttribute("name");		// 대분류의 name값을 담음
		list_small_num = td[1].getAttribute("name");		
		list_money = td[2].getAttribute("name");		
	}
	
</script>

</head>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
#content{
	margin-top:100px;
	margin-bottom:30px;
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

#calTable img:hover{
	cursor: pointer;
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

#btnInsert, #btnDelete, #btnSubmit, #btnStats{
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

#btnInsert:hover, #btnDelete:hover, #btnStats:hover{
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

#expenseList{
	height:180px;
	padding-left:10px;
	overflow:auto;
}

#listTable td{
	width:80px;
	border-bottom:0px;
	text-align:center;
}

#listTable tr:hover{
	color:#8ba752;
	cursor:pointer;
	font-weight:bold;
}

#sumDiv{
	float:right;
	margin-left:10px;
	margin-right:10px;
	text-align:right;
}

#btnStats{
	margin-top:30px;
	margin-bottom:50px;
	margin-left:10px;
	width:243px;
	height:40px;
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
				<input type="hidden" value="${sessionScope.MEM_KEY.mem_num}" id="mem_num" />
				<input type="hidden" id="regi_days" value="${regi_days}" /> <!-- 지출이 등록된 '일'을 가져옴, 스트링배열 -->
				
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
											
								<td>
									<%=tempDay%>	
									
									<input type="hidden" value="<%=tempDay%>" id="tempDay"/>
	
									<img src="/resources/images/cal_default.jpg" id="<%=tempDay%>" value=""/>
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
								<div id="expenseList">
									<table id="listTable">
										
									</table>								
								</div>
							</td>
						</tr>
						<tr id="expenseTr3">
							<td>합계 : <div id="sumDiv"></div></td>
						</tr>
					</table>
					
					<!-- 대분류 -->
					대분류 <select id="bigCategory" >
					
					</select><br/>
					
					<!-- 소분류 -->
					소분류 <select id="smallCategory">
						
					</select><br/>
					
					<input type="text" id="price" name="price" value=""/> 원<br/>
					
					<input type="button" value="추 가" class="btn" id="btnInsert" />
					<input type="button" value="삭 제" class="btn" id="btnDelete" /> <br/>
					<input type="button" value="저 장 하 기" class="btn" id="btnSubmit" />
				</form>
				
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="span2 offset7">
				<input type="button" value="통 계 보 기" class="btn" id="btnStats" />
			</div>
		</div>
	</div>
		
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
</body>
</html>