package exe.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBUtil {
	public static void close(Connection con) {
		if(con != null) {
			try{
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(Statement stmt) {
		if(stmt != null) {
			try{
				stmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}	
	
	public static void close(ResultSet rs) {
		if(rs != null) {
			try{
				rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}	
}
