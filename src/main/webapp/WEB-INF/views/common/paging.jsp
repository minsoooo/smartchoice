<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#pages a{
		font-size: 20px;
		color:#5c554b;
		margin-left:5px;
		margin-right:5px;
	}
		#pages a:hover{
		color:#8ba752;
	}
</style>
<div id="pages">
    <a href="javascript:goPage(${param.firstPageNo})" class="first">&lt;&lt;&nbsp;&nbsp;&nbsp;</a>
    <a href="javascript:goPage(${param.prevPageNo})" class="prev">&lt;</a>
    <span>
        <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
            <c:choose>
                <c:when test="${i eq param.pageNo}"><a href="javascript:goPage(${i})" id="choice" style ="color:#8ba752">${i}</a></c:when>
                <c:otherwise><a href="javascript:goPage(${i})">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <a href="javascript:goPage(${param.nextPageNo})" class="next">&gt;&nbsp;&nbsp;&nbsp;</a>
    <a href="javascript:goPage(${param.finalPageNo})" class="last">&gt;&gt;</a>
</div>