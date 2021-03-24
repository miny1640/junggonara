package exe.dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommonDAO extends DBUtil{
	DataSource ds;
	public CommonDAO() {
		try {
			Context ct = new InitialContext();
			ds = (DataSource)ct.lookup("java:comp/env/oracle");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
