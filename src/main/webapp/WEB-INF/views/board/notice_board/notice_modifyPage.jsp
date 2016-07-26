<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script type="text/javascript"
	src="/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
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

				<!-- Main content -->
				<section class="content">
					<div class="row">
						<!-- left column -->
						<div class="span12">
							<!-- general form elements -->
							<div>
								<div>
									<h3 style="text-align:center">공지사항</h3>
								</div>
								<!-- /.box-header -->

								<form role="form" action="notice_modifyPage" method="post">

									<input type='hidden' name='page' value="${cri.page}"> 
									<input type='hidden' name='perPageNum' value="${cri.perPageNum}">

									<div style="margin-left: 80px;">
										<div>
											<label>글번호</label> <input type="text" name='nboard_num' value="${boardDto.nboard_num}" 
										style="width: 800px;" readonly="readonly">
										</div>

										<div>
											<label>작성자</label> <input type="text" name="nboard_writer" value="${boardDto.nboard_writer}"
											style="width: 800px;">
										</div>
										<div>
											<label>제목</label> 
											<input type="text" name='nboard_title' value="${boardDto.nboard_title}" style="width: 800px;">
										</div>
										<div>
											<label>내용</label>
											<textarea name="nboard_content" id="ir1" rows="15"
											placeholder="내용을 입력해주세요" style="width: 800px;">${boardDto.nboard_content}</textarea>
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
										<button type="submit" class="btn" id="#notice_modifyPage">저장하기</button>&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="submit" class="btn" id="#notice_listPage">취소하기</button>
									</div>
								</form>
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

</body>
<script>
	$(document).ready(function() {

		var formObj = $("form[role='form']");

		console.log(formObj);

		$("#notice_modifyPage").on("click", function() {
			formObj.submit();			
		});

		$("#notice_modifyPage").on("click", function() {
			self.location = "/board/notice_board/notice_listPage";
		});

	});
</script>
</html>