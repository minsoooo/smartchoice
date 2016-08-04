<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>이벤트</title>
</head>
<style>
#content {
	margin-top: 50px;
	margin-bottom: 50px;
}
#btncolor{
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
   width:80px;
   border: 0;
   outline: 0;
</style>
<body style="background-color: #f5f4f0">

	<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">				
				<div>
					<div>
						<h3 style="text-align: center">이벤트</h3>
					</div>
				</div>
				<div>
					<!-- body -->
					<div>
						<table class="table table-bordered">
							<tr>
								<th style="width: 60px; text-align: center">글번호</th>
								<th style="width: 300px; text-align: center">제목</th>
								<th style="width: 150px; text-align: center">작성자</th>
								<th style="width: 100px; text-align: center">작성일</th>
								<th style="width: 60px; text-align: center">조회수</th>
							</tr>
							
							<!-- 컨트롤러에서 자료를 받아서 출력한다. -->
							
							<c:forEach items="${list}" var="boardDto">
							<c:set value="${cri.keyword}" var="cri.keyword" />
								<tr>
									<td style="text-align: center">${boardDto.eboard_num}</td>
									<td>
										<a href='/board/event_board/event_readPage${pageMaker.makeQuery(pageMaker.cri.page)}
										&num=${boardDto.eboard_num}&check=mng&keyword=${cri.keyword}&searchType=${cri.searchType}'><label>${boardDto.eboard_title}</label></a></td>									
									<td style="text-align: center">${boardDto.eboard_writer}</td>
									<td style="text-align: center"><fmt:formatDate
											pattern="yyyy-MM-dd HH:mm" value="${boardDto.eboard_regdate}" /></td>
									<td style="text-align: center"><span class="badge bg-red">${boardDto.eboard_viewcnt}</span></td>
								</tr>
							</c:forEach>
						</table>
						
						<!-- 검색종류와 검색내용을 입력해서 전송한다. -->
						
						<div align="center">
							<form role="form" class="form-search" method="post" accept-charset="utf-8">
								<select style="width: 100px; height: 33px;" name="searchType" id="searchType">
									<option value="eboard_title">제목</option>
									<option value="eboard_writer">작성자</option>
									<option value="eboard_content">내용</option>
									<option value="eboard_titlecontent">제목+내용</option>
								</select> 
								<input type="text" size="30" style="height:23px;" name="keyword" id="keyword"
									value="${cri.keyword}" /> <input type="submit" class="btn"
									value="검색" id="btncolor"/> 
							</form>
						</div>
						
						<!-- 일반 공지사항 게시판과는 다르게 이미 검사되서 들어오니까 바로 버튼창을 띄워준다. -->
						<div align="right">
							<a href="/board/event_board/event_mgr_listPage" class="btn" id="btncolor">글목록</a>&nbsp;&nbsp;
							<a href="/board/event_board/event_register" class="btn" id="btncolor">글쓰기</a>							
						</div>
					</div>
					<!-- /body -->
					
					<!-- 페이징 처리  -->
					<div class="pagination pagination-large pagination-centered" >
						<div class="text-center">
							<ul>

								<c:if test="${pageMaker.prev}">
									<li><a
										href="/board/event_board/event_mgr_listPage${pageMaker.makeQuery(pageMaker.startPage - 1) }&keyword=${cri.keyword}&searchType=${cri.searchType}">&laquo;</a></li>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }" var="idx">
									<li
										<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
										<a href="/board/event_board/event_mgr_listPage${pageMaker.makeQuery(idx)}&keyword=${cri.keyword}&searchType=${cri.searchType}">${idx}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li><a
										href="/board/event_board/event_mgr_listPage${pageMaker.makeQuery(pageMaker.endPage +1) }&keyword=${cri.keyword}&searchType=${cri.searchType}">&raquo;</a></li>
								</c:if>

							</ul>
						</div>
					</div>
					<!-- /페이징처리 -->
				</div>
			</div>
		</div>
	</div>
	<script>
		var result = '${msg}';

		if (result == 'SUCCESS') {
			alert("처리가 완료되었습니다.");
		}
	</script>
</body>
</html>