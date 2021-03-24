package exe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import exe.entity.DepartmentEntity;

public class DepartmentDAO extends CommonDAO {
	public ArrayList<DepartmentEntity> selectAll(){
		ArrayList<DepartmentEntity> list = new ArrayList<DepartmentEntity>();
		String query = "select * from jg_department";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			rs = stmt.executeQuery();

			while (rs.next()) {
				DepartmentEntity dept = new DepartmentEntity();
				dept.setDept_code(rs.getString("dept_code"));
				dept.setDept_name(rs.getString("dept_name"));
				dept.setM_code(rs.getString("m_code"));
				list.add(dept);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	public DepartmentEntity selectDept(String dept_code){
		DepartmentEntity department = new DepartmentEntity();
		String query = "select * from jg_department where dept_code = ?";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, dept_code);
			rs = stmt.executeQuery();

			while (rs.next()) {
				department.setDept_code(rs.getString("dept_code"));
				department.setDept_name(rs.getString("dept_name"));
				department.setM_code(rs.getString("m_code"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return department;
	}
	public ArrayList<DepartmentEntity> select(String m_code){//�а��� å���� �������� ���
		ArrayList<DepartmentEntity> list = new ArrayList<DepartmentEntity>();
		String query="select * from jg_department where m_code = ?";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, m_code);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				DepartmentEntity dept = new DepartmentEntity();
				dept.setDept_code(rs.getString("dept_code"));
				dept.setDept_name(rs.getString("dept_name"));
				dept.setM_code(rs.getString("m_code"));
				
				list.add(dept);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	public int countDepartment() {
		int totalRow = 0;
		
		String query = 	"select count(*) from jg_department";

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			
			rs = stmt.executeQuery();
			rs.next();
			
			totalRow = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}

		return totalRow;
	}
	public boolean insert(DepartmentEntity dept) {
		boolean result = false;
		int tmp = 0;
		String query = "insert into jg_department values(?, ?, ?)";
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, dept.getDept_code());
			stmt.setString(2, dept.getDept_name());
			stmt.setString(3, dept.getM_code());
			
			
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