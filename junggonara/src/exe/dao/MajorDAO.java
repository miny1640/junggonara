package exe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import exe.entity.MajorEntity;


public class MajorDAO extends CommonDAO {
	public ArrayList<MajorEntity> selectAll(){
		ArrayList<MajorEntity> list = new ArrayList<MajorEntity>();
		String query = "select * from jg_major";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			rs = stmt.executeQuery();

			while (rs.next()) {
				MajorEntity major = new MajorEntity();
				major.setM_code(rs.getString("m_code"));
				major.setM_name(rs.getString("m_name"));
				list.add(major);
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
	public int countMajor() {
		int totalRow = 0;
		
		String query = 	"select count(*) from jg_major";

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
	public boolean insert(MajorEntity major) {
		boolean result = false;
		int tmp = 0;
		String query = "insert into jg_major values(?, ?)";
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, major.getM_code());
			stmt.setString(2, major.getM_name());
			
			
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
