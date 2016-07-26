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
				<!-- reply print page  -->							
				<c:forEach items="${list}" var="replylist">			
					<form class="form-search" method="post"
						action="notice_reply_modify">
						<input type='hidden' name='num' value="${boardDto.nboard_num}">
						<input type="hidden" name="nreply_num"
							value="${replylist.nreply_num}" />
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
				<!-- /reply print page  -->

			</div>
		</div>
	</div>
</body>
</html>