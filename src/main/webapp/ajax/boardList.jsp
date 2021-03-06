<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
//jQuery의 Entry point(진입점). 페이지의 로딩이 끝난 직후 호출된다. ㅋ
$(function() {
	//해당 버튼을 눌렀을때 ajax메서드를 호출한다. 
    $('#btnBoard').click(function() {
    	
    	//리스트를 요청했을때 loading이미지를 요청한다. 
    	$('#loading').show();
    	
        $.ajax({
            type : 'get', //전송방식
            url : '../restapi/boardList.do', //요청URL
            data : {nowPage : $('#nowPage').val()}, //파라미터
            contentType : "text/html;charset:utf-8",
            dataType : "json", //콜백 데이터 타입
            success : sucCallBack, //요청에 성공했을때 호출되는 콜백 함수
            error : errCallBack //실패했을때 콜백 함수
        });
    });
	/*
	trigger() 함수는 특정 이벤트를 자동으로 발생시켜준다.
	아래의 경우 페이지가 로드되면 해당 버튼을 클릭해준다. 
	*/
    $('#btnBoard').trigger('click');
});

function sucCallBack(resData) {
    let tableData = "";
    //JSON배열을 콜백받아 갯수만큼 tr태그를 생성한다. 
    $(resData).each(function(index,data){
        tableData += ""
        + "<tr>"
        + "    <td>"+data.num+"</td>"
        + "    <td>"+data.title+"</td>"
        + "    <td>"+data.id+"</td>"
        + "    <td>"+data.postdate+"</td>"
        + "    <td>"+data.visitcount+"</td>"
        + "</tr>"
    });
    //해당 엘리먼트에 새로운 내용으로 교체한다. 
    $('#show_data').html(tableData);
    
    //요청이 완료되어 콜백되면 숨김처리한다. 
    $('#loading').hide();
}

//실패했을때의 콜백 함수
function errCallBack(errData) {
    console.log(errData.status+":"+errData.statusText);
}
</script>
</head>
<body>
<div class="container">
	<h2>게시판 API 활용하여 목록 출력하기</h2>
	
    <table class="table table-bordered">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>아이디</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        <tr id="loading" style="display:none;">
        	<td colspan="5" align="center"><img src="../resources/loading02.gif" /></td>
        </tr>
        <tbody id="show_data"></tbody>
    </table>

    <div>
        <select id="nowPage">
            <option value="1">1page</option>
            <option value="2">2page</option>
            <option value="3">3page</option>
            <option value="4">4page</option>
            <option value="5">5page</option>
        </select>
        <input type="button" value="목록불러오기" id="btnBoard">
    </div>
</div>
</body>
</html>