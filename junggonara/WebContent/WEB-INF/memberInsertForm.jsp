<%@page import="exe.dao.MajorDAO"%>
<%@page import="exe.entity.MajorEntity"%>
<%@page import="exe.entity.MemberEntity"%>
<%@page import="exe.dao.DepartmentDAO"%>
<%@page import="exe.entity.DepartmentEntity"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/boardMainCSS.css" />
<link rel="stylesheet" type="text/css" href="css/basicbutton.css"/>

<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
<link rel = "stylesheet" href = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel = "stylesheet" href = "https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" type="text/css" href="css/junggonara.css"/>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<%
	ArrayList<MajorEntity> major_list = new ArrayList<MajorEntity>();
	MajorDAO majorDAO = new MajorDAO();
	major_list = majorDAO.selectAll();
%>
<script type = "text/javascript">
	function itemChange(value){
		/*학부 선택 -> 해당 학과 선택 가능*/
<%
	ArrayList<DepartmentEntity> dept_list = new ArrayList<DepartmentEntity>();
	DepartmentDAO deptDAO = new DepartmentDAO();
	if(major_list.size() == 0){ // 학부가 없을 때의 default
		
	}else{
%>
		$('#dept_code').empty(); /* 학부 관련 학과 목록 출력을 위한 준비 */
<%
		for(MajorEntity major : major_list){//학부에 관련된 학과를 출력시키기 위한 작업
%>
			if(value == '<%=major.getM_code()%>'){
<%
				dept_list = deptDAO.select(major.getM_code());//list에 학과 내용집어넣기

				for(DepartmentEntity dept : dept_list){
%>
					var option = "<option value='<%=dept.getDept_code()%>'><%=dept.getDept_name()%></option>";
					$('#dept_code').append(option);
<%
				}
%>
			}
<%
		}
	}
%>
	}
</script>
</head>
<body class="memberbody">
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
      <a class="mdl-navigation__link" href="loginForm.do">로그인</a>
      </nav>
    </div>	
<%
	}
%>
  </header>
  <br/>

<form action="memberInsert.do" method="post">
	<div id="money" align="center">
		<b>
		<font size="4">돈이 오가는 거래이기 때문에 <br/>사기 행위, 남을 속이는 행위는<br/></font>
		<font color="red" size="4.5"> 법에 의거하여 처벌 받을 수 있습니다!</font>
		</b>
	</div>
<br/>
<table class="membertable"> 
<tr>
	<th scope="row"><font color="black" size="5.5">이름</font></th>
	<td><input type="text" name="mb_name" style="width:200px; height:30px;font-size:15pt;" /></td>
</tr>
<tr>
	<th scope="row"><font color="black" size="5.5">학번</font></th>
	<td><input type="text" name="mb_id" style="width:200px; height:30px;font-size:15pt;" placeholder="하이픈없이 입력^-^" /></td>
</tr>
<tr>
	<th><font color="black" size="5.5">비밀번호</font></th>
	<td><input type="password" name="mb_pw" style="width:200px; height:30px;font-size:15pt; letter-spacing:3px;"/>
	</td>
</tr>
<tr>
	<th><font color="black" size="5.5">학부</font></th>
<%
	if(major_list.size()==0){//DB에 저장되어 있는 학부를 못찾거나 없으면 NONE
%>
	<td>NONE</td>
<%
	}else{//DB에 저장되어 있는 학부 정보를 이용하여 학부선택 학부를 직접 적어서 작성할 필요가 없다.
%> 
	<td>      <!-- 학부선택 -->
	<select id="m_code" name="m_code" onchange="itemChange(this.value)" style="width:200px; height:30px;font-size:15pt;">
			<option value="0">학부를 선택하세요</option>
<%
		for(MajorEntity major : major_list){
%>               
			<option value="<%=major.getM_code()%>"><%=major.getM_name() %></option>
<%
		}
	}
%>
	</select>
	</td>
</tr>
<tr>
	<th><font color="black" size="5.5">학과</font></th>
	<td>
	<select id="dept_code" name="dept_code" style="width:200px; height:30px;font-size:15pt;">
	</select>
	</td>
</tr>
<tr id="memberinput">
	<td colspan="2"> <!-- 두칸을 하나로 합침 -->
		<div align="center">
			<input type="submit" class="button11" value="회원가입" style="margin:10px;"/>
			<input type="reset" class="button11" value="다시쓰기"/>
			
		</div>
	</td>
</tr>
</table>
</form>
<br/>
<div align="center">
<small style="color:black;"><a href="boardMain.do">메인으로 돌아가기</a></small>
</div>
</body>
</html>