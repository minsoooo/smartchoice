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
</style>
<body style="background-color: #f5f4f0">

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">
				<!-- general form elements -->
				<div>
					<div>
						<h3 style="text-align: center">공지사항</h3>
					</div>
				</div>
				<div>
					<div>
						<table class="table table-bordered">
							<tr>
								<th style="width: 60px; text-align: center">글번호</th>
								<th style="width: 300px; text-align: center">제목</th>
								<th style="width: 150px; text-align: center">작성자</th>
								<th style="width: 60px; text-align: center">작성일</th>
								<th style="width: 60px; text-align: center">조회수</th>
							</tr>

							<c:forEach items="${list}" var="boardDto">
								<tr>
									<td style="text-align: center">${boardDto.nboard_num}</td>
									<!-- <td>
										<a href='/board/notice_board/notice_readPage${pageMaker.makeQuery(pageMaker.cri.page)}
										&num=${boardDto.nboard_num}'><label>${boardDto.nboard_title}</label></a></td> -->
									<td><a
										href='/board/notice_board/notice_readPage?num=${boardDto.nboard_num}&keyWord=${varkeyWord}
										&keyField=${varkeyField}'>
											<label>${boardDto.nboard_title}</label>
									</a></td>
									<td style="text-align: center">${boardDto.nboard_writer}</td>
									<td style="text-align: center"><fmt:formatDate
											pattern="yyyy-MM-dd HH:mm" value="${boardDto.nboard_regdate}" /></td>
									<td style="text-align: center"><span class="badge bg-red">${boardDto.nboard_viewcnt}</span></td>
								</tr>
							</c:forEach>
						</table>
						<div align="center">
							<form role="form" class="form-search" method="post" accept-charset="utf-8">
								<select style="width: 100px; height: 30px;" name="keyField" id="keyField">
									<option value="nboard_title">제목</option>
									<option value="nboard_writer">작성자</option>
									<option value="nboard_content">내용</option>
									<option value="nboard_titlecontent">제목+내용</option>
								</select> <input type="text" size="30" name="keyWord" id="keyWord"
									value="${varkeyWord}" /> <input type="submit" class="btn"
									value="검색" /> <input type="hidden" id="varkeyField"
									value="${varkeyField}" />
							</form>
						</div>
						<div align="right">
							<!-- 로그인을 해야 글쓰기 버튼이 나타나게한다. -->
							<c:if test="${sessionScope.MEM_KEY eq null }">
								<a href="/board/notice_board/notice_listPage" class="btn">글목록</a>
							</c:if>
							<c:if test="${sessionScope.MEM_KEY ne null }">
								<a href="/board/notice_board/notice_listPage" class="btn">글목록</a>&nbsp;&nbsp;
									<a href="/board/notice_board/notice_register" class="btn">글쓰기</a>
							</c:if>
						</div>
					</div>
					<!-- /.box-body -->


					<div>

						<div class="text-center">
							<ul class="pagination">

								<c:if test="${pageMaker.prev}">
									<li><a
										href="/board/notice_board/notice_listPage${pageMaker.makeQuery(pageMaker.startPage - 1) }">&laquo;</a></li>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }" var="idx">
									<li
										<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
										<a href="/board/notice_board/notice_listPage${pageMaker.makeQuery(idx)}">${idx}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li><a
										href="/board/notice_board/notice_listPage${pageMaker.makeQuery(pageMaker.endPage +1) }">&raquo;</a></li>
								</c:if>

							</ul>
						</div>


						<div class="text-center">
							<ul class="pagination">

								<c:if test="${pageMaker.prev}">
									<li><a href="${pageMaker.startPage - 1}">&laquo;</a></li>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }"
									end="${pageMaker.endPage }" var="idx">
									<li
										<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
										<a href="${idx}">${idx}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li><a href="${pageMaker.endPage +1}">&raquo;</a></li>
								</c:if>

							</ul>
						</div>


					</div>
					<!-- /.box-footer-->
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