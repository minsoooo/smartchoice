<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>update_choose</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	function fnUpdateBasic(){
		window.close();
		opener.document.location.href ="/member/update_basic";
	}
	
	function fnUpdateAdd(){
		window.close();
		opener.document.location.href ="/member/update_add";
	}
</script>
<style>
#content{
	margin-top:60px;
	margin-left:45px;
	
}

#btnBasic{
	width : 254px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: bold;
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
	background-color:#548eb3;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
	}
	
#btnBasic:hover{
	background-color:#669aba;
	border: 0;
	outline: 0;
}

#btnAdd{
	width : 254px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: bold;
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
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
	}
	
#btnAdd:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

</style>
</head>
<body>
	<div id ="content">
		<input type ="button" value ="기본정보수정" id ="btnBasic" onclick="fnUpdateBasic()"/>
		<input type ="button" value ="추가정보수정" id ="btnAdd" onclick ="fnUpdateAdd()"/>
	</div>

<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>