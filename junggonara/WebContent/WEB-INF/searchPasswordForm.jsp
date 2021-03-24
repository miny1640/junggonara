<%@page import="exe.entity.MemberEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/searchPasswordFormCSS.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
<link rel = "stylesheet" href = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel = "stylesheet" href = "https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" type="text/css" href="css/junggonara.css"/>
</head>

<body id="pwdbody">
<%
		MemberEntity member = (MemberEntity)session.getAttribute("member");
%>
<!-- 상단 바 -->
  <header class="mdl-layout__header mdl-layout__header--waterfall">
    <!-- Top row, always visible -->
    <div class="mdl-layout__header-row">
      <!-- Title -->
      <span class="mdl-layout-title">
      <a href="boardMain.do"><img src = "image/main2.png" width="220" height="180" style="position:absolute; top:-45px; left:590px;"/></a>
      </span>
      <div class="mdl-layout-spacer"></div>
    </div>
    
<%
	if( member != null ){	
%>
    <!-- Bottom row, not visible on scroll -->
    <div class="mdl-layout__header-row">
      <div class="mdl-layout-spacer"></div>
      <!-- Navigation -->
      <nav class="mdl-navigation">
      <%=member.getMb_name() %>님
      <a class="mdl-navigation__link" href="logout.do">로그아웃</a>
      </nav>
    </div>
<%
	}else{
%>
	<!-- Bottom row, not visible on scroll -->
    <div class="mdl-layout__header-row">
      <div class="mdl-layout-spacer"></div>
      <!-- Navigation -->
      <nav class="mdl-navigation">
      <a class="mdl-navigation__link" href="loginForm.do">로그인</a>
      <a class="mdl-navigation__link" href="memberInsertForm.do">회원가입</a>
      </nav>
    </div>	
<%
	}
%>
  </header>

<br/>
<br/>
<br/>
<br/>
<br/>
<form action="searchPassword.do" method="post">
<div align="center">
  <fieldset class="passwordfield" style="border:solid #e5e5e5 2px;width:600px;height:400px;border-bottom-width:7px;
border-right-width:7px;
border-right-color:lightgrey;
border-bottom-color:lightgrey;">
  		<legend><img src="image/question.png" width="85" height="95"/></legend>		
<br/>
<br/>
<font size="5">학번을 입력하시고 버튼을 눌러주세요</font>
<p/>
<br/>
<br/>

<input type="text" name="schoolnumber" id="schoolnumber" class="schoolnumber" style="width: 220px;height: 40px;position: relative;bottom: 30px;
		  text-align: center;border-right:2px solid lightgrey;border-bottom:2px solid lightgrey; " placeholder="학번 입력란" />
&nbsp;

<input type="IMAGE" src="image/searching-magnifying-glass.png" name="submit" 
		  value="submit" style="align:absmiddle;border-right:2px solid lightgrey;border-bottom:2px solid lightgrey;"/>



</fieldset>
<br/>
<div align="center" style="position: relative;bottom: 20px;">
	<a href="boardMain.do"><font style="color:blue;font-size:15px;">메인으로 돌아가기</font></a>
</div>
</div>
</form>
</body>
</html>