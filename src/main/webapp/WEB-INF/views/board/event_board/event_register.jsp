<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
</head>
<script type="text/javascript"
	src="/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
<script>
	$(document).ready(
		function(){
			//달을 선택하면 그달의 날짜를 만든다 && 이벤트 시작일 
			$("#start_month").change(
				function(){
					$("#start_day").empty();
					var selectMonth =$("#start_month option:selected").attr("value");
					$.get("/member/maxday",{"selectMonth":selectMonth}).done(
						function(data){
							for(var i =1; i<=data; i++){
								var insertTag = "<option>"+i+"</option>";
								$(insertTag).appendTo("#start_day")
							}	
						}		
					);
				}		
			);
			
			//달을 선택하면 그달의 날짜를 만든다 && 이벤트 종료일 
			
			$("#end_month").change(
				function(){
					$("#end_day").empty();
					var selectMonth =$("#end_month option:selected").attr("value");
					$.get("/member/maxday",{"selectMonth":selectMonth}).done(
						function(data){
							for(var i =1; i<=data; i++){
								var insertTag = "<option>"+i+"</option>";
								$(insertTag).appendTo("#end_day")
							}	
						}		
					);
				}		
			);
		}	
	);
</script>	
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
#year, #month, #day{
	width:99px;
} 
</style>
<body style="background-color: #f5f4f0">
<%
	Calendar cal = Calendar.getInstance();
	int now_year = cal.get(Calendar.YEAR);
	request.setAttribute("now_year",now_year);
%>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div class="container" id="content">
		<div class="row">
			<div class="span12">				
				<div>
					<div>
						<h3 style="text-align: center">이벤트</h3>
					</div>
					
					<!-- 
						body , 글쓰기버튼을 눌러서 들어오는 페이지로 작성자는 가입시 입력한 id를 받아오고 그외 내용을 작성해서 POST로 Controller에 전송한다.
						기존 글과 다르게, 이벤트 시작일과 종료일이 존재하며 여기서 전송한 뒤 Controller에서 다시 작업한다.
					-->
					
					<form role="form" method="post" id="frm">
						<div>
							<div style="margin-left: 80px;">
								<div>
									<label>Writer</label> <input type="text" style="width: 800px;"
										value="${sessionScope.MNG_KEY.mng_id}" name="eboard_writer"
										placeholder="${sessionScope.MNG_KEY.mng_id}"
										readonly="readonly">
								</div>
								<label>Title</label> <input type="text" name='eboard_title'
									placeholder="제목을 입력하세요." style="width: 800px;">
								<div>
									<select name="start_year" id ="start_year">
										<option>이벤트 시작일</option>
										<c:forEach begin="0" end="99" step="1" varStatus="i">
											 <option  value ="${now_year -i.index }">${now_year -i.index }</option>
										</c:forEach>
									</select>
									<select name ="start_month" id ="start_month">
										<option></option>
										<c:forEach begin="0" end ="11" step="1" varStatus="i">
											<option  value ="${12 - i.index }">${12 - i.index }</option>
										</c:forEach>
									</select>
									<select name ="start_day" id = "start_day">
										
									</select>
								</div>
								<div>
									<select name="end_year" id ="end_year">
										<option>이벤트 종료일</option>
										<c:forEach begin="0" end="99" step="1" varStatus="i">
											 <option  value ="${now_year -i.index }">${now_year -i.index }</option>
										</c:forEach>
									</select>
									<select name ="end_month" id ="end_month">
										<option></option>
										<c:forEach begin="0" end ="11" step="1" varStatus="i">
											<option  value ="${12 - i.index }">${12 - i.index }</option>
										</c:forEach>
									</select>
									<select name ="end_day" id = "end_day">										
									</select>
								</div>	
							</div>
							<div style="margin-left: 80px;">
								<label>Content</label>
								<textarea name="eboard_content" id="ir1" rows="15"
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
							<a href="/board/event_board/event_mgr_listPage" class="btn" id="btncolor" style="width:55px;">목록가기</a>
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