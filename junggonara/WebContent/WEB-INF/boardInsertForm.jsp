<%@page import="exe.entity.MemberEntity"%>
<%@page import="exe.dao.BookDAO"%>
<%@page import="exe.entity.BookEntity"%>
<%@page import="exe.dao.DepartmentDAO"%>
<%@page import="exe.entity.DepartmentEntity"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성 : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/boardInsertFormCSS.css" />
<link rel="stylesheet" type="text/css" href="css/basicbutton.css"/>

<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
<link rel = "stylesheet" href = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel = "stylesheet" href = "https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type = "text/javascript">
	function itemChange(value){
		/*학과 선택 -> 해당 교과목 선택 가능*/
<%
	ArrayList<DepartmentEntity> dept_list = new ArrayList<DepartmentEntity>();
	ArrayList<BookEntity> book_list = new ArrayList<BookEntity>();
	DepartmentDAO dept_dao = new DepartmentDAO();
	BookDAO book_dao = new BookDAO();
	dept_list = dept_dao.selectAll();
	if(dept_list.size() == 0){ // 학과가 없을 때의 default
		
	}else{
%>
		$('#bk_code').empty(); // 학과 관련 책 목록 출력을 위한 준비
<%
		for(DepartmentEntity dept : dept_list){//학과에 관련된 교제를 출력시키기 위한 작업
%>
			if(value == '<%=dept.getDept_code()%>'){
<%
				book_list = book_dao.select(dept.getDept_code());//list에 책 내용집어넣기

				for(BookEntity book : book_list){
%>
					var option = "<option value='<%=book.getBk_code()%>'><%=book.getBk_title()%></option>";
					$('#bk_code').append(option);
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
<body>
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
      <a class="mdl-navigation__link" href="memberInsertForm.do">회원가입</a>
      </nav>
    </div>	
<%
	}
%>
  </header>
	
<form	method="post" 
		enctype="multipart/form-data"> <!-- 입력하면 보드인서트로 이동 -->
  <br/>
  
 <div align="center">
<table style="border:2px solid #e5e5e5; border-collapse:collapse;text-align:center;width: 700px;height: 600px;"> <!-- 테이블 테두리 -->
   <tr>
   		<th style="heigh:30px;"><font size="5">작성 선택</font></th>
		<td>	   		
   		 <label>
            <input type="radio" name="sale_purchase" value="s" checked/>판매
         </label>
          &nbsp; &nbsp; &nbsp; &nbsp;
         <label> 
            <input type="radio" name="sale_purchase" value="p"/>구입
         </label>
         </td>
         </tr>
   <tr>
         <th><font size="5">제목</font></th>
         <td><input type="text" name="br_title" style="text-align:center; width:400px; height:30px; font-size:12pt;"/></td>
   </tr>

   <tr>
         <th><font color="black" size="5" >학과</font></th>  
<%
	if(dept_list.size()==0){//DB에 저장되어 있는 학과를 못찾거나 없으면 NONE
%>
	<td>NONE</td>
<%
	}else{//DB에 저장되어 있는 학과 정보를 이용하여 학과선택 학과를 직접 적어서 작성할 필요가 없다.
%> 
     <td>      <!-- 학과선택 -->
         <select id="dept_code" name="dept_code" onchange="itemChange(this.value)" style="text-align:center; width:250px; height:30px; font-size:12pt;" >
			<option value="0" >학과를 선택하세요</option>
<%
		for(DepartmentEntity dept : dept_list){ 
%>               
			<option value="<%=dept.getDept_code()%>"><%=dept.getDept_name() %></option>
<%
		}
%>
         </select>
      </td>
<%
	}
	String flag = request.getParameter("flag");
	if(flag == null){
		flag ="0";
	}
%>
   </tr>
   <tr>		<!-- 학과에 관련된 책제목 출력 기능 구현 -->
   			<!-- 고정값 : 이름, 책, 학과 -->
   			<!-- 첨부파일 구현은 게시글 작성 기능 구현하면 완성시킬예정 -->
        <th><font size="5">책 이름</font></th>
        <td>
        <select id="bk_code" name="bk_code" style="text-align:center;width:350px;height:30px;font-size:12pt ">
        </select>
        </td> 
   </tr>
   <tr>
         <th><font size="5">가격</font></th>
         <td><input type="text" name="br_price" placeholder="숫자만 기입해주세요"style="width:200px;height:30px;text-align: center;"/></td>
   </tr>
   <tr>
         <th><font size="5">게시자</font></th><!-- 이름이 뜨지만 실제로 id값이 전달됩니다. -->
         <td>
         	<%=member.getMb_name() %>
         	<input type="hidden" name="mb_id" value="<%=member.getMb_id() %>" style="size:6pt;"/>
         </td>
      </tr>
   
   <tr>
      <th><font size="5">내용</font></th>
      <td><textarea name="br_content" rows="5" cols="50" ></textarea></td>
   </tr>
   <tr>
      <th><font size="5">첨부파일</font></th>
      <td><input type ="file" name = "upFile" accept=".gif, .jpg, .png .jpeg"/></td>
   </tr>
   <tr>
      <td colspan="2" align="center" style="text-align:center;">    <!-- 두칸을 하나로 합침 -->
          <input type="submit" value="작성 완료" class="submit11" formaction="boardInsert.do" style="width:70px;height:40px;font-size:12px;"/>
         <input type="submit" value="메인으로" formaction="boardMain.do" class="reset12" style="width:70px;height:40px;font-size:12px;"/>
      </td>
   </tr>
</table>
</div>
</form>
</body>
</html>