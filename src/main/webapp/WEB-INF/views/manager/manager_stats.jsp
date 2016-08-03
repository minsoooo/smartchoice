<%@ page contentType="text/html; charset=utf-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>

<script>
$(function () {	
		var getData1, getData2, getData3 ;
		var json1=[], json2=[], json3=[], values =[];
		
		$.ajax({
		    url     :  "/manager/manager_getStats1",
		    dataType    :   "json",
		    type        :   "post",
		    success     :   function(data){
		    	
		    	
		    	for(var i=0;i<data.length;i++){
		    		getData1={'name':data[i].big_name,'y':parseFloat(data[i].value)};
		    		json1.push(
		    		          getData1
		    		           )
		    	}
		    }
		});
		
		$.ajax({
		    url     :  "/manager/manager_getStats2",
		    dataType    :   "json",
		    type        :   "post",
		    success     :   function(data){

		    	for(var i=0;i<data.length;i++){
		    		getData2= parseFloat(data[i].value);
		    		json2.push(
		    		          getData2
		    		           )
		    	}


		    }
			
		});
		
		$.ajax({
		    url     :  "/manager/manager_getStats3",
		    dataType    :   "json",
		    type        :   "post",
		    success     :   function(data){

		    	for(var i=0;i<data.length;i++){
					for(var j = 0 ; j < data[i].value.length ; j++){
						values.push(
							parseInt(data[i].value[j])		
						)
					}
		    		getData3={'name':data[i].big_name,'data':values, 'pointPlacement' : 'on'};
		    		json3.push(
		    		          getData3
		    		           )
		    		values =[];
		    	}
		    }
			
		});
		
		
		$("#btn1").click(function(){
			$('#chart1').highcharts({
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie'
			    },
			    title: {
			        text: '관심사별 회원 현황',
			        style :{
			        	color: '#5c554b',
			        	fontWeight: 'bold',
			        	fontSize: '25px'
			        }
			    },
			    tooltip: {
			        pointFormat: '{series.name}: <b>{point.y}명</b>'
			    },
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                style: {
			                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                }
			            }
			        }
			    },
			    series: [{
			        name: '가입자 수',
			        colorByPoint: true,
			        data: json1
			    }]
			});
		});
	
	$("#btn2").click(function(){
		$('#chart2').highcharts({
		        title:{
		        	text:'연령별 가입자 수',
		            style :{
			        	color: '#5c554b',
			        	fontWeight: 'bold',
			        	fontSize: '25px'
			        }
		        },
				chart: {
		            type: 'column'
		        },
		        xAxis: {
		            categories: ['10대', '20대', '30대', '40대', '50대', '60대이상']
		        },
		        yAxis:{
		        	title:{
		        		text:'가입자 수(명)'
		        	}
		        },
		        plotOptions: {
		            series: {
		                allowPointSelect: true
		            }
		        },
		        series: [{
		            data: json2,
		            name: '가입자 수'
		        }]
		    });
	});
	
	$("#btn3").click(function(){
		 $('#chart3').highcharts({

		        chart: {
		            polar: true,
		            type: 'line'
		        },

		        title: {
		            text: '관심사&연령',
		            style :{
			        	color: '#5c554b',
			        	fontWeight: 'bold',
			        	fontSize: '25px'
			        },
		            x: -30
		        },

		        pane: {
		            size: '80%'
		        },

		        xAxis: {
		            categories: ['10대', '20대', '30대', '40대',
		                    '50대', '60대'],
		            tickmarkPlacement: 'on',
		            lineWidth: 0
		        },

		        yAxis: {
		            gridLineInterpolation: 'polygon',
		            lineWidth: 0,
		            min: 0
		        },


		        legend: {
		            align: 'right',
		            verticalAlign: 'top',
		            y: 70,
		            layout: 'vertical'
		        },

		        series: json3

		    });
	});	
	
	$("#btn4").click(function(){
		location.href ="/manager/manager_statsComp"		
	});

});
</script>
</head>
<style>
	#chart1{
		vertical-align: center;
		height:350px;
		width:500px;
		margin-top:30px;
		background-color : #fff;
	}
	
	#chart2{
		vertical-align: center;
		height:350px;
		width:400px;
		margin-top:30px;
		background-color : #fff;
	}
	
	#chart3{
		vertical-align: center;
		height:300px;
		width:500px;
		margin-top:30px;
		margin-bottom:50px;
		background-color : #fff;
	}
	
	#buttonDiv{
		height:300px;
		width:400px;
		margin-top:30px;
		margin-bottom:50px;
		background-color : #fff;
	}
	
	#font1{
		margin-left: 140px;
		margin-top: 160px;
		color:#4e4a41;
		font-size: 12px;
		font-weight: bold;
		
	}
	#font2{
		margin-left: 100px;
		margin-top: 160px;
		color:#4e4a41;
		font-size: 12px;
		font-weight: bold;
		
	}
	
	#font3{
		margin-left: 140px;
		margin-top: 140px;
		color:#4e4a41;
		font-size: 12px;
		font-weight: bold;
		
	}
	
	#font4{
		margin-left: 70px;
		margin-top: 80px;
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
	margin-left: 17px
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

#btn2 {
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
#btn2:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}	

#btn3 {
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
#btn3:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}	

#btn4 {
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
	background-color: #548eb3;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
}
#btn4:hover{
	background-color:#669aba;
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
						<font id ="titleFont">통계보기</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span6" style ="border:1px solid #d4d1ca" 	id="chart1">
				<div id ="font1"><font >버튼을 클릭하시면 차트가 나타납니다.</font></div>
			</div>
			<div class ="span5" style ="border:1px solid #d4d1ca"  id= "chart2">
				<div id ="font2"><font >버튼을 클릭하시면 차트가 나타납니다.</font></div>
			</div>
		</div>	
	</div>
	<div class ="container">
		<div class ="row">
			<div class ="span6" style ="border:1px solid #d4d1ca"  id= "chart3">
				<div id ="font3"><font >버튼을 클릭하시면 차트가 나타납니다.</font></div>
			</div>
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
					<input type ="button" id ="btn1" value ="대분류별가입자수"/>
					<input type ="button" id ="btn2" value ="연령별가입자수"/>
					<input type ="button" id ="btn3" value ="대분류&연령"/>
					<input type ="button" id ="btn4" value ="카드사별 매출"/>
				</div>
			</div>
		</div>
	</div>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
</body>
</html>