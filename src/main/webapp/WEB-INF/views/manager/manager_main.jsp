<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 메인페이지</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<a href="/manager/manager_memberList">회원정보리스트</a><br/><br/>
<a href="/manager/manager_cardList">카드정보리스트</a><br/><br/>
<a href="/manager/manager_dataList">데이터정보리스트</a><br/><br/>
</body>
</html>