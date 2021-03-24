<%@page import="exe.dao.DepartmentDAO"%>
<%@page import="exe.entity.DepartmentEntity"%>
<%@page import="exe.dao.MajorDAO"%>
<%@page import="exe.entity.MajorEntity"%>
<%@page import="exe.dao.MemberDAO"%>
<%@page import="exe.entity.BoardEntity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exe.dao.BoardDAO"%>
<%@page import="exe.entity.MemberEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" type="text/css" href="css/boardMainCSS.css" />
<link rel="stylesheet" type="text/css" href="css/button.css"/>
<link rel="stylesheet" type="text/css" href="css/mypageCSS.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
<style>
.sold { background-color:#A4A4A4; }
</style>
</head>
<body>

<!-- 메인 페이지 부분 -->
<%
        request.setCharacterEncoding("utf-8");
		MemberEntity member = new MemberEntity();
		member = (MemberEntity)session.getAttribute("member");
		String sale_purchase = request.getParameter("sale_purchase");
		String dept_code = request.getParameter("dept_code");
		String keyword = request.getParameter("keyword");
		String pg = request.getParameter("page");
		String mb_name =  member.getMb_name(); 
		int mb_id = member.getMb_id();
		System.out.println(mb_id);
		
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
		list  = board_dao.my_select(keyword, startNum, scope, dept_code, sale_purchase, mb_id);
		System.out.println(list);
		System.out.println(keyword);
%>
<!-- 상단 바 -->
<div class="demo-layout-waterfall mdl-layout mdl-js-layout">
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
      		<a class="mdl-navigation__link" href="boardMain.do" style="padding: 10px;">메인으로</a>
      		<a class="mdl-navigation__link" href="logout.do" style="padding: 10px;">로그아웃</a>
      </nav>
    </div>
<%
	}
%>
  </header>
</div>
<%
	ArrayList<MajorEntity> majorList = new ArrayList<MajorEntity>();
	MajorDAO majorDAO = new MajorDAO();
	majorList = majorDAO.selectAll();
	ArrayList<DepartmentEntity> deptList = new ArrayList<DepartmentEntity>();
	DepartmentDAO deptDAO = new DepartmentDAO();
%>

    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-drawer
            mdl-layout--fixed-header" style="position:relative; top:128px; left:-20px;">
  <div class="mdl-layout__drawer">
  <nav class="mdl-navigation">
<br/><br/>
	<a class="mdl-navigation__link" href="myPage.do" style="text-align:right;font-size: x-large;">회원정보</a>
<br/><br/>
	<a class="mdl-navigation__link" href="mywriting.do" style="text-align:right;font-size: x-large;">내가 쓴 글</a>
  </nav>
  </div>
</div>


<!-- 새글 쓰기 -->
<div id="center" style="position:absolute; top:133px; right:80px;">
<%
		if( member != null ){
%>
	  <a href="boardInsertForm.do"><button class="snip1535" >새글 쓰기</button></a>		
<%
		}
%>
</div>	

								<!--  중앙 게시글 vi 삭제 -->

								<!-- 중앙 테이블 -->
<div id="center table" style="position:absolute; top:180px; left:280px;">
<%
	if(list.size() == 0){ 
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
  	<tr>
  		<th colspan="3">검색된 데이터가 없습니다.</th>
  	</tr>
   </tbody>
</table>

<!-- 검색 -->
<div align="right" style="position:relative;top:5px;">
<form action="mywriting.do" method="post">
		<input type="hidden" name="dept_code" value="<%=dept_code %>"/>
		<input type="hidden" name="sale_purchase" value="<%=sale_purchase %>"/>
		<input type="text" name="nb_name" style="height:25px;" placeholder="          검색어 입력">
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
		for(BoardEntity board : list){
			if(board.getPurchase_done().equals("X")){
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
		<td><%= board.getWrite_date() %></td>
    </tr>
<%
			}else{
%>
   <tr class="sold"><!-- 이 목록은 흐려지게 만들어야함~~ -->
      	<td class="mdl-data-table__cell--non-numeric sold">
      		<a href="boardDetail.do?br_num=<%=board.getBr_num()%>">
      			<%=board.getBr_title() %>
      		</a>
      	</td>
      	<td class="sold"><%=member_dao.select(board.getMb_id()).getMb_name() %></td>
		<td class="sold">
			거래완료
		</td>
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
<form action="mywriting.do" method="post">
		<input type="hidden" name="dept_code" value="<%=dept_code %>"/>
		<input type="hidden" name="sale_purchase" value="<%=sale_purchase %>"/>
		<input type="text" name="keyword" style="height:25px;" placeholder="          검색어 입력">
		<input type="submit" value="검색" style="background-color:white;" />
</form>
</div>

							<!-- 페이지넘버 -->
<%
	int totalRow = board_dao.my_totalRow(keyword, dept_code, sale_purchase, mb_id);
    System.out.println(totalRow);
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
		<a href="mywriting.do?page=<%=1%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">◀◀</a> 
		<a href="mywriting.do?page=<%=startPageNum - 1%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">◀ 이전 </a> 
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
				[ <a href="mywriting.do?page=<%=i%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>"><%=i%></a> ]
<%
			}
		}
		if (startPageNum + pageScope <= totalPage) {
%>
		<a href="mywriting.do?page=<%=startPageNum + pageScope%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">&gt;</a>
		<a href="mywriting.do?page=<%=totalPage%>&sale_purchase=<%=sale_purchase %>&dept_code=<%=dept_code %>&keyword=<%=keyword %>">&gt;&gt;</a> 
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