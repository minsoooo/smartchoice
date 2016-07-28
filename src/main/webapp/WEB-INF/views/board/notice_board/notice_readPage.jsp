<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<style>
#content {
	margin-top: 50px;
	margin-bottom: 50px;
}
#notice_listPage,#notice_modifyPage,#notice_remove,#notice_replybtn{
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
}   
</style>
<body style="background-color: #f5f4f0">

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">

				<!-- Main content -->
				<section class="content">
					<div class="row">
						<!-- left column -->
						<div class="span12">
							<!-- general form elements -->
							<div>
								<div>
									<h3 style="text-align: center">공지사항</h3>
								</div>
								<!-- /.box-header -->


								<form role="form" method="post" >
									<input type='hidden' name='num' value="${boardDto.nboard_num}">
									<input type='hidden' name='page' value="${cri.page}"> <input
										type='hidden' name='perPageNum' value="${cri.perPageNum}">
								</form>

								<div style="margin-left: 80px;">
									<div>
										<label>작성자</label> <input type="text" name="writer"
											style="width: 800px;" value="${boardDto.nboard_writer}"
											readonly="readonly">
									</div>
									<div>
										<label>제목</label> <input type="text" name='title'
											style="width: 800px;" value="${boardDto.nboard_title}"
											readonly="readonly">
									</div>
									<div>
										<label>내용</label>
										<textarea name="nboard_content" id="ir1" rows="15" style="width: 800px;"
											readonly="readonly">${boardDto.nboard_content}
										</textarea>
									</div>
								</div>
								<!-- /.box-body -->

								<!-- submit  -->
								<div align="center">

									<!-- 로그인을 안했으면 목록가기, 로그인을 하고나면 수정,삭제를 위해 글쓸때 저장한 아이디와 로그인한 아이디가 같을때만 그 외 버튼이 생성되게함 -->
									<form role="form" class="form-search" method="post"
										accept-charset="utf-8">																

										<c:if test="${sessionScope.MEM_KEY eq null }">
											<button type="submit" class="btn" id="notice_listPage">
												목록가기 <input type="hidden" name="keyword" value="${cri.keyword}" />
												<input type="hidden" name="searchType" value="${cri.searchType}" />
											</button>																					
										</c:if>
										<c:if
											test="${boardDto.nboard_writer == sessionScope.MEM_KEY.mem_id}">
											<button type="submit" class="btn" id="notice_modifyPage">
												수정하기 <input type="hidden" name="num"
													value="${boardDto.nboard_num}" />
											</button>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<button type="submit" class="btn" id="notice_listPage">
												목록가기<input type="hidden" name="keyword" value="${cri.keyword}" />
												<input type="hidden" name="searchType" value="${cri.searchType}" />
											</button>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<button type="submit" class="btn" id="notice_remove">
												삭제하기 <input type="hidden" name="num"
													value="${boardDto.nboard_num}" />
											</button>											
										</c:if>
									</form>
								</div>
								<br /> <br /> <br />
								<!-- /submit -->

								<!-- reply insert page -->
								<div style="margin-left: 80px;">
									<c:choose>
										<c:when test="${sessionScope.MEM_KEY eq null}">
											댓글을 입력하려면 로그인이 필요합니다. <br />
											<br />
											<br />
										</c:when>

										<c:otherwise>
											<form class="form-search" method="post" action="notice_reply"
												accept-charset="utf-8">
												<input type='hidden' name='nreply_nboardnum'
													value="${boardDto.nboard_num}"> <input
													type='hidden' name='nreply_memnum'
													value="${sessionScope.MEM_KEY.mem_num}"> <input
													type="text" placeholder="${sessionScope.MEM_KEY.mem_id}"
													name="nreply_memid" readonly="readonly" required="required"
													value="${sessionScope.MEM_KEY.mem_id}"
													style="width: 800px;" /><br />
												<textarea rows="3" name="nreply_content"
													style="width: 745px;" placeholder="댓글을 입력하세요"
													required="required"></textarea>
												<input type="submit" value="작성" class="btn" id="notice_replybtn"
													style="width: 50px; height: 70px" />
											</form>

										</c:otherwise>
									</c:choose>


									<!-- /reply insert page -->
									<jsp:include page="notice_reply.jsp"></jsp:include>
								</div>


							</div>
							<!-- /.box -->
						</div>
						<!--/.col (left) -->

					</div>
					<!-- /.row -->
				</section>
				<!-- /.content -->

			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	<script>
		$(document)
				.ready(
						function() {

							var formObj = $("form[role='form']");

							console.log(formObj);

							$("#notice_modifyPage")
									.on(
											"click",
											function() {
												formObj
														.attr("action",
																"/board/notice_board/notice_modifyPage");
												formObj.attr("method", "get");
												formObj.submit();
											});

							$("#notice_remove")
									.on(
											"click",
											function() {
												formObj
														.attr("action",
																"/board/notice_board/notice_remove");
												formObj.attr("method", "get");
												formObj.submit();
											});

							$("#notice_listPage")
									.on(
											"click",
											function() {
												formObj
														.attr("action",
																"/board/notice_board/notice_listPage");
												formObj.attr("method", "post");
												formObj.attr("accept-charset", "utf-8");
												formObj.submit();
											});
						});
	</script>
</body>
</html>