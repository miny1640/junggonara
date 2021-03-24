<%@page import="exe.entity.DepartmentEntity"%>
<%@page import="exe.entity.MajorEntity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exe.dao.MajorDAO"%>
<%@page import="exe.dao.DepartmentDAO"%>
<%@page import="exe.dao.BookDAO"%>
<%@page import="exe.entity.MemberEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 : 중고나라</title>
<link rel="shortcut icon" href="image/main4.png">
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
<body>
<%
	request.setCharacterEncoding("utf-8");
	MemberEntity member = new MemberEntity();
	member = (MemberEntity)session.getAttribute("member");
	String flag = request.getParameter("flag");
	if(flag == null){
		flag="0";
	}
	
	BookDAO bookDAO = new BookDAO();
	
	if(member.getMb_id()==0&&member.getMb_pw().equals("0")){
%>
<div align="center">
		<h1>-- 관리자 창 --</h1>
<form method="post">
	<table>
		<tr>
			<td><a href="manager.do?flag=<%=1%>">[학부 추가]</a></td>
			<td><a href="manager.do?flag=<%=2%>">[학과 추가]</a></td>
			<td><a href="manager.do?flag=<%=3%>">[책 추가]</a></td>
		</tr>
<%
	if(flag.equals("1")){
%>
		<tr>
			<td colspan="3"><h2>학부 추가</h2></td>
		</tr>
		<tr>
			<td>학부 코드</td>
			<td colspan="2">
				<input type="text" name="m_code" value="m<%=majorDAO.countMajor()+1%>"/>
			</td>
		</tr>
		<tr>
			<td>학부 이름</td>
			<td colspan="2">
				<input type="text" name="m_name"/>
			</td>
		</tr>
		<tr>
			<td><input type="submit" value="추가" formaction="majorInsert.do"></td>
			<td><input type="submit" value="취소" formaction="manager.do"></td>
			<td><input type="submit" value="메인으로" formaction="boardMain.do"></td>
		</tr>
<%
	}else if(flag.equals("2")){
%>
		<tr>
			<td colspan="3"><h2>학과 추가</h2></td>
		</tr>
		<tr>
			<td>학부 선택</td>
<%
	if(major_list.size()==0){//DB에 저장되어 있는 학부를 못찾거나 없으면 NONE
%>
			<td>NONE</td>
<%
	}else{//DB에 저장되어 있는 학부 정보를 이용하여 학부선택 학부를 직접 적어서 작성할 필요가 없다.
%> 
			<td>      <!-- 학부선택 -->
				<select name="m_code">
					<option>학부를 선택하세요</option>
<%
		for(MajorEntity major : major_list){
%>               
					<option value="<%=major.getM_code()%>"><%=major.getM_name() %></option>
<%
		}
%>
				</select>
			</td>
<%
	}
%>
		</tr>
		<tr>
			<td>학과 코드</td>
			<td colspan="2">
				<input type="text" name="dept_code" value="d<%=deptDAO.countDepartment()+1%>"/>
			</td>
		</tr>
		<tr>
			<td>학과 이름</td>
			<td colspan="2">
				<input type="text" name="dept_name"/>
			</td>
		</tr>
		<tr>
			<td><input type="submit" value="추가" formaction="deptInsert.do"></td>
			<td><input type="submit" value="취소" formaction="manager.do"></td>
			<td><input type="submit" value="메인으로" formaction="boardMain.do"></td>
		</tr>
<%
	}else if(flag.equals("3")){
%>
		<tr>
			<td colspan="3"><h2>책 추가</h2></td>
		</tr>
		<tr>
			<td>학부 선택</td>
<%
	if(major_list.size()==0){//DB에 저장되어 있는 학부를 못찾거나 없으면 NONE
%>
			<td>NONE</td>
<%
	}else{//DB에 저장되어 있는 학부 정보를 이용하여 학부선택 학부를 직접 적어서 작성할 필요가 없다.
%> 
			<td>      <!-- 학부선택 -->
				<select id="m_code" name="m_code" onchange="itemChange(this.value)">
					<option value="0">학부를 선택하세요</option>
<%
		for(MajorEntity major : major_list){
%>               
					<option value="<%=major.getM_code()%>"><%=major.getM_name() %></option>
<%
		}
%>
				</select>
			</td>
<%
	}
%>
		</tr>
		<tr>
			<td>학과 이름</td>
			<td>
				<select id="dept_code" name="dept_code">
					<option value="0">학과를 선택하세요</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>책 코드</td>
			<td colspan="2">
				<input type="text" name="bk_code" value="b<%=bookDAO.countBook()+1%>"/>
			</td>
		</tr>
		<tr>
			<td>책 이름</td>
			<td colspan="2">
				<input type="text" name="bk_title"/>
			</td>
		</tr>
		<tr>
			<td><input type="submit" value="추가" formaction="bookInsert.do"></td>
			<td><input type="submit" value="취소" formaction="manager.do"></td>
			<td><input type="submit" value="메인으로" formaction="boardMain.do"></td>
		</tr>
<%
	}
%>
	</table>
</form>
</div>
<%
	}else{
%>
		<a href="boardMain.do">메인으로</a>
<%
	}
%>
</body>
</html>