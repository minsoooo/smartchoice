<!-- 
	매장찾기 페이지 
	작성일 : 2016-07-21
	수정일 : 2016-07-31
	작성자 : 이재승
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>매장 찾기</title>
<style>
.map_wrap1, .map_wrap2, .map_wrap3 {position: relative; width: 100%; margin-bottom: 30px; margin-top: 10px;}
.title {font-weight: bold; display: block;}
.hAddr {position: absolute;}
#centerAddr {display: block; margin-top: 2px; font-weight: normal;}
.bAddr {padding: 5px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;}
.map_wrap, .map_wrap * {margin: 0; padding: 0; font-family: 'Malgun Gothic',dotum,'돋움',sans-serif; font-size: 12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color: #000; text-decoration: none;}
.map_wrap {position: relative; width: 100%; height: 700px; border: 2px black solid;}
#menu_wrap {position: absolute; top: 0; left: 0;bottom: 0; width: 250px; margin: 10px 0 30px 10px; padding: 5px; overflow-y: auto; background: rgba(255, 255, 255, 0.7); z-index: 1; font-size: 12px; border-radius: 10px;}
.bg_white {background: #fff;}
#menu_wrap hr {display: block; height: 1px; border: 0; border-top: 2px solid #5F5F5F; margin:3px 0;}
#menu_wrap .option{text-align: center;} #menu_wrap .option p {margin: 10px 0;} #menu_wrap .option button {margin-left: 5px;}
#placesList li {list-style: none;}
#placesList .item {position: relative; border-bottom: 1px solid #888; overflow: hidden; cursor: pointer; min-height: 65px;}
#placesList .item span {display: block; margin-top: 4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis; overflow: hidden; white-space: nowrap;}
#placesList .item .info{padding: 10px 0 10px 55px;}
#placesList .info .gray {color: #8a8a8a;} #placesList .info .tel {color: #009900;}
#placesList .info .jibun {padding-left: 26px; background: url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .item .markerbg {float: left; position: absolute; width: 36px; height: 37px; margin: 10px 0 0 10px; background: url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;} #placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px} #placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;} #placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;} #placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;} #placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;} #placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;} #placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin: 10px auto; text-align: center;} #pagination a {display: inline-block; margin-right: 10px;} #pagination .on {font-weight: bold; cursor: default; color: #777;}
#bigCateList, #smallCateList, #keywordSearch{margin-top: 10px; margin-bottom: 10px;}
.dot {overflow: hidden; float: left; width: 12px; height: 12px; background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position: relative; bottom: 10px; border-radius: 6px; border: 1px solid #ccc; border-bottom: 2px solid #ddd; float: left; font-size: 12px; padding: 5px; background: #fff;}
.dotOverlay:nth-of-type(n) {border: 0; box-shadow: 0px 1px 2px #888;}    
.number {font-weight: bold; color:#ee6152;}
.dotOverlay:after {content: ''; position: absolute; margin-left: -6px; left: 50%; bottom: -8px; width: 11px; height: 8px; background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position: relative; top: 5px; left: 5px; list-style: none; margin: 0;}
.distanceInfo .label {display: inline-block; width: 50px;}
.distanceInfo:after {content: none;}
</style>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
$(function(){
	$("#bigCateList").bind("change", bigCateChange);
	bigCateChange();
	
	$("#smallCateList").bind("change", smallCateChange);
	smallCateChange();
	
	$("#discountList").bind("change", dcListChange);
	dcListChange();
});

function bigCateChange(){
	$("#smallCateList").empty();
	var big_num = $("option:selected").attr("value");
	$.get("/map/getSmallCategory",{"big_num":big_num}).done(
		function(xmlData){
			var category = $(xmlData).find("category");
			var card = $(xmlData).find("card");
			if(category.length){
				$(category).each(
					function(){
						var small_num = $(this).find("small_num").text();
						var small_name = $(this).find("small_name").text();
						var insertCode ="<option id ='"+small_num+"' value ='"+small_name+"'>"+small_name+"</option>";
						$(insertCode).appendTo("#smallCateList");
					}
				)
			}
			smallCateChange();
		}		
	);
}

function smallCateChange(){
	var small_name = $("select[name='smallCateList'] option:selected").attr("value");
	$("#keyword").val(small_name);
	$("#search").submit();
}

function dcListChange(){
	var small_name1 = $("select[name='discountList'] option:selected").attr("value");
	$("#keyword").val(small_name1);
	$("#search").submit();
}
</script>
</head>
<body style="background-color: #f5f4f0; font-family: 'Noto Sans KR', sans-serif;">
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="container">
		<div class="row" style="margin-top: 30px">
			<center><p><em style="color: red;">지도를 마우스로 클릭하면 선 그리기가 시작되고 오른쪽 마우스를 클릭하면 선 그리기가 종료됩니다</em></p></center>
		</div>
		<div class="row">
			<div class="map_wrap">
				<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
				<div id="menu_wrap" class="bg_white">
					<div class="option">
						<div>
							<b>카테고리로 검색</b>
							<select id="bigCateList" name="comp_num">
								<option id="bigTitle">대분류</option>
								<c:forEach items="${bigDtoList}" var="bigClassDto">
									<option value="${bigClassDto.big_num}">${bigClassDto.big_name}</option>
								</c:forEach>
							</select>
							<select id="smallCateList" name="smallCateList">
								<option id="smallTitle">소분류</option>
								<c:forEach items="${smallCateList}" var="smallList">
									<option id="${smallList.small_num}" value="${smallList.small_name}">${smallList.small_name}</option>
								</c:forEach>
							</select>
						</div>
						<hr/>
						<div class="keywordSearch">
							<form onsubmit="searchPlaces(); return false;">
								<input type="hidden" id="addr" value="">
								<b>키워드로 검색</b>							
								<div class="input-append">
									<input class="span2" id="keyword" type="text" onfocus="this.value=''">
									<input type="submit" class="btn" value="검색" id="search" />
								</div>
							</form>
						</div>
					</div>
					<hr/>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
				</div>
			</div>
			
			<div class="span12" id="map" style="width: 100%; height: 100%;"></div>
			<div class="row">
				<div class="span4 map_wrap1">
					<div id="map" style="width: 100%; height: 100%;"></div>
					<div class="hAddr">
						<span class="title" align="center">지도중심기준 행정동 주소정보</span> <span id="centerAddr" align="center"></span>
					</div>
				</div>
				<div class="span4 map_wrap2">
					<div class="hAddr">
						<span class="title" align="center">나의 카드</span> 
						<span id="useCard" align="center">${cardCode}</span>
					</div>
				</div>
				<div class="span4 map_wrap3">
					<select id="discountList" name="discountList" style="float: right">
						<option>---------나의 할인 목록---------</option>
						<c:forEach items="${discount}" var="discountList">
							<option value="${discountList.small_name}">${discountList.small_name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=b1e545840b02f1b23a464afd6bd416b8&libraries=services"></script>
<script>
	// 마커를 담을 배열
	var markers = [];
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {center : new daum.maps.LatLng(37.5679532, 126.9827), level : 3}; // 지도의 중심좌표, 지도의 확대 레벨

	var map = new daum.maps.Map(mapContainer, mapOption); // 지도 생성
	var geocoder = new daum.maps.services.Geocoder(); // 좌표-주소 변환 객체 생성
	var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있는 변수
	var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체
	var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체
	var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이
	var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열
	
	// 지도 클릭 이벤트(지도를 클릭하면 선 그리기가 시작되고 그려진 선이 있으면 지우고 다시 그린다.)
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
		var clickPosition = mouseEvent.latLng; // 마우스로 클릭한 위치
		
		if (!drawingFlag) { // 지도 클릭이벤트가 발생했는데 선이 그려지고 있는 상태가 아니면
			drawingFlag = true; // 상태를 true로, 선이 그리고있는 상태로 변경
			deleteClickLine(); // 지도 위에 선이 표시되고 있다면 지도에서 제거
			deleteDistnce(); // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거
			deleteCircleDot(); // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거

			// 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시
			clickLine = new daum.maps.Polyline({
				map : map, // 선을 표시할 지도
				path : [ clickPosition ], // 선을 구성하는 좌표 배열(클릭한 위치를 넣는다.)
				strokeWeight : 3, // 선의 두께
				strokeColor : '#db4040', // 선의 색깔
				strokeOpacity : 1, // 선의 불투명도(0에서 1 사이값이며 0에 가까울수록 투명하다.)
				strokeStyle : 'solid' // 선의 스타일
			});

			// 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성
			moveLine = new daum.maps.Polyline({
				strokeWeight : 3, // 선의 두께
				strokeColor : '#db4040', // 선의 색깔
				strokeOpacity : 0.5, // 선의 불투명도(0에서 1 사이값이며 0에 가까울수록 투명하다.)
				strokeStyle : 'solid' // 선의 스타일
			});

			// 클릭한 지점에 대한 정보를 지도에 표시
			displayCircleDot(clickPosition, 0);
		} 
		else { // 선이 그려지고 있는 상태면
			var path = clickLine.getPath(); // 그려지고 있는 선의 좌표 배열
			
			path.push(clickPosition); // 좌표 배열에 클릭한 위치를 추가
			clickLine.setPath(path); // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정
			
			var distance = Math.round(clickLine.getLength());
			
			displayCircleDot(clickPosition, distance);
		}
	});

	// 지도 마우스무브 이벤트(다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정)
	daum.maps.event.addListener(map, 'mousemove', function(mouseEvent) {
		if (drawingFlag) { // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
			var mousePosition = mouseEvent.latLng; // 마우스 커서의 현재 위치
			var path = clickLine.getPath(); // 마우스 클릭으로 그려진 선의 좌표 배열
			var movepath = [ path[path.length - 1], mousePosition ]; // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시
			
			moveLine.setPath(movepath);
			moveLine.setMap(map);

			var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산
				content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용
			
			showDistance(content, mousePosition); // 거리정보를 지도에 표시
		}
	});

	// 지도 마우스 오른쪽 클릭 이벤트(선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료)
	daum.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
		if (drawingFlag) { // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
			// 마우스무브로 그려진 선은 지도에서 제거
			moveLine.setMap(null);
			moveLine = null;

			var path = clickLine.getPath(); // 마우스 클릭으로 그린 선의 좌표 배열

			if (path.length > 1) { // 선을 구성하는 좌표의 개수가 2개 이상이면
				if (dots[dots.length - 1].distance) { // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지운다.
					dots[dots.length - 1].distance.setMap(null);
					dots[dots.length - 1].distance = null;
				}

				var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산
					content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용
	
					showDistance(content, path[path.length - 1]); // 그려진 선의 거리정보를 지도에 표시
			} 
			else {
				// 선을 구성하는 좌표의 개수가 1개 이하이면 지도에 표시되고 있는 선과 정보들을 지도에서 제거
				deleteClickLine();
				deleteCircleDot();
				deleteDistnce();
			}
			// 상태를 false로, 그리지 않고 있는 상태로 변경
			drawingFlag = false;
		}
	});
	
	// 클릭으로 그려진 선을 지도에서 제거하는 함수
	function deleteClickLine() {
		if (clickLine) {
			clickLine.setMap(null);
			clickLine = null;
		}
	}
	
	// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하고 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수
	function showDistance(content, position) {
		if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
			// 커스텀 오버레이의 위치와 표시할 내용을 설정
			distanceOverlay.setPosition(position);
			distanceOverlay.setContent(content);
		} 
		else { // 커스텀 오버레이가 생성되지 않은 상태
			// 커스텀 오버레이를 생성하고 지도에 표시
			distanceOverlay = new daum.maps.CustomOverlay({
				map : map, // 커스텀오버레이를 표시할 지도
				content : content, // 커스텀오버레이에 표시할 내용
				position : position, // 커스텀오버레이를 표시할 위치
				xAnchor : 0,
				yAnchor : 0,
				zIndex : 3
			});
		}
	}

	// 그려지고 있는 선의 총거리 정보와 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수
	function deleteDistnce() {
		if (distanceOverlay) {
			distanceOverlay.setMap(null);
			distanceOverlay = null;
		}
	}

	// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 클릭 지점에 대한 정보(동그라미와 클릭 지점까지의 총거리)를 표출하는 함수
	function displayCircleDot(position, distance) {
		// 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성
		var circleOverlay = new daum.maps.CustomOverlay({
			content : '<span class="dot"></span>',
			position : position,
			zIndex : 1
		});

		circleOverlay.setMap(map); // 지도에 표시

		if (distance > 0) {
			var distanceOverlay = new daum.maps.CustomOverlay({ // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성
				content : '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
				position : position,
				yAnchor : 1,
				zIndex : 2
			});

			distanceOverlay.setMap(map); // 지도에 표시
		}

		// 배열에 추가
		dots.push({
			circle : circleOverlay,
			distance : distanceOverlay
		});
	}

	// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수
	function deleteCircleDot() {
		var i;

		for (i = 0; i < dots.length; i++) {
			if (dots[i].circle) {
				dots[i].circle.setMap(null);
			}

			if (dots[i].distance) {
				dots[i].distance.setMap(null);
			}
		}

		dots = [];
	}

	// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여 HTML Content를 만들어 리턴하는 함수
	function getTimeHTML(distance) {
		// 도보의 평균 시속 4km/h, 분속 67m/min
		var walkkTime = distance / 67 | 0;
		var walkHour = '', walkMin = '';

		if (walkkTime > 60) { // 계산한 도보 시간이 60분 보다 크면 시간으로 표시
			walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
		}	
		walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

		// 자전거의 평균 시속은 16km/h, 분속 267m/min
		var bycicleTime = distance / 227 | 0;
		var bycicleHour = '', bycicleMin = '';

		if (bycicleTime > 60) { // 계산한 자전거 시간이 60분 보다 크면 시간으로 표시
			bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
		}
		bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

		// 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴
		var content = '<ul class="dotOverlay distanceInfo">';
		content += '<li>';
		content += '<span class="label">총거리</span><span class="number">' + distance + '</span>m';
		content += '</li>';
		content += '<li>';
		content += '<span class="label">도보</span>' + walkHour + walkMin;
		content += '</li>';
		content += '<li>';
		content += '<span class="label">자전거</span>' + bycicleHour + bycicleMin;
		content += '</li>';
		content += '</ul>';

		return content;
	}

	var locPosition, lat, lon;
	// HTML5의 geolocation으로 사용할 수 있는지 확인(현재 위치)
	if (navigator.geolocation) {
		// GeoLocation을 이용해서 접속 위치를 얻어온다.
		navigator.geolocation.getCurrentPosition(function(position) {
			lat = position.coords.latitude; // 위도
			lon = position.coords.longitude; // 경도
			locPosition = new daum.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성
			message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용
			searchAddrFromCoords(locPosition); // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 하단에 표시
			displayMarker(locPosition, message); // 마커와 인포윈도우를 표시
		});
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정
		var locPosition = new daum.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없습니다.';
	
		displayMarker(locPosition, message);
	}
	
	function searchAddrFromCoords(coords) {
		// 좌표로 행정동 주소 정보를 요청
		geocoder.coord2addr(coords, callback);
	}
	
	// 지도 좌측하단에 지도 중심좌표에 대한 주소정보를 표출하는 함수
	var callback = function displayCenterInfo(status, result) {
		if (status === daum.maps.services.Status.OK) {
			var infoDiv = document.getElementById('centerAddr');
			infoDiv.innerHTML = result[0].fullName;
			
			var addr = result[0].fullName;
			$("#addr").attr("value", addr);

			smallCateChange();
		}
	}
	
	// 지도에 내 위치의 마커와 인포윈도우를 표시하는 함수
	function displayMarker(locPosition, message) {
		var imageSrc = "http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; // 내 위치 마커 이미지의 이미지 주소
		var imageSize = new daum.maps.Size(24, 35); // 내 위치 마커 이미지의 이미지 크기
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); // 내 위치에 마커 이미지 생성
		
		// 내 위치 마커를 생성
		var marker = new daum.maps.Marker({
			map : map,
			position : locPosition,
			image : markerImage, // 내 위치 마커 이미지
			clickable : true
		});
		
		var iwContent = message, iwRemoveable = true; // 인포윈도우에 표시할 내용

		// 인포윈도우를 생성
		var infowindow = new daum.maps.InfoWindow({
			content : iwContent,
			removable : iwRemoveable
		});

		infowindow.open(map, marker); // 인포윈도우를 마커 위에 표시
		map.setCenter(locPosition); // 지도 중심좌표를 접속위치로 변경
	}

	var ps = new daum.maps.services.Places(); // 장소 검색 객체를 생성
	var infowindow = new daum.maps.InfoWindow({
		zIndex : 1
	}); // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성

	// 키워드 검색을 요청하는 함수
	function searchPlaces() {
		var input = document.getElementById('keyword').value;
		var keyword = $("#addr").attr("value") + " " + input;
		if(keyword.length > 10){
			ps.keywordSearch(keyword, placesSearchCB);
		}
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수
	function placesSearchCB(status, data, pagination) {
		if (status === daum.maps.services.Status.OK) {
			displayPlaces(data.places); // 정상적으로 검색이 완료됐으면 검색 목록과 마커를 표시
			displayPagination(pagination); // 페이지 번호 표시
		} 
		else if (status === daum.maps.services.Status.ZERO_RESULT) {
			alert("검색 결과가 존재하지 않습니다.");
			return;
		} 
		else if (status === daum.maps.services.Status.ERROR) {
			alert("검색 결과 중 오류가 발생했습니다.");
			return;
		}
	}

	// 검색 결과 목록과 마커를 표출하는 함수
	function displayPlaces(places) {
		var listEl = document.getElementById('placesList'), 
			menuEl = document.getElementById('menu_wrap'),
			fragment = document.createDocumentFragment(),
			bounds = new daum.maps.LatLngBounds(), listStr = '';
			
		removeAllChildNods(listEl); // 검색 결과 목록에 추가된 항목들을 제거
		removeMarker(); // 지도에 표시되고 있는 마커를 제거
		
		for (var i = 0; i < places.length; i++) {
			var placePosition = new daum.maps.LatLng(places[i].latitude, places[i].longitude), 
				marker = addMarker(placePosition, i), // 마커를 생성하고 지도에 표시
				itemEl = getListItem(i, places[i], marker); // 검색 결과 항목 Element를 생성

			var distance = Math.sqrt(Math.pow(lat - places[i].latitude, 2) + Math.pow(lon - places[i].longitude, 2));
				
			//alert(i+1 + "번째 거리 : " + Math.round(distance*100));
			
			bounds.extend(placePosition); // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds객체에 좌표를 추가
			
			// 마커와 검색결과 항목에 mouseover 했을때 해당 장소에 인포윈도우에 장소명을 표시하고 mouseout 했을 때는 인포윈도우를 닫는다.
			(function(marker, title) {
				daum.maps.event.addListener(marker, 'mouseover', function() {
					displayInfowindow(marker, title);
				});

				daum.maps.event.addListener(marker, 'mouseout', function() {
					infowindow.close();
				});

				itemEl.onmouseover = function() {
					displayInfowindow(marker, title);
				};

				itemEl.onmouseout = function() {
					infowindow.close();
				};
			})(marker, places[i].title);

			fragment.appendChild(itemEl);
		}

		listEl.appendChild(fragment); // 검색결과 항목들을 검색결과 목록 Elemnet에 추가
		menuEl.scrollTop = 0;

		map.setBounds(bounds); // 검색된 장소 위치를 기준으로 지도 범위를 재설정
	}

	// 검색결과 항목을 Element로 반환하는 함수
	function getListItem(index, places) {
		var el = document.createElement('li'), itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' + '<div class="info">' + '<h5>' + places.title + '</h5>';

		if (places.newAddress) {
			itemStr += '<span>' + places.newAddress + '</span>' + '<span class="jibun gray">' + places.address + '</span>';
		} 
		else {
			itemStr += '<span>' + places.address + '</span>';
		}

		itemStr += '<span class="tel">' + places.phone + '</span>' + '</div>';

		el.innerHTML = itemStr;
		el.className = 'item';

		return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수
	function addMarker(position, idx, title) {
		var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지 사용
			imageSize = new daum.maps.Size(36, 37), // 마커 이미지 크기
			imgOptions = {
				spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지 크기
				spriteOrigin : new daum.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new daum.maps.Point(13, 37)
			}, // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions), marker = new daum.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage,
				clickable : true
			});
		marker.setMap(map); // 지도 위에 마커를 표시
		markers.push(marker); // 배열에 생성된 마커를 추가
		
		return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거
	function removeMarker() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}

		markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수
	function displayPagination(pagination) {
		var paginationEl = document.getElementById('pagination'),
			fragment = document.createDocumentFragment(), i;

		// 기존에 추가된 페이지번호를 삭제
		while (paginationEl.hasChildNodes()) {
			paginationEl.removeChild(paginationEl.lastChild);
		}

		for (i = 1; i <= pagination.last; i++) {
			var el = document.createElement('a');
			el.href = "#";
			el.innerHTML = i;

			if (i === pagination.current) {
				el.className = 'on';
			} else {
				el.onclick = (function(i) {
					return function() {
						pagination.gotoPage(i);
					}
				})(i);
			}

			fragment.appendChild(el);
		}

		paginationEl.appendChild(fragment);
	}
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수(인포윈도우에 장소명을 표시합니다)
	function displayInfowindow(marker, title) {
		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		infowindow.setContent(content);
		infowindow.open(map, marker);
	}

	// 검색결과 목록의 자식 Element를 제거하는 함수
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild(el.lastChild);
		}
	}
</script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=APIKEY&libraries=LIBRARY"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=APIKEY&libraries=services,clusterer"></script> <!-- services와 clusterer 라이브러리 불러오기 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>