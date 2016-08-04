<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(document).ready(
		function(){
			var notis ="";
			var notiNums ="";
			if($("#regiCheck").attr("value") == "true"){
				alert("회원가입을 축하합니다.");

			}
			//총 회원수 가져오는 AJAX
			$.get("/home/memberCount").done(
					function(data){
						var font = "<font id ='cnt'>"+data+"</font>";
						$(font).appendTo("#memCnt")
						$("#cnt").css("font-size","40px")
						.css("font-weight","bold")
						.css("color","#669aba");
				});
			//공지사항 최신글 가져오기 
			$.get("/home/getNotice").done(function(data){
				for(var i =0; i < data.length ; i ++){
					notis += data[i].title+"/";
					notiNums += data[i].num +"/";
				}
				$("#noti1").text(notis.split("/")[0])
				$("#noti2").text(notis.split("/")[1])
				
				var notiUrl1 = "/board/notice_board/notice_readPage?num="+notiNums.split("/")[0];
				var notiUrl2 = "/board/notice_board/notice_readPage?num="+notiNums.split("/")[1];
				$("#noti1").attr("href",notiUrl1);
				$("#noti2").attr("href",notiUrl2);
			});
			
			/*
			// 이벤트 최신글 가져오기 
			$.get("/home/getEvent").done(function(data){
				for(var i =0; i < data.length ; i ++){
					notis += data[i].title+"/";
					notiNums += data[i].num +"/";
				}
				$("#even1").text(notis.split("/")[0])
				$("#even2").text(notis.split("/")[1])
				
				var notiUrl1 = "/board/event_board/event_readPage?num="+notiNums.split("/")[0];
				var notiUrl2 = "/board/event_board/event_readPage?num="+notiNums.split("/")[1];
				$("#even1").attr("href",notiUrl1);
				$("#even2").attr("href",notiUrl2);
				
			});
			*/	
		});
</script>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#content{
	margin-top:100px;
	margin-bottom:50px;
}

#content p {
	font-family: 'Noto Sans KR', sans-serif;
	color: #5c554b;
}

#content a {
	margin-left:400px;
	font-family: 'Noto Sans KR', sans-serif;
}
#conTitle{
	font-size: 50px;
	font-weight: bold;
}

#card{
	font-size: 30px;
	font-weight: bold;
}

#conText{
	font-size:20px;
	margin-left: 50px;
}

#notiTitle, #eventTitle{
	margin-left:50px;
	font-size: 30px; 
	font-weight: bold; 
	color: #5c554b;
	font-family: 'Noto Sans KR', sans-serif;
}

#boardDiv{
	padding-top:20px;
	margin-left: 50px; 
	margin-top: 20px;  
	background-color: #fff;
	border-top:2px solid #d4d1ca;
	width:300px;
}

#plus{
	width: 35px; 
	height: 35px; 
	margin-left: 170px;
}

#noti1, #noti2, #even1, #even2{
	color : #5c554b;
	font-size: 15px;
}

#boardDiv li{
	margin-left: 30px;
	margin-bottom:15px; 
	color :#5c554b;
}
#notiImg, #eventImg{
	margin-left :180px;
	width:60px;
}

</style>

<body style="background-color:#f5f4f0">

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<span id ="regiCheck" value ="${regiCheck }"></span>
	<div class="container" id="content">
		<div class="row">
			<div class="span7 offset1">
				<p id ="conTitle">$mart Choice!!</p><br/><br/>
				<p id ="conText">당신의 주머니속의 잠들어 있는 <font id ="card">카드</font>를 깨우세요</p><br/> 
				<p id ="conText">현재 <span id ="memCnt"></span>명의 회원과 함께하고있습니다.</p>
				<p><a href="/member/member">Let's Join Us</a></p>	
			</div>
		</div>
	</div>
	<div style ="background-color:#fff">
		<div class ="container">
			<div class ="row" >
				<div class ="span12" style ="margin-bottom:20px; margin-left:100px">
						<div class="span5"  id ="boardDiv" >
							<div id = "notiTitle">
								<font>Board</font>
								<a href="/board/notice_board/notice_listPage"> 
								<img id ="plus" src="/resources/images/plus.png"/>
								</a>
							</div>
							<ul style="margin-top: 30px;" >
								<li><a id="noti1" href="">최신글1</a></li>
								<li><a id="noti2" href="">최신글2</a></li>
							</ul>
							<img id ="notiImg"src="/resources/images/notice.jpg">

						</div>
						<div class="span5" id ="boardDiv">
							<div id = "eventTitle">
								<font>Event</font>
								<a href="/board/event_board/event_listPage"> 
								<img id ="plus" src="/resources/images/plus.png"/>
								</a>
							</div>
								
							<ul style="margin-top: 30px;">
								<li><a id="even1" href="">이벤트1</a></li>
								<li><a id="even2" href="">이벤트2</a></li>
							</ul>
							<img id ="eventImg" src="/resources/images/news.jpg" >
						</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>