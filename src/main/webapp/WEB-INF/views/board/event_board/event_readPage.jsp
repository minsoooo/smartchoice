<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>이벤트</title>
<script type="text/javascript"
	src="/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<style>
#content {
	margin-top: 50px;
	margin-bottom: 50px;
}
#event_listPage,#event_mgr_listPage,#event_modifyPage,#event_remove,#event_replybtn{
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
#font_main,#font_writer,#font_title,#font_content{		
	font-weight:bold;	
	color:#8ba752;	
}
   
</style>
<body style="background-color: #f5f4f0">

	<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">				
				<section class="content">
					<div class="row">					
						<div class="span12">						
							<div>
								<div>
									<h3 id="font_main" style="text-align: center">Event Board Read</h3>
								</div>
								
								<!-- body , cotroller에서 작성한 글 번호에 따른 글 내용을 전부 받아와서 출력한다. -->

								<form role="form" method="post" >
									<input type='hidden' name='num' value="${boardDto.eboard_num}">
									<input type='hidden' name='page' value="${cri.page}"> <input
										type='hidden' name='perPageNum' value="${cri.perPageNum}">
								</form>

								<div style="margin-left: 80px;">
									<div>
										<label id="font_writer" >Writer</label> <input type="text" name="writer"
											style="width: 800px;" value="${boardDto.eboard_writer}"
											readonly="readonly">
									</div><br/>
									<div>
										<label id="font_title" >Title</label> <input type="text" name='title'
											style="width: 800px;" value="${boardDto.eboard_title}"
											readonly="readonly">
									</div><br/>
									
									<!-- 기존의 textarea는 내용을 출력할 때 태그를 전부 출력하기때문에, 네이버스마트에디터를 사용해서,
										  기존의 textarea와 비슷한 느낌의 이미지로 변경했다. -->
									<div>
										<label id="font_content" >Content</label>									
										<textarea name="eboard_content" id="ir1" rows="20" style="width: 810px;">${boardDto.eboard_content}</textarea>
											
										<!-- NAVER SMARTEDITOR SCRIPT -->	
										<script type="text/javascript">
											var oEditors = [];
		
											$(function() {
												nhn.husky.EZCreator
														.createInIFrame({
															oAppRef : oEditors,
															elPlaceHolder : "ir1",
															//SmartEditor2Skin.html 파일이 존재하는 경로
															sSkinURI : "/resources/se/SmartEditor2Skin.html",
															htParams : {
																// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
																bUseToolbar : false,
																// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
																bUseVerticalResizer : true,
																// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
																bUseModeChanger : false,
																fOnBeforeUnload : function() {
		
																}
															},													
															fCreator : "createSEditor2"
														});												
													
											});
											
											
										</script>
										
										<!-- /NAVER SMARTEDITOR SCRIPT -->	
									</div><br/>
								</div>
								<!-- /body -->

								<!-- submit  -->
								<div align="center">
									<form role="form" class="form-search" method="post"
										accept-charset="utf-8">										
										<!-- 버튼은 글 목록에서 받아온 검색종류와 검색어를 받아서 다시 Controller 로 돌아갈때 그 값을 가져가서 재검색하게 해준다. -->																
										<!-- 일반 사용자라면 목록가기 버튼만 보인다 -->
										<!-- 본관리자일경우에는 목록가기 수정하기 삭제하기가 나타난다. -->										
										<c:if test="${sessionScope.MEM_KEY ne null }">
											<button type="submit" class="btn" id="event_listPage">
												목록가기 <input type="hidden" name="keyword" value="${cri.keyword}" />
												<input type="hidden" name="searchType" value="${cri.searchType}" />
											</button>																					
										</c:if>
										<c:if test="${sessionScope.MNG_KEY ne null }">											
												<button type="submit" class="btn" id="event_modifyPage">
													수정하기 <input type="hidden" name="num"
														value="${boardDto.eboard_num}" />
												</button>
												<button type="submit" class="btn" id="event_mgr_listPage">
													목록가기 <input type="hidden" name="keyword" value="${cri.keyword}" />
													<input type="hidden" name="searchType" value="${cri.searchType}" />
												</button>
												<button type="submit" class="btn" id="event_remove">
													삭제하기 <input type="hidden" name="num"
														value="${boardDto.eboard_num}" />
												</button>											
											
										</c:if>
									</form>
								</div>
								<br /> <br /> <br />
								<!-- /submit -->
								
								<!-- 댓글 출력 페이지 include -->
								<div style="margin-left: 80px;">									
									<jsp:include page="event_reply.jsp"></jsp:include>
								</div>
							</div>							
						</div>					
					</div>					
				</section>
			</div>
		</div>
	</div>	
	<script>
		$(document)
				.ready(
						function() {

							var formObj = $("form[role='form']");

							console.log(formObj);

							$("#event_modifyPage")
									.on(
											"click",
											function() {
												formObj
														.attr("action",
																"/board/event_board/event_modifyPage");
												formObj.attr("method", "get");
												formObj.submit();
											});

							$("#event_remove")
									.on(
											"click",
											function() {
												formObj
														.attr("action",
																"/board/event_board/event_remove");
												formObj.attr("method", "get");
												formObj.submit();
											});
							
							$("#event_listPage")
							.on(
									"click",
									function() {
										formObj
												.attr("action",
														"/board/event_board/event_listPage");
										formObj.attr("method", "get");
										formObj.submit();
									});

							$("#event_mgr_listPage")
									.on(
											"click",
											function() {
												formObj
														.attr("action",
																"/board/event_board/event_mgr_listPage");
												formObj.attr("method", "post");
												formObj.attr("accept-charset", "utf-8");
												formObj.submit();
											});
							});
	</script>
</body>
</html>