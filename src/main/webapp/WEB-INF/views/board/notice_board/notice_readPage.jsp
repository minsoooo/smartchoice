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
				<section class="content">
					<div class="row">					
						<div class="span12">						
							<div>
								<div>
									<h3 style="text-align: center">공지사항</h3>
								</div>
								
								<!-- body , cotroller에서 작성한 글 번호에 따른 글 내용을 전부 받아와서 출력한다. -->

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
								<!-- /body -->

								<!-- submit  -->
								<div align="center">

									<!-- 로그인을 안했으면 목록가기, 로그인을 하고나면 수정,삭제를 위해 글쓸때 저장한 아이디와 로그인한 아이디가 같을때만 그 외 버튼이 생성되게함 -->
									<form role="form" class="form-search" method="post"
										accept-charset="utf-8">
										
										<!-- 버튼은 글 목록에서 받아온 검색종류와 검색어를 받아서 다시 Controller 로 돌아갈때 그 값을 가져가서 재검색하게 해준다. -->																

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

								<!-- 댓글 입력 페이지, 댓글을 입력받아서 POST로 전송하면 Controller에서 받아서 입력한다. 
									 로그인이 되어있지않으면 세션이 없기때문에 로그인이 필요하다는 메세지가 출력되고, 로그인이 되어있다면 댓글을 작성 할 수 있다.
									 로그인이 되어있을 시 가입때 입력한 id가 출력되고, 댓글은 내용(content)만 입력하면되게 처리한다.
								-->
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


									<!-- /댓글 입력 페이지 -->
									<!-- 댓글 출력 페이지 include -->
									<jsp:include page="notice_reply.jsp"></jsp:include>
								</div>


							</div>							
						</div>					
					</div>					
				</section>
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