<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script type="text/javascript" src="/resources/se/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<style>
#content {
	margin-top: 50px;
	margin-bottom: 50px;
}
#notice_modifyPage,#notice_cancel{
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

	<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">				
				<section class="content">
					<div class="row">						
						<div class="span12">							
							<div>
								<div>
									<h3 style="text-align: center">이벤트</h3>
								</div>
								
								<!-- body DB 자료를 받아서 내용을 수정하고 다시 POST방식으로 controller에 전송한다. -->

								<form role="form" id="frm" method="post">

									<input type='hidden' name='page' value="${cri.page}"> <input
										type='hidden' name='perPageNum' value="${cri.perPageNum}">

									<div style="margin-left: 80px;">
										<div>
											<label>글번호</label> <input type="text" name='eboard_num'
												value="${boardDto.eboard_num}" style="width: 800px;"
												readonly="readonly">
										</div>

										<div>
											<label>작성자</label> <input type="text" name="eboard_writer"
												value="${boardDto.eboard_writer}" style="width: 800px;"
												readonly="readonly">
										</div>
										<div>
											<label>제목</label> <input type="text" name='eboard_title'
												value="${boardDto.eboard_title}" style="width: 800px;">
										</div>
										<div>
											<label>내용</label>
											<textarea name="eboard_content" id="ir1" rows="15"
												style="width: 800px;">${boardDto.eboard_content}</textarea>
												
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
												});
											</script>
											<!-- /NAVER SMARTEDITOR SCRIPT -->	
										</div>
									</div>
									<!-- /body -->
									
									<div align="center">
										<br /> <input type="submit" id="event_modifyPage"
											value="수정하기" />&nbsp;&nbsp; <input type="submit" id="event_cancel"
											value="취소하기" />
									</div>
									
								</form>
								
								<!-- NAVER SMARTEDITOR 내용을 작성하고 전송버튼을 눌렀을 때 실행되는 SCRIPT -->
								<script>
									$(document)
											.ready(
													function() {

														var formObj = $("form[role='form']");

														console.log(formObj);

														$("#event_modifyPage").click(
															function() {
																oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD",[]);
																	$formObj.submit();
															})
													});
								</script>
							</div>							
						</div>
					</div>					
				</section>
			</div>
		</div>
	</div>
</body>
</html>