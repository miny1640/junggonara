package exe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import exe.entity.CommentEntity;

public class CommentDAO extends CommonDAO {
	
		public CommentEntity selectComment(String cm_no){
			CommentEntity comment = null;
			String query = "select * from jg_Comment where cm_no = ?";
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				con = ds.getConnection();
				stmt = con.prepareStatement(query);
				stmt.setInt(1, Integer.parseInt(cm_no));
				rs = stmt.executeQuery();

				while (rs.next()) {
					comment = new CommentEntity();
					comment.setBr_num(rs.getInt("br_num"));
					comment.setCm_no(rs.getInt("cm_no"));
					comment.setMb_id(rs.getInt("mb_id"));
					comment.setCm_content(rs.getString("cm_content"));
					comment.setWrite_date(rs.getDate("write_date"));
					comment.setSecret(rs.getString("secret"));
					comment.setRef(rs.getInt("ref"));
					comment.setPosition(rs.getInt("position"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(stmt);
				close(con);
			}
			return comment;
		}
		public boolean answer(CommentEntity comment) {
			boolean result = false;
			int tmp =0;
			String query = "insert into jg_comment "
					+ "values(?,seq_comment.nextval,?,?, sysdate,?,seq_comment.currval,0)";
			
			Connection con = null;
			PreparedStatement stmt = null;
			try {
				con = ds.getConnection();
				stmt = con.prepareStatement(query);
				stmt.setInt(1, comment.getBr_num());
				stmt.setInt(2, comment.getMb_id());
				stmt.setString(3, comment.getCm_content());
				stmt.setString(4, comment.getSecret());
				
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
		
		public int cm_totalRow(int br_num, String ref) {
			int cm_totalRow = 0;
			
			String query = "select count(*) "
					+ 	   "from jg_Comment "
					+ 	   "where cm_no in(select cm_no "
					+ 					  "from jg_comment "
					+ 					  "where position = 0";
			if(ref == null) {
				   query+= 				  ") "
					+     "and br_num = ?";
			}else {
				   query+= 				" or ref = ?) "
					+ 	  "and br_num = ?";
			}

			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				con = ds.getConnection();
				stmt = con.prepareStatement(query);
				if(ref == null) {
					stmt.setInt(1, br_num);
				}else {
					stmt.setInt(1, Integer.parseInt(ref));
					stmt.setInt(2, br_num);
				}
				rs = stmt.executeQuery();
				rs.next();
				cm_totalRow = rs.getInt(1);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(stmt);
				close(con);
			}

			return cm_totalRow;
		}
		
		public ArrayList<CommentEntity> select(int br_num,int startnum, int scope, String ref) {
			ArrayList<CommentEntity> list = new ArrayList<CommentEntity>();
			String query = "select c.* from(select rownum rnum, b.* "
					+ 					   "from (select * "
					+ 							 "from jg_comment "
					+ 							 "where cm_no in(select cm_no "
					+ 											"from jg_comment "
					+ 											"where position = 0";
			if(ref == null) {
				   query+= 									    ") "
					+ 							 "and br_num = ? "
					+ 							 "order by ref desc, position asc) b) c "
					+ 					   "where rnum between ? and ?";
			}else {
					query+= 								  " or ref = ?) "
					+ 							 "and br_num = ? "
					+ 							 "order by ref desc, position asc) b) c "
					+ 					   "where rnum between ? and ?";
			}
			
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				stmt = con.prepareStatement(query);
				if(ref == null) {
					stmt.setInt(1, br_num);
					stmt.setInt(2, startnum);
					stmt.setInt(3, startnum + scope - 1);
				}else {
					stmt.setInt(1, Integer.parseInt(ref));
					stmt.setInt(2, br_num);
					stmt.setInt(3, startnum);
					stmt.setInt(4, startnum + scope - 1);
				}
				
				rs = stmt.executeQuery();
				
				while (rs.next()) {
					CommentEntity comment = new CommentEntity();
					comment.setBr_num(rs.getInt("br_num"));
					comment.setCm_no(rs.getInt("cm_no"));
					comment.setMb_id(rs.getInt("mb_id"));
					comment.setCm_content(rs.getString("cm_content"));
					comment.setWrite_date(rs.getDate("write_date"));
					comment.setSecret(rs.getString("secret"));
					comment.setRef(rs.getInt("ref"));
					comment.setPosition(rs.getInt("position"));
				
					list.add(comment);
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
		
		public boolean delete(String cm_no, String maxPosition, String position) {
			boolean result=false;
			int tmp =0;
			String query = "delete from jg_comment where ";
			if(Integer.parseInt(position) == 0 && Integer.parseInt(maxPosition) > 0) {
				query+="ref = ?";
			}else {
				query+="cm_no = ?";
			}
			
			Connection con=null;
			PreparedStatement stmt=null;
			
			try {
				con = ds.getConnection();
				stmt = con.prepareStatement(query);
				stmt.setInt(1, Integer.parseInt(cm_no));
				
				tmp = stmt.executeUpdate();
				if(tmp==0) {
					result=false;
				}else {
					result=true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(stmt);
				close(con);
			}
			return result;
		}
		public boolean replyAnswer(CommentEntity comment) {
			boolean result = false;
			int tmp = 0;
			String query = "insert into jg_comment "
					+ "values(?,seq_comment.nextval,?,?, sysdate,?,?,?)";
			
			Connection con = null;
			PreparedStatement stmt = null;
			try {
				con = ds.getConnection();
				stmt = con.prepareStatement(query);
				stmt.setInt(1, comment.getBr_num());
				stmt.setInt(2, comment.getMb_id());
				stmt.setString(3, comment.getCm_content());
				stmt.setString(4, comment.getSecret());
				stmt.setInt(5, comment.getRef());
				stmt.setInt(6, comment.getPosition()+1);
				
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
		public int maxPosition(int ref) {
			int maxPosition = 0;
			String query = "select max(position) from jg_comment where ref = ?";
			
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;

			try {
				con = ds.getConnection();
				stmt = con.prepareStatement(query);
				stmt.setInt(1, ref);

				rs = stmt.executeQuery();
				rs.next();

				maxPosition = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(stmt);
				close(con);
			}
			return maxPosition;
		}
}
