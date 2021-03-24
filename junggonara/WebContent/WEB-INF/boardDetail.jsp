<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exe.dao.BoardDAO"%>
<%@page import="exe.dao.CommentDAO"%>
<%@page import="exe.entity.CommentEntity"%>
<%@page import="exe.dao.MemberDAO"%>
<%@page import="exe.entity.DepartmentEntity"%>
<%@page import="exe.dao.DepartmentDAO"%>
<%@page import="exe.dao.BookDAO"%>
<%@page import="exe.entity.BookEntity"%>
<%@page import="exe.entity.MemberEntity"%>
<%@page import="exe.entity.BoardEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	BoardEntity board = (BoardEntity)request.getAttribute("board");
%>
<title><%= board.getBr_title() %> : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
<link rel="stylesheet" type="text/css" href="css/boardDetailCSS.css" />
<link rel="stylesheet" type="text/css" href="css/basicbutton.css" />

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<link rel = "stylesheet" href = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.indigo-pink.min.css">
<link rel = "stylesheet" href = "https://fonts.googleapis.com/icon?family=Material+Icons">
<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script src = "https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
</head>
<body>
<%
	MemberEntity member = (MemberEntity)session.getAttribute("member");
	String pg = request.getParameter("page");
	String ref = request.getParameter("ref");
		
	int curPage = 1;
	
	if (pg!= null){
		curPage = Integer.parseInt(pg);
		System.out.println("현재페이지 : "+curPage);
	}
	int scope = 15;
	int pageScope = 10;
	//Boardthree boardDAO select 참고
	int startNum = (curPage - 1) * scope + 1;
	CommentDAO comment_dao = new CommentDAO();
	MemberDAO member_dao = new MemberDAO();
	
	ArrayList<CommentEntity> list = new ArrayList<CommentEntity>();
	list  = comment_dao.select(board.getBr_num(), startNum, scope, ref);
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

						<!-- 메인으로, 수정, 삭제 버튼 -->  
<div align="center" style="width: 800px;height: 100%;position: relative;left: 25%;bottom: 50px;">
<div id="table under" align="right" style="position: relative;top:20px;">
				[<a href="boardMain.do">메인으로</a>]&nbsp;&nbsp;
<%
	if(board.getPurchase_done().equals("X")&&board.getMb_id() == member.getMb_id()){
		if(board.getSale_purchase().equals(" ")){
%>

<%
		}else if(board.getSale_purchase().equals("s")){//판매글이면 구매하기 버튼이 있어야하고
%>
				[<a href="purchase.do?br_num=<%=board.getBr_num() %>">거래완료</a>]&nbsp;&nbsp;
<%
		}else if(board.getSale_purchase().equals("p")){//구매글이면 판매하기 버튼이 있어야함.
%>
				[<a href="sale.do?br_num=<%=board.getBr_num() %>">거래완료</a>]&nbsp;&nbsp;<!-- 차후 기능구현해야할 부분 -->
<%
		}
	}else if(board.getPurchase_done().equals("O")&&board.getMb_id() == member.getMb_id()){
%>
				[<a href="tradeCancle.do?br_num=<%=board.getBr_num() %>">거래취소</a>]&nbsp;&nbsp;
<%
	}
	if(board.getMb_id() == member.getMb_id()){
%>
				[<a href="boardUpdateForm.do?br_num=<%=board.getBr_num() %>">수정</a>]&nbsp;&nbsp;
				[<a href="boardDelete.do?br_num=<%=board.getBr_num() %>">삭제</a>]
<%
	}
%>
</div>

						<!-- 날짜, 조회수 테이블 -->
<div align="left">
	<table>
		<tr style="text-align:center;text-size:50pt;" height="10">
			<th>글번호&nbsp;</th>
			<td><%= board.getBr_num() %>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<th>작성일&nbsp;</th>
			<td><%= board.getWrite_date() %>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<th>조회수&nbsp;</th>
			<td><%= board.getHit() %></td>
		</tr>
	</table>
</div>

<div align="center" >
<table border="1"  style="width: 800px;height: 600px;">
		<tr style="text-align:center;"height="40" >
				<th colspan="2">제목</th>
				<td colspan="7"><%= board.getBr_title() %></td>
				<th>게시자</th>
<%
	MemberDAO memberDAO = new MemberDAO();
%>
				<td colspan="2"><%= memberDAO.select(board.getMb_id()).getMb_name() %></td><!-- 게시자 이름 출력 -->
				<th style="width:100px">판매/구입</th>
