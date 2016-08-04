<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<script type="text/javascript"
	src="/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
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
}   
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
					
					<!-- body , 글쓰기버튼을 눌러서 들어오는 페이지로 작성자는 가입시 입력한 id를 받아오고 그외 내용을 작성해서 POST로 Controller에 전송한다. -->
					
					<form role="form" method="post" id="frm">
						<div>
							<div style="margin-left: 80px;">
								<div>
									<label>Writer</label> <input type="text" style="width: 800px;"
										value="${sessionScope.MEM_KEY.mem_id}" name="nboard_writer"
										placeholder="${sessionScope.MEM_KEY.mem_id}"
										readonly="readonly">
								</div>
								<label>Title</label> <input type="text" name='nboard_title'
									placeholder="제목을 입력하세요." style="width: 800px;">
							</div>
							<div style="margin-left: 80px;">
								<label>Content</label>
								<textarea name="nboard_content" id="ir1" rows="15"
									placeholder="내용을 입력해주세요" style="width: 800px;"></textarea>
									
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
														bUseToolbar : true,
														// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
														bUseVerticalResizer : true,
														// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
														bUseModeChanger : true,
														fOnBeforeUnload : function() {
														}
													},													
													fCreator : "createSEditor2"
												});
											
											$("#btncolor").click(function(){
												oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
												$("#frm").submit();
											})
									});
									
									
								</script>
								
								<!-- /NAVER SMARTEDITOR SCRIPT -->	
							</div>
						</div><br/>

						<div align="center">
							<input type="button" class="btn" id="btncolor" value="전송하기" />
							&nbsp;&nbsp;&nbsp;&nbsp; 
							<a href="/board/notice_board/notice_listPage" class="btn" id="btncolor" style="width:55px;">목록가기</a>
						</div>
					</form>
					<!-- /body -->
					
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
</html>