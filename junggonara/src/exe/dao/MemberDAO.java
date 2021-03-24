package exe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import exe.entity.MemberEntity;

public class MemberDAO extends CommonDAO {
	
	public MemberEntity login(int mb_id) {//로그인
		MemberEntity member = null;
		
		String query = "select * from jg_member where mb_id = ? ";//and mb_pw = ?";
		Connection con=null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt=con.prepareStatement(query);
			stmt.setInt(1, mb_id);
//			stmt.setString(2, mb_pw);
			rs = stmt.executeQuery();
			if(rs.next()) {
				member = new MemberEntity();
				member.setMb_id(rs.getInt("mb_id"));
				member.setMb_pw(rs.getString("mb_pw"));
				member.setMb_name(rs.getString("mb_name"));
				member.setDept_code(rs.getString("dept_code"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return member;
	}

	public boolean insert(MemberEntity member) {//회원가입
		boolean result=false;
		int tmp=0;
		String query = "insert into jg_member values(?,?,?,?)";
		Connection con =null;
		PreparedStatement stmt = null;
		
		try {
			con= ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setInt(1, member.getMb_id());
			stmt.setString(2, member.getMb_name());
			stmt.setString(3, member.getDept_code());
			stmt.setString(4, member.getMb_pw());
			
			tmp = stmt.executeUpdate();
			if(tmp == 0) {
				result = false;
			}else {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(stmt);
			close(con);
		}
		return result;
	}
	
	public MemberEntity select(int mb_id) { //비번찾기,작성자,사용자이름 출력 등 사용
		MemberEntity member = null;
		
		String query = "select * from jg_member where mb_id = ?";
		
		Connection con=null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt=con.prepareStatement(query);
			stmt.setInt(1, mb_id);
			rs = stmt.executeQuery();
			if(rs.next()) {
				member = new MemberEntity();
				member.setMb_id(rs.getInt("mb_id"));
				member.setMb_pw(rs.getString("mb_pw"));
				member.setMb_name(rs.getString("mb_name"));
				member.setDept_code(rs.getString("dept_code"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return member;
	}

	public boolean update(MemberEntity member) {
		boolean result = false;
		String query = "update jg_member set mb_pw = ? where mb_id = ?";
		int tmp = 0;
		
		Connection con =null;
		PreparedStatement stmt =null;
		
		try {
			con =ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, member.getMb_pw());
			stmt.setInt(2, member.getMb_id());
			
			tmp = stmt.executeUpdate();
			if(tmp == 0) {
				result = false;
			}else {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(stmt);
			close(con);
		}
		return result;
	}
}