<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" session="true"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
로그인 확인 ${sessionScope.MEM_KEY.mem_id }
<P>  The time on the server is ${serverTime}. </P>

</body>
</html>
