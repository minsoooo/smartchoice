<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/member/member">
		아이디 : <input type ="text" name ="mem_id"/><br/><br/>
		이메일 : <input type ="text" name ="email1"/>@<input type ="text" name="email2"/><br/><br/>
		패스워드 : <input type = "password" name ="mem_pw"/><br/><br/>
		선호분류1 : <input type ="text" name = "mem_fav1"/><br/><br/>
		선호분류2 : <input type ="text" name = "mem_fav2"/><br/><br/>
		선호분류3 : <input type ="text" name = "mem_fav3"/><br/><br/>
		카드번호 : <input type ="text" name = "mem_cardnum"/>
		<input type ="submit" value ="회원가입하기"/>
	</form>
</body>
</html>