<%@page import="exe.dao.DepartmentDAO"%>
<%@page import="exe.entity.MemberEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" type="text/css" href="css/mypageCSS.css"/>
<link rel="stylesheet" type="text/css" href="css/basicbutton.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
</head>
<body>
<%
	MemberEntity member = new MemberEntity();
	member = (MemberEntity)session.getAttribute("member");
	DepartmentDAO departmentDAO = new DepartmentDAO();
%>
				<!-- 상단 바 -->
<header class="mdl-layout__header mdl-layout__header--waterfall">
    <div class="mdl-layout__header-row">
    	<span class="mdl-layout-title">
      		<a href="boardMain.do"><img src = "image/main2.png" width="220" height="180" style="position:absolute; top:-45px; left:590px;"/></a>
      	</span>
    	<div class="mdl-layout-spacer"></div>
    </div>
    <div class="mdl-layout__header-row">
    	<div class="mdl-layout-spacer"></div>
      	<nav class="mdl-navigation">
      		<%=member.getMb_name() %>님
      		<a class="mdl-navigation__link" href="boardMain.do" style="padding: 10px;">메인으로</a>
      		<a class="mdl-navigation__link" href="logout.do" style="padding: 10px;">로그아웃</a>
      	</nav>
    </div>
</header>
				<!-- 왼쪽 목차 -->
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header" style="position:absolute; top:0px; left:-20px;">
	<div class="mdl-layout__drawer">
  		<nav class="mdl-navigation">
<br/><br/>
			<a class="mdl-navigation__link" href="myPage.do" style="text-align:right;font-size: x-large;">회원정보</a>	
<br/><br/>
			<a class="mdl-navigation__link" href="mywriting.do" style="text-align:right;font-size: x-large;">내가 쓴 글</a>
  		</nav>
  	</div>
</div>
				<!-- 회원정보 테이블 -->
<form method="post">		
	<div id="mp-container" style="position:relative;top: 50px;">	<!-- 회원정보 컨테이너 -->
				<!-- 회원정보 컨텐츠 -->
		<div id="mp-content1"> 		<!-- 이름 -->
 			<img src = "image/mypage1.png" width="40" height="40"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<Font color="white"><%=member.getMb_name() %></Font>
		</div>

		<div id="mp-content1">		<!-- 학번 -->
			<img src = "image/mypage2.png" width="40" height="40"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<Font color="white"><%=member.getMb_id() %></Font>
		</div>

		<div id="mp-content1">		<!-- 비밀번호 -->
			<img src = "image/mypage3.png" width="40" height="40"/>
			<input type="password" name="mb_pw" value="<%=member.getMb_pw() %>" style="width:200px;height:30px;font-size:15pt; letter-spacing:3px;position: relative;left: 40px;top:5px;text-align: center;"/>
		</div>

		<div id="mp-content1">		<!-- 학과 -->
			<img src = "image/mypage4.png" width="40" height="40"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<Font color="white"><%=departmentDAO.selectDept(member.getDept_code()).getDept_name() %></Font>
		</div>
	</div>
				<!-- 수정 완료 버튼 -->	
	<div align="center" style="position:relative;bottom:15pt;">	
	<input type="submit" class="button11" value="수정 완료" formaction="memberUpdate.do"/>	
	</div>
</form>

</body>
</html>