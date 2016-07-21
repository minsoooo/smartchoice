<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>카드등록</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
</head>
<body>
<h1>카드등록</h1>
<hr/>
<h3>1단계 카드 기본정보</h3>
<select>
	<c:forEach items="${companies }" var="CardDto">
	<option>${CardDto.comp_name }</option>
	</c:forEach>
</select><br/><hr/>

<h3>2단계 카드 혜택정보</h3><br/>
<h5>대분류</h5>
<select>
	<c:forEach items="${bigcategories }" var="bigC">
		<option>${bigC.big_name }</option>
	</c:forEach>
</select>
<h5>소분류</h5>
<select>
	<c:forEach items="${smallcategories }" var="smallC">
		<option>${smallC.small_name }</option>
	</c:forEach>
</select>

<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
