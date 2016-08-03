<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>

<script>
$(function () {	
		var getData1, getData2 ;
		var json1=[], json2=[], values =[];
		
		$.ajax({
		    url     :  "/manager/manager_getStatsComp",
		    dataType    :   "json",
		    type        :   "post",
		    success     :   function(data){
		    	
		    	for(var i=0;i<data.length;i++){
		    		for(var j = 0 ; j < data[i].value.length ; j++){
						values.push(
							data[i].value[j]		
						)
					}
		    		getData1={'name':data[i].comp_name,'data':values};
		    		json1.push(
		    		          getData1
		    		           )
		    		values =[];          
		    	}
		    }
		});
		
		$.ajax({
		    url     :  "/manager/manager_getStatsCate",
		    dataType    :   "json",
		    type        :   "post",
		    success     :   function(data){
		    	for(var i=0;i<data.length;i++){

		    		json2.push(
		    		         data[i].big_name
		    		           )        
		    	}
		    }
		});
		
		
		$("#btn1").click(function(){
			 $('#chart1').highcharts({
			        title: {
			            text: '카드사별 총 지출량',
			            x: -20, //center
			            style :{
				        	color: '#5c554b',
				        	fontWeight: 'bold',
				        	fontSize: '30px'
				        }
			        },
			        subtitle: {
			            text: '직전 달 기준 산출값',
			            x: -20
			        },
			        xAxis: {
			            categories: json2
			        },
			        yAxis: {
			            title: {
			                text: '지출량 (원)'
			            },
			            plotLines: [{
			                value: 0,
			                width: 1,
			                color: '#808080'
			            }]
			        },
			        tooltip: {
			            valueSuffix: '원'
			        },
			        legend: {
			            layout: 'vertical',
			            align: 'right',
			            verticalAlign: 'middle',
			            borderWidth: 0
			        },
			        series: json1
			    });
			
		});
});
</script>
</head>
<style>
	#chart1{
		vertical-align: center;
		height:350px;
		width:700px;
		margin-top:30px;
		margin-left:140px;
		background-color : #fff;
	}
	
	#buttonDiv{
		height:200px;
		width:400px;
		margin-top:30px;
		margin-bottom:50px;
		margin-left:280px;
		background-color : #fff;
	}
	
	#font1{
		margin-left: 240px;
		margin-top: 160px;
		color:#4e4a41;
		font-size: 12px;
		font-weight: bold;	
	}	
	#font4{
		margin-left: 70px;
		margin-top: 20px;
		margin-bottom:20px;
		color:#4e4a41;
		font-size: 14px;
		font-weight: bold;
		
	}
	#imtFont{
		color:#FF6C6C;
		font-weight: bold;
		font-size: 17px;
	}
#titleDiv{
	margin-top:40px;
}	
	
#titleHr{
	border: 1px solid #d4d1ca;
}
#titleFont{
	color :#97b162;
	font-size: 25px;
	font-weight:bold;
}

#butDiv{
	margin-top: 30px;
	margin-left: 140px;
}

#btn1 {
	width : 120px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-bottom: 0;
	font-size: 12px;
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
#btn1:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}	
	
</style>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">카드사별 지출내역</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span12" style ="border:1px solid #d4d1ca" 	id="chart1">
				<div id ="font1"><font >버튼을 클릭하시면 차트가 나타납니다.</font></div>
			</div>
		</div>	
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span4" style ="border:1px solid #d4d1ca" id="buttonDiv">
				<div id="font4">
					<font>
						통계자료를 확인하시려면 버튼을 클릭하세요<br/>
						그래프가 제대로 작동하지 않으면<br/><br/>
					</font>
					<font id ="imtFont">
						5~10초후 다시 버튼을 클릭해 주세요!
					</font>
				</div>
				<div id ="butDiv">
					<input type ="button" id ="btn1" value ="카드사별 총 지출"/>
				</div>
			</div>
		</div>
	</div>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
</body>
</html>