<%
	if(board.getSale_purchase().equals(" ")){
%>
				<td style="width:100px"></td>
<%
	}else if(board.getSale_purchase().equals("s")){
%>
				<td style="width:100px">판매글</td>
<%
	}else if(board.getSale_purchase().equals("p")){
%>
				<td style="width:100px">구매글</td>
<%
	}
	BookDAO bookDAO = new BookDAO();
	BookEntity book = bookDAO.selectBook(board.getBk_code());
	DepartmentDAO deptDAO = new DepartmentDAO();
	DepartmentEntity dept = deptDAO.selectDept(book.getDept_code());
%>
		</tr>
		<tr style="text-align:center;"height="40">
				<th colspan="2">책 이름</th>
<%
		if(book.getBk_title() == null){
%>
				<td colspan="7"></td>
<%
		}else{
%>
				<td colspan="7"><%= book.getBk_title() %></td><!-- 교제 이름 출력 -->
<%
		}
%>
				<th>학과</th>
<%
		if(dept.getDept_name() == null){
%>
				<td colspan="2"></td>
<%
		}else{
%>
				<td colspan="2"><%= dept.getDept_name() %></td><!-- 교제관련 학과 출력 -->
<%
		}
%>
				<th>가격</th>
				<td colspan="2"><%= board.getBr_price() %>원</td>
		</tr>	
		<tr style="text-align:center;">
				<th colspan="2">내용</th>
<%
		if(board.getBr_content() == null){
%>
				<td colspan="12" style="width:600px;height:600px;">
<%
			if(board.getUpFile() == null){
%>
<%
			}else{
%>
					<img alt="" src="download/<%= board.getUpFile() %>" width="100px" height="150px" >
<%
			}
%>
				</td>
<%
		}else{
%>
				<td colspan="12" style="width:600px;height:600px;">
<%
			if(board.getUpFile() == null){
%>
<%
			}else{
				System.out.println(board.getUpFile());
%>
					<img alt="" src="download/<%= board.getUpFile() %>" width="270px" height="360px"><br/>	<!-- 사진크기 조절 3:4 비율로 -->
<%
			}
%>
				<br/>
					<font style="font-size: medium;"><%= board.getBr_content().replaceAll("\n","<br/>") %></font>  
				</td>	
<%
		}
%>
		</tr>
</table>

		
								<!-- 댓글 테이블 -->
<%
	String flag = request.getParameter("flag");
	if(flag == null){
		flag="0";
	}
	if(flag.equals("1")){
		String cm_no = request.getParameter("cm_no");
		CommentEntity receiver = comment_dao.selectComment(cm_no);
		int maxPosition = comment_dao.maxPosition(receiver.getRef());
%>
								<!-- 대댓글 다는곳 -->
[<%=memberDAO.select(receiver.getMb_id()).getMb_name() %>]님에게 대댓글을 다는 중입니다...
<a href="boardDetail.do?br_num=<%=board.getBr_num() %>">취소</a>
<br/>
<form action="boardReplyAnswer.do" method="post">
	<table style="width:790px;" border="1" >
		<tr align="right">
             <th><input type="text" placeholder="댓글을 입력하세요. " name="comment" style="width:743px;height:40px;"/>
             		비밀댓글&nbsp;<input type="checkbox" name="secret" value="O" style="width:15px;height:15px;"/>
             </th>
           <th><input type="submit" class="button11" value="등록" style="width:45px;height:40px;"></th>
        </tr>
	</table>
	<input type="hidden" name="position" value="<%=maxPosition%>"/>
	<input type="hidden" name="ref" value="<%=receiver.getRef()%>"/>
	<input type="hidden" name="br_num"  value="<%=board.getBr_num()%>"/>
</form>
<%
	}else{
%>
<br/>
<form action="boardReply.do" method="post" style="position: relative;bottom: 20px;">
	<table style="width:790px" border="1">
		<tr align="right">
             <th><input type="text" placeholder="댓글을 입력하세요. " name="comment" style="width:743px;height:40px;"/>
             		비밀댓글&nbsp;<input type="checkbox" name="secret" value="O" style="width:15px;height:15px;"/>
             </th>
             <td><input type="submit" class="button11" value="등록" style="width:45px;height:40px;" /></td>
        </tr>
	</table>
	<input type="hidden" name="br_num" value="<%=board.getBr_num()%>"/>
</form>
<%
	}
%>

