<!-- 
	카드추천 Result 페이지
	작성일 : 2016-07-18
	수정일 : 2016-08-03
	작성자 : 김상덕
	cardPlan Snapshot 2.0 by.santori
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>plan planResultView</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<title>Insert title here</title>
</head>
<body style="background-color:#f5f4f0; font-family: 'Noto Sans KR', sans-serif;"  >
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<div class="container" id="content">
	<div class="row">
		<div class="span12">	
			
			<c:forEach items="${SortplansmallCardlist}" var="cardResultDto" varStatus="status">
				<div style="height:30px;"></div>
				<table style="background-color:#ffffff; border-left:2px solid #8ba752; height:180px;">
					<tr style="font-size:15px; font-weight:bold;">
						<td style="width:30px; background-color:#8ba752;text-align:center; color:#ffffff;">${status.count}</td>
						<td style="width:215px; padding-left:20px;">${cardResultDto.cardName}</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2" >
							<div style="margin-left:auto;">
								<a href="#etc${cardResultDto.cardCode}" data-toggle="modal">
							  		<img src="/resources/images/card/${cardResultDto.cardImg}"  style="width:230px;height:140px;"align="right"/>
								</a>
							</div>
						</td>
						<td style="padding-left:15px;">
							<table style=" height:80px;border-top:1px solid #4e4a41; border-bottom:1px solid #4e4a41; font-size:13px; font-weight:bold;">
								<tr>
									<td style="width:80px;">총 혜택</td>
									<td style="width:80px;text-align:right;">${cardResultDto.totalMoney}원</td>
								</tr>
								<tr>
									<td style="width:80px;">연회비÷12</td>
									<td style="width:80px;text-align:right;">${cardResultDto.cardAnnual12fee}원</td>
								</tr>
							</table>
							<table style=" height:60px;border-top:1px solid #4e4a41;border-bottom:1px solid #4e4a41; font-size:13px; font-weight:bold;">
								<tr>
									<td style="width:80px;">월 혜택</td>
									<td style="width:80px;text-align:right;">${cardResultDto.monthMoney}원</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="padding-left:30px; width:200px; height:140px; overflow:auto; font-size:12px; font-weight:bold;">
								<div style="font-size:13px;">상세 할인 내역</div>
								<table style="float:left; width:80px;">
									<c:forEach items="${cardResultDto.smallName}" var="cardName">
										<tr><td>${cardName}</td></tr>
									</c:forEach>
								</table>
								<table style="float:left;">
									<c:forEach items="${cardResultDto.smallMoney}" var="cardMoney">
										<tr><td style="text-align:right;">${cardMoney}원</td></tr>
									</c:forEach>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
				
				<!-- 모달창 생성 -->
				<div class="span9"> 
					<!-- 카드정보 모달창 생성   -->
		            <div class="modal hide fade" id="etc${cardResultDto.cardCode}"><!-- 모달창마다 고유 주소생성   -->
							<div class="modal-header">
								<a href="#" class="close" data-dismiss="modal">&times;</a> 
								<label class="text-center">${cardResultDto.cardName}</label>
							</div>
							<div class="modal-body" style="text-align: center;  font-size:13px; font-weight:bold;">
								<img src="/resources/images/card/${cardResultDto.cardImg}" class="imgs img-polaroid" />
								<div style="height:20px;"></div>
								<table style="width:520px; ">
									<tr style="height:30px;border-bottom:2px solid #8ba752;">
										<td colspan="3" style="font-size:16px;">소비내역</td>
									</tr>
									<tr style="font-size:16px;height:30px;">
										<td style="width:130px; text-align:right;">총 소비</td>
										<td>${cardResultDto.usemonthMoney }원</td>
										<td style="width:120px;"></td>
									</tr>
									<tr style="border-bottom:1px solid #8ba752;height:30px;">
										<td style="width:130px; text-align:right;">기타 소비</td>
										<td>${cardResultDto.useetcMoney }원</td>
										<td style="width:120px;"></td>
									</tr>
								</table>
								
								<table style="float:left;">
									<c:forEach items="${cardResultDto.smallName}" var="cardName">
										<tr style="height:25px;">
											<td style="width:130px; text-align:right;">${cardName}</td>
										</tr>
									</c:forEach>
								</table>
								<table style="float:left;">
									<c:forEach items="${cardResultDto.planMoney}" var="planMoney">
										<tr style="height:25px;">
											<td style="width:167px; text-align:right;">${planMoney}원</td>
										</tr>
									</c:forEach>
								</table>
								<table style="float:left; color:#8ba752;">
									<c:forEach items="${cardResultDto.smallMoney}" var="cardMoney">
										<tr style="height:25px;">
											<td style="width:157px; text-align:right;">할인  - ${cardMoney}원</td>
										</tr>
									</c:forEach>
								</table>
								<table style="width:520px;" style="clear: both;">
									<tr>
										<td colspan="3" style="border-bottom:2px solid #8ba752;font-size:16px;padding-top:30px;">예상 월 혜택</td>
									</tr>
									<tr >
										<td></td>
										<td style="width:130px; text-align:right;">할인</td>
										<td style="width:120px;">${cardResultDto.totalMoney}원</td>
									</tr>
									<tr>
										<td> </td>
										<td style="width:130px; text-align:right;">연회비 ÷ 12</td>
										<td style="width:120px;">${cardResultDto.cardAnnual12fee}원</td>
									</tr>
									<tr style="font-size:16px; color:#8ba752;">
										<td ></td>
										<td style="width:130px; text-align:right;">총 ${cardResultDto.monthMoney }원 </td>
										<td style="width:220px;">의 혜택을 받으실 수 있습니다.</td>
									</tr>
								</table>
								
								<div style="height:60px;"></div>
								<div style="font-size:16px;border-bottom:2px solid #8ba752;">모든 혜택</div>
								<table style="float:left;">
									<c:forEach items="${cardResultDto.etcName}" var="etcName">
										<tr style="height:25px;">
											<td style="width:200px; text-align:right;">${etcName}</td>
										</tr>
									</c:forEach>
								</table>
								<table style="float:left;">
									<c:forEach items="${cardResultDto.etcContent}" var="etcContent">
										<tr style="height:25px;">
											<td style="width:250px; text-align:right;">${etcContent}</td>
										</tr>
									</c:forEach>
								</table>

								<div  style="clear: both;"></div>
								
							</div>
							<div class="footer modal-footer">                     
		                  <button class="btn btn-info" data-dismiss="modal">닫기</button>
		               </div>
		            </div>
	         	</div>
	         <!-- 모달창 끝 -->
		</c:forEach>
					
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
</html>