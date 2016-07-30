<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
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

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">				
				<div>
					<div>
						<h3 style="text-align: center">공지사항</h3>
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
									<td style="text-align: center">${boardDto.nboard_num}</td>
									<td>
										<a href='/board/notice_board/notice_readPage${pageMaker.makeQuery(pageMaker.cri.page)}
										&num=${boardDto.nboard_num}&keyword=${cri.keyword}&searchType=${cri.searchType}'><label>${boardDto.nboard_title}</label></a></td>									
									<td style="text-align: center">${boardDto.nboard_writer}</td>
									<td style="text-align: center"><fmt:formatDate
											pattern="yyyy-MM-dd HH:mm" value="${boardDto.nboard_regdate}" /></td>
									<td style="text-align: center"><span class="badge bg-red">${boardDto.nboard_viewcnt}</span></td>
								</tr>
							</c:forEach>
						</table>
						
						<!-- 검색종류와 검색내용을 입력해서 전송한다. -->
						
						<div align="center">
							<form role="form" class="form-search" method="post" accept-charset="utf-8">
								<select style="width: 100px; height: 33px;" name="searchType" id="searchType">
									<option value="nboard_title">제목</option>
									<option value="nboard_writer">작성자</option>
									<option value="nboard_content">내용</option>
									<option value="nboard_titlecontent">제목+내용</option>
								</select> 
								<input type="text" size="30" style="height:23px;" name="keyword" id="keyword"
									value="${cri.keyword}" /> <input type="submit" class="btn"
									value="검색" id="btncolor"/> 
							</form>
						</div>
						
						<!-- 로그인을 해야 글쓰기 버튼이 나타나게한다. -->
						<div align="right">
							<c:if test="${sessionScope.MEM_KEY eq null }">
								<a href="/board/notice_board/notice_listPage" class="btn" id="btncolor">글목록</a>
							</c:if>
							<c:if test="${sessionScope.MEM_KEY ne null }">
								<a href="/board/notice_board/notice_listPage" class="btn" id="btncolor">글목록</a>&nbsp;&nbsp;
								<a href="/board/notice_board/notice_register" class="btn" id="btncolor">글쓰기</a>								
							</c:if>
						</div>
					</div>
					<!-- /body -->
					
					<!-- 페이징 처리  -->
					<div class="pagination pagination-large pagination-centered" >
						<div class="text-center">
							<ul>

								<c:if test="${pageMaker.prev}">
									<li><a
										href="/board/notice_board/notice_listPage${pageMaker.makeQuery(pageMaker.startPage - 1) }&keyword=${cri.keyword}&searchType=${cri.searchType}">&laquo;</a></li>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }" var="idx">
									<li
										<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
										<a href="/board/notice_board/notice_listPage${pageMaker.makeQuery(idx)}&keyword=${cri.keyword}&searchType=${cri.searchType}">${idx}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li><a
										href="/board/notice_board/notice_listPage${pageMaker.makeQuery(pageMaker.endPage +1) }&keyword=${cri.keyword}&searchType=${cri.searchType}">&raquo;</a></li>
								</c:if>

							</ul>
						</div>
					</div>
					<!-- /페이징처리 -->
				</div>
			</div>
		</div>
	</div>

	<form id="jobForm">
		<input type='hidden' name="page" value=${pageMaker.cri.perPageNum}>
		<input type='hidden' name="perPageNum"
			value=${pageMaker.cri.perPageNum}>
	</form>
	<script>
		var result = '${msg}';

		if (result == 'SUCCESS') {
			alert("처리가 완료되었습니다.");
		}

		$(".pagination li a").on(
				"click",
				function(event) {

					event.preventDefault();

					var targetPage = $(this).attr("href");

					var jobForm = $("#jobForm");
					jobForm.find("[name='page']").val(targetPage);
					jobForm.attr("action",
							"/board/notice_board/notice_listPage").attr(
							"method", "get");
					jobForm.submit();
				});
	</script>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
</html>