<%
		if( list.size() > 0 ){
%>
<table class="mdl-shadow--2dp" style="width: 800px;">
<%
			for(CommentEntity comment : list) {
%>
			<tr> 		<!-- 댓글 번호 -->  <!-- 댓글 작성자 -->
				 <th><!-- <%= comment.getCm_no() %> &nbsp;&nbsp; -->
<%
				if(comment.getMb_id() == board.getMb_id()){
%>
				<font color=pink><%= memberDAO.select(comment.getMb_id()).getMb_name() %></font>
<%
				}else if(comment.getMb_id() == member.getMb_id()){
%>
				<font color=blue><%= memberDAO.select(comment.getMb_id()).getMb_name() %></font>
<%					
				}else{
%>
				<%= memberDAO.select(comment.getMb_id()).getMb_name() %>
<%
				}
%>
				</th>
				<th colspan="3" style="text-align: right;"><%= comment.getWrite_date() %></th> 	<!-- 댓글 작성날짜 -->
			</tr>
			<tr>
<%
				if(comment.getSecret().equals("O") && board.getMb_id() == member.getMb_id()){
%>
				<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;[비밀 댓글]<%= comment.getCm_content() %><td> 	<!-- 비밀댓글 내용 -->
<%
				}else if(comment.getSecret().equals("O") && comment.getMb_id() == member.getMb_id()){
%>
				<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;[비밀 댓글]<%= comment.getCm_content() %><td> 	<!-- 비밀댓글 내용 -->
<%
				}else if(comment.getSecret().equals("O")){
%>
				<td colspan="2"><font color=blue><I>&nbsp;&nbsp;&nbsp;&nbsp;[비밀 댓글 입니다.]</I></font><td>	<!-- 이거 색깔 입혀주세요~! -->
<%
				}else{
%>
				<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<%= comment.getCm_content() %><td> 	<!-- 댓글 내용 -->
<%					
				}
%>
				<td colspan="2" style="text-align: right;">
<%
		if(comment.getPosition() == 0){
			if(comment_dao.maxPosition(comment.getRef())>0){
				if(ref == null){
%>
					<a href="boardDetail.do?br_num=<%=board.getBr_num() %>&ref=<%=comment.getRef() %>">
						[대화보기]
					</a>
<%
				}else if(Integer.parseInt(ref) == comment.getRef()){
%>
					<a href="boardDetail.do?br_num=<%=board.getBr_num() %>">
						[닫기]
					</a>
<%
				}else{
%>
					<a href="boardDetail.do?br_num=<%=board.getBr_num() %>&ref=<%=comment.getRef() %>">
						[대화보기]
					</a>	
<%
				}
			}
%>
					<a href="boardDetail.do?br_num=<%=board.getBr_num() %>&cm_no=<%=comment.getCm_no() %>&flag=<%=1%>&ref=<%=comment.getRef() %>">
						[답글달기]
					</a>
<%
		}
		if(comment.getMb_id() == member.getMb_id()){
%>
					<a href="boardReplyDelete.do?br_num=<%=board.getBr_num() %>&cm_no=<%=comment.getCm_no() %>&maxPosition=<%=comment_dao.maxPosition(comment.getRef()) %>&position=<%=comment.getPosition() %>">
						[삭제]
					</a>
<%
		}else{
%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
		}
%>
				</td>
			</tr>
<%
			}
%>
</table>

<!--  페이지 넘버 -->
<%
	int cm_totalRow =comment_dao.cm_totalRow(board.getBr_num(),ref);
	int totalPage = (cm_totalRow - 1) / scope + 1;
	//페이지 시작 번호
	int startPageNum = ((curPage-1) / pageScope) * pageScope + 1;
%>
<div class="list_number" style="position:relative;">
    <div>
        <div class="list_n_menu">
 <%
 		if (startPageNum>1){
 %>
 <a href="boardDetail.do?page=<%=1%>&br_num=<%=board.getBr_num() %>&ref=<%=ref %>">◀◀</a> 
 <a href="boardDetail.do?page=<%=startPageNum - 1%>&br_num=<%=board.getBr_num() %>&ref=<%=ref %>">◀ 이전 </a> 
<%
 		}
 		for (int i = startPageNum; i < (startPageNum + pageScope); i++){
 			if (i> totalPage) {
 				break;
 			}
 			if (curPage ==i){
%>
		<font color="red"><b>[ <%=i%> ]</b></font> 
<%
 			}else{
%>
 			[<a href="boardDetail.do?page=<%=i%>&br_num=<%=board.getBr_num() %>&ref=<%=ref %>"><%=i%></a> ]
<%
 			}
 		}
 		if ( startPageNum + pageScope <= totalPage){
%>
		<a href="boardDetail.do?page=<%=startPageNum + pageScope%>&br_num=<%=board.getBr_num() %>&ref=<%=ref %>">&gt;</a>
		<a href="boardDetail.do?page=<%=totalPage%>&br_num=<%=board.getBr_num() %>&ref=<%=ref %>">&gt;&gt;</a> 
<%
 		}
%>
		</div>
	</div>
</div>
<%
		}else{ 
%>
<table class="mdl-shadow--2dp" style="width: 800px;">
		<tr>
			<td>댓글이 없습니다.</td>
		</tr>
</table>	
<%
		}
%>
</div>
</div>
</body>
</html>