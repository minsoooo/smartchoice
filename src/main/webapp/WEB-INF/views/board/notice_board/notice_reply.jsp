<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="span8">
				<!-- body , reply print page , DB에서 하나의 게시판 글에 담긴 댓글목록을 전부 가져와서 출력해주는 페이지 -->							
				<c:forEach items="${list}" var="replylist">	
					
					<!-- 
						 글 번호와 댓글 번호를 hideen으로 전송해서, 댓글 삭제시, 해당글번호,댓글번호와 일치하면 삭제  
						 여기서 삭제버튼은, 저장된 댓글멤버번호와 세션멤버번호가 일치할때만 삭제버튼이 보이게된다.
						 즉, 내가 작성한 댓글이 아니면 댓글 삭제 버튼이 아예 보이지않는다.
					-->
						
					<form class="form-search" method="post" action="notice_reply_remove">
						<input type='hidden' name='nreply_nboardnum' value="${boardDto.nboard_num}">
						<input type="hidden" name="nreply_num" value="${replylist.nreply_num}" />
						<div>
							<span class="icon-user"></span>${replylist.nreply_memid}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<c:set value="${replylist.nreply_memnum}" var="nreply_memnum" />
							<c:set value="${sessionScope.MEM_KEY.mem_num}" var="session_memnum" />
							<c:if test="${nreply_memnum == session_memnum}">
								<input type="submit" value="삭제" class="btn" />
							</c:if>								
							${replylist.nreply_regdate}<br />
						</div>
						<div>
							<pre>${replylist.nreply_content}</pre>
						</div>
					</form>
					
				</c:forEach>			
				<!-- /body , reply print page  -->

			</div>
		</div>
	</div>
</body>
</html>