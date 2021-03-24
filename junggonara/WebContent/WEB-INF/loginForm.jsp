<%@page import="exe.entity.MemberEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/boardMainCSS.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
<link rel = "stylesheet" href = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel = "stylesheet" href = "https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" type="text/css" href="css/junggonara.css"/>
<link rel="stylesheet" type="text/css" href="css/basicbutton.css" />

</head>

<body id="loginbody">

<%
		MemberEntity member = new MemberEntity();
		member = (MemberEntity)session.getAttribute("member");
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
<form action="login.do" method="post">
<div align="center">
	<fieldset id="loginfield">
		<legend><img src="image/id-card.png" width="85" height="100"/></legend>
		<br/>
		<br/>
		<ul style="font-size:25px;list-style-type:none;position: relative;right: 70px;">
			<li>
				<label for="id" style="align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;학번&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="text" name="id" id="id" style="width:250px; height:35px;align:center;text-align:center;font-size:20px;"/>
			</li>
			
			<li>
				<label for="pw">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호&nbsp;</label>
				<input type="password" name="pw" id="pw" style="width:250px; height:35px;align:center;text-align:center;font-size:20px;"/>
			</li>
		</ul>
		<br/>
		<input class="login13" type="submit" value="로그인"  style="width: 70px;height: 50px;border-right:2px solid lightgrey;border-bottom:2px solid lightgrey;" />

		<br/>
		<p/>
		<br/>
		<br/>
	</fieldset>
	</div>
<div align="center" >
	<a href="boardMain.do"><font style="color:blue;font-size:15px;">메인으로 돌아가기</font></a>&nbsp;&nbsp;&nbsp;<a href="searchPasswordForm.do"><font style="color:blue;font-size:15px;">비밀번호 찾기</font></a>
</div>
</form>
</body>
</html>