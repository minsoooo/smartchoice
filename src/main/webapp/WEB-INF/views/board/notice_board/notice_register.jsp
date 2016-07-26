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
					<!-- /.box-header -->

					<!-- box-body -->
					<form role="form" method="post" id="frm">
						<div>
							<div style="margin-left: 80px;">
								<div>
									<label>작성자</label> <input type="text" style="width: 800px;"
										value="${sessionScope.MEM_KEY.mem_id}" name="nboard_writer"
										placeholder="${sessionScope.MEM_KEY.mem_id}"
										readonly="readonly">
								</div>
								<label>제목</label> <input type="text" name='nboard_title'
									placeholder="제목을 입력하세요." style="width: 800px;">
							</div>
							<div style="margin-left: 80px;">
								<label>내용</label>
								<textarea name="nboard_content" id="ir1" rows="15"
									placeholder="내용을 입력해주세요" style="width: 800px;"></textarea>
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
										
										
									       
											
											$("#savebutton").click(function(){
												oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
												$("#frm").submit();
											})
									});
									
									
								</script>
							</div>
						</div>
						<!-- /.box-body -->

						<div align="center">
							<input type="button" class="btn" id="savebutton" value="전송하기" />
							&nbsp;&nbsp;&nbsp;&nbsp; <a
								href="/board/notice_board/notice_listPage" class="btn">목록가기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

</body>
</html>