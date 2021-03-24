<%@page import="exe.dao.DepartmentDAO"%>
<%@page import="exe.entity.DepartmentEntity"%>
<%@page import="exe.dao.MajorDAO"%>
<%@page import="exe.entity.MajorEntity"%>
<%@page import="exe.dao.MemberDAO"%>
<%@page import="exe.entity.BoardEntity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exe.dao.BoardDAO"%>
<%@page import="exe.entity.MemberEntity"%>
 <%@page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" type="text/css" href="css/boardMainCSS.css" />
<link rel="stylesheet" type="text/css" href="css/button.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
<script type = "text/javascript">
         function showMessage(value) {
            document.getElementById("message").innerHTML  =  value;
         }
  		function test(code, mode) {
 			var form = document.getElementById("test");
 			
 			form.action="boardMain.do?sale_purchase=" + mode + "&dept_code=" + code;
			form.submit();
 		}
</script>
<style>
.sold { background-color:#A4A4A4; }
</style>
 

</head>
<body>

		<!-- 공통 인터페이스(상단바(로고 포함), 목차, 로그인·회원가입) -->
<%
		request.setCharacterEncoding("utf-8");
		MemberEntity member = (MemberEntity)session.getAttribute("member");
		String sale_purchase = request.getParameter("sale_purchase");
		String dept_code = request.getParameter("dept_code");
		String keyword = request.getParameter("keyword");
		String pg = request.getParameter("page");
		
		if(sale_purchase == null){
			sale_purchase = "";
		}
		if(dept_code == null){
			dept_code = "";
		}
		if (keyword == null) {
			keyword = "";
		}
		int curPage = 1; //한페이지에 게시물 시작번호(rnum)

		if (pg != null) {
			curPage = Integer.parseInt(pg);
		}
		int scope = 10; //한페이지에 보이는 게시물의 개수
		int pageScope = 5; //한페이지에 보이는 페이지의 개수

		int startNum = (curPage - 1) * scope + 1;
		BoardDAO board_dao = new BoardDAO();
		MemberDAO member_dao = new MemberDAO();
		
		ArrayList<BoardEntity> list = new ArrayList<BoardEntity>();//게시판글 볼수 잇도록 하기
		list  = board_dao.selectAll(keyword, startNum, scope, dept_code, sale_purchase);
		
		
%>
		<!-- 상단 바 -->
<div class="demo-layout-waterfall mdl-layout mdl-js-layout">
  <header class="mdl-layout__header mdl-layout__header--waterfall">
    <div class="mdl-layout__header-row">
      <span class="mdl-layout-title">
      	<a href="boardMain.do"><img src = "image/main2.png" width="220" height="180" style="position:absolute; top:-45px; left:590px;"/></a>
      </span>
    <div class="mdl-layout-spacer"></div>
    </div>
    
<%
	if( member != null ){	
%>
		<!-- 로그인, 회원가입 -->
    <div class="mdl-layout__header-row">
    <div class="mdl-layout-spacer"></div>
      <nav class="mdl-navigation">		
      	<%=member.getMb_name() %>님
<%
	if(member.getMb_id()==0&&member.getMb_pw().equals("0")){
%>
		<a class="mdl-navigation__link" href="manager.do" style="padding: 10px;">관리자페이지</a>
<%
	}
%>
      	<a class="mdl-navigation__link" href="myPage.do" style="padding: 10px;">마이페이지</a>
		<a class="mdl-navigation__link" href="logout.do" style="padding: 10px;">로그아웃</a>
      </nav>
    </div>
<%
	}else{
%>
    <div class="mdl-layout__header-row">
    <div class="mdl-layout-spacer"></div>
      <nav class="mdl-navigation">
      	<a class="mdl-navigation__link" href="loginForm.do">로그인</a>
      	<a class="mdl-navigation__link" href="memberInsertForm.do">회원가입</a>
      </nav>
    </div>	
<%
	}
%>
  </header>
</div>
		<!-- 목차 -->
<%
 java.util.Date now = new java.util.Date();
 SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
 
 String today = sf.format(now);
 System.out.println(today);
%>		
		
<%
	ArrayList<MajorEntity> majorList = new ArrayList<MajorEntity>();
	MajorDAO majorDAO = new MajorDAO();
	majorList = majorDAO.selectAll();
	ArrayList<DepartmentEntity> deptList = new ArrayList<DepartmentEntity>();
	DepartmentDAO deptDAO = new DepartmentDAO();
%>
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header" style="position:absolute; top:130px; left:-20px;">
  <div class="mdl-layout__drawer">
<%
	if(majorList.size() == 0){
%>
	<span class="mdl-layout-title" style="text-align:left">NONE</span>	<!-- 짤리는 부분 -->
<%
	}else{
		for(MajorEntity major : majorList){
			deptList = deptDAO.select(major.getM_code());
%>
    <span class="mdl-layout-title" style="text-align:left"><%=major.getM_name() %></span>
    <nav class="mdl-navigation">
<%
			if(deptList.size() == 0){
%>
		<a class="mdl-navigation__link" style="text-align:right">NONE</a>	
<%
			}else{
				for(DepartmentEntity dept : deptList){
%>
		<a class="mdl-navigation__link" href="boardMain.do?dept_code=<%=dept.getDept_code() %>&sale_purchase=<%=sale_purchase %>" style="text-align:right"><%=dept.getDept_name() %></a>
<%
				}
			}
%>
    </nav>
<%
		}
	}
%>
  </div>
</div>

		<!-- 전체글 보기 버튼 -->
<div id="center" style="position:absolute; top:133px; right:230px;"><p>
	  <a href="boardMain.do"><button class="snip1535" >전체 글 보기</button></a>
</div>
		<!-- 새글 쓰기 버튼 -->
<div id="center" style="position:absolute; top:133px; right:80px;">
<%
		if( member != null ){
%>
	  <a href="boardInsertForm.do"><button class="snip1535" >새글 쓰기</button></a>		
<%
		}else{}
%>
</div>	

		<!-- 중앙 인터페이스(3라디오버튼, 글목록 테이블, 검색, 페이지넘버) -->

		<!-- 라디오버튼 -->
<div id="center" style="position:absolute; top:150px; left:320px;">
	<form id="test" method="post">
		<table>
			<tr>
            	<td>		<!-- 모두보기 버튼 --> 
               		<label class = "mdl-radio mdl-js-radio" for = "option1">
                  		<input type = "radio" id = "option1" name = "sale_purchase" 
                     			  class = "mdl-radio__button" onchange="test('<%=dept_code %>', '')" 
                     			  <%= (sale_purchase.equals("") ? "checked" : "") %>>
                  		<span class = "mdl-radio__label">모두보기</span>
               		</label>
            	</td>           
            	<td>		<!-- 판매만 보는 버튼 -->
               		<label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" 
               				  for = "option2">
                  		<input type = "radio" id = "option2" name = "sale_purchase"
                     			  class = "mdl-radio__button" onchange="test('<%=dept_code %>', 's')"
                     			  <%= (sale_purchase.equals("s") ? "checked" : "") %>>
                  		<span class = "mdl-radio__label">판매</span>
               		</label>
            	</td>         
            	<td>		<!-- 구입만 보는 버튼 -->
               		<label class = "mdl-radio mdl-js-radio" for = "option3">
                  		<input type = "radio" id = "option3" name = "sale_purchase"
                     		      class = "mdl-radio__button" onchange="test('<%=dept_code %>', 'p')"
                     			  <%= (sale_purchase.equals("p") ? "checked" : "") %>>
                  		<span class = "mdl-radio__label">구입</span>
               		</label>      
            	</td>
			</tr>
		</table>
	</form>
</div>

		<!-- 글목록 테이블 -->
<div id="center table" style="position:absolute; top:180px; left:280px;">
<%
	if(list.size() == 0){ 
%>
	<table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp" style="width:1150px;">
  	  <thead>
    	<tr>
      	  <th class="mdl-data-table__cell--non-numeric">제목</th>
		  <th>게시자</th>
      	  <th>판매/구입</th>
      	  <th>날짜</th>
     	</tr>
  	  </thead>
  	  <tbody>
  		<tr>
  		  <th colspan="3">검색된 데이터가 없습니다.</th>
  		</tr>
   	  </tbody>
	</table>

		<!-- 검색 -->
<div align="right" style="position:relative;top:5px;">
	<form action="boardMain.do" method="post">
		<input type="hidden" name="dept_code" value="<%=dept_code %>"/>
		<input type="hidden" name="sale_purchase" value="<%=sale_purchase %>"/>
		<input type="text" name="keyword" style="height:25px;" placeholder="          검색어 입력">
		<input type="submit" value="검색" style="background-color:white;" />
	</form>
</div>
<%
	}else{
%>
<table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp" style="width: 1150px;">
  <thead>
    <tr>
      <th class="mdl-data-table__cell--non-numeric">제목</th>
      <th>게시자</th>
      <th>판매/구입</th>
      <th>날짜</th>
    </tr>
  </thead>
  <tbody>
<%
		/* 게시물 정보받아서 테이블 표시 */
		for(BoardEntity board : list){
			if(board.getPurchase_done().equals("X")){	//아직 구매하지 않음
%>
    <tr>
      <td class="mdl-data-table__cell--non-numeric">
      	<a href="hitUpdate.do?br_num=<%=board.getBr_num()%>">
      		<%=board.getBr_title() %>
      	</a>
      </td>
      <td><%=member_dao.select(board.getMb_id()).getMb_name() %></td>
<%
	if(board.getSale_purchase().equals(" ")){
%>
		<td></td>
<%
	}else if(board.getSale_purchase().equals("p")){
%>
		<td>구매글</td>
<%
	}else if(board.getSale_purchase().equals("s")){
%>
		<td>판매글</td>
<%
	}
%>
   <%
    System.out.println( "==> " + board.getTime());
    %>
    <%
    if (today.equals(sf.format(board.getWrite_date()))){
    	System.out.println("--> " + board.getTime());
    %>
      <td><%= board.getTime() %></td>
    <%
    } else {
    	System.out.println("--> " + board.getWrite_date());
%>
     <td><%= board.getWrite_date() %></td>
<%
    }
    %>
    </tr>
    <%
    
    %>

<%
			}else{
%>
   <tr class="sold">
      	<td class="mdl-data-table__cell--non-numeric sold">
      		<a href="boardDetail.do?br_num=<%=board.getBr_num()%>">
      			<%=board.getBr_title() %>
      		</a>
      	</td>
      	<td class="sold"><%=member_dao.select(board.getMb_id()).getMb_name() %></td>
		<td class="sold">
			거래완료
		</td>
		  <%System.out.println(board.getWrite_date());%>
		<td class="sold"><%= board.getWrite_date() %></td>
    </tr>
<%
			}
		}
%>
  </tbody>
</table>
							<!-- 검색 -->
<div align="right" style="position:relative;top:5px;">
	<form action="boardMain.do" method="post">
		<input type="hidden" name="dept_code" value="<%=dept_code %>"/>
		<input type="hidden" name="sale_purchase" value="<%=sale_purchase %>"/>
		<input type="text" name="keyword" style="height:25px;width: 240px;text-align: center; " placeholder="제목 / 작성자 / 책이름 입력">
		<input type="submit" value="검색" style="background-color:white;" />
	</form>
</div>

							<!-- 페이지넘버 -->
<%
	int totalRow = board_dao.totalRow(keyword, dept_code, sale_purchase);
	int totalPage = (totalRow - 1) / scope + 1;

	//페이지 시작 번호
	int startPageNum = ((curPage - 1) / pageScope) * pageScope + 1;
%>
<div class="list_number" style="position:relative;">
    <div>
        <div class="list_n_menu">
<%
		if (startPageNum > 1) {
%> 
		<a href="boardMain.do?page=<%=1%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">◀◀</a> 
		<a href="boardMain.do?page=<%=startPageNum - 1%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">◀ 이전 </a> 
<%
		}
		for (int i = startPageNum; i < (startPageNum + pageScope); i++) {
			if (i > totalPage) {
				break;
			}
			if (curPage == i) {
%>
		<font color="red"><b>[ <%=i%> ]</b></font> 
<%
			}else{
%>
				[ <a href="boardMain.do?page=<%=i%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>"><%=i%></a> ]
<%
			}
		}
		if (startPageNum + pageScope <= totalPage) {
%>
		<a href="boardList.jsp?page=<%=startPageNum + pageScope%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">&gt;</a>
		<a href="boardList.jsp?page=<%=totalPage%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">&gt;&gt;</a> 
<%
 		}
%>
        </div>
    </div>
</div>
<%
	}
 %>
</div>
</body>
</html>