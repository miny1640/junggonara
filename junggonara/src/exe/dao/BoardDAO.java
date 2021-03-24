package exe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import exe.entity.BoardEntity;

public class BoardDAO extends CommonDAO {
	public ArrayList<BoardEntity> selectAll(String keyword, int startNum, int scope, String dept_code, String sale_purchase){
		ArrayList<BoardEntity> list = new ArrayList<BoardEntity>(); 
		String query = "select c.* from	(select rownum rnum, b.* "
										+ "from (select jg_board.*,TO_CHAR(write_date, 'HH24:MI:SS') as time "
												+ "from jg_board "
												+ "where br_num in (select br_num "
												+ 				   "from jg_board "
												+ 				   "where br_title like ? "
												+ 				   "or br_content like ? "
												+ 				   "or mb_id in (select mb_id "
												+ 							    "from jg_member "
												+ 							    "where mb_name like ?) "
												+ 				   "or bk_code in (select bk_code "
												+ 								  "from jg_book "
												+ 								  "where bk_title like ?)) "
												+ "and dept_code like ? "
												+ "and sale_purchase like ? " // 여기 까지는 필요 없음 
												+ "order by br_num desc) b) c "
						+ "where rnum between ? and ?";
		
		Connection con =null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con=ds.getConnection();
			stmt=con.prepareStatement(query);
			stmt.setString(1, "%" + keyword + "%");
			stmt.setString(2, "%" + keyword + "%");
			stmt.setString(3, "%" + keyword + "%");
			stmt.setString(4, "%" + keyword + "%");
			stmt.setString(5, "%" + dept_code + "%");
			stmt.setString(6, "%" + sale_purchase + "%");
			stmt.setInt(7, startNum);
			stmt.setInt(8, startNum + scope - 1);
			
			rs=stmt.executeQuery();
			
			while(rs.next()) {
				BoardEntity board = new BoardEntity();
				board.setBr_num(rs.getInt("br_num"));
				board.setMb_id(rs.getInt("mb_id"));
			board.setBr_title(rs.getString("br_title"));
				board.setBk_code(rs.getString("bk_code"));
				board.setBr_content(rs.getString("br_content"));
				board.setBr_price(rs.getInt("br_price"));
				board.setSale_purchase(rs.getString("sale_purchase"));
				board.setPurchase_done(rs.getString("purchase_done"));
				board.setHit(rs.getInt("hit"));
				board.setWrite_date(rs.getDate("write_date"));
			board.setUpFile(rs.getString("upFile"));
				board.setDept_code(rs.getString("dept_code"));
				board.setTime(rs.getString("time"));
				
				list.add(board);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	
	public int totalRow(String keyword, String dept_code, String sale_purchase) {
		int totalRow = 0;
		
		String query = 	"select count(*) "
					 + 	"from jg_board "
					 + 	"where br_num in (select br_num "
					 + 				   	 "from jg_board "
					 + 				   	 "where br_title like ? "
					 + 				   	 "or br_content like ? "
					 + 				   	 "or mb_id in (select mb_id "
					 + 							      "from jg_member "
					 + 							      "where mb_name like ?) "
					 + 				   	 "or bk_code in (select bk_code "
					 + 								    "from jg_book "
					 + 								    "where bk_title like ?)) "
					 + 	"and dept_code like ? "
					 + 	"and sale_purchase like ?";

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, "%" + keyword + "%");
			stmt.setString(2, "%" + keyword + "%");
			stmt.setString(3, "%" + keyword + "%");
			stmt.setString(4, "%" + keyword + "%");
			stmt.setString(5, "%" + dept_code + "%");
			stmt.setString(6, "%" + sale_purchase + "%");
			
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

	public boolean delete(String br_num, int mb_id) {
		boolean result = false;
		int tmp =0;
		String query = "delete from jg_board where br_num = ? and mb_id =?";
		
		Connection con=null;
		PreparedStatement stmt=null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setInt(1, Integer.parseInt(br_num));
			stmt.setInt(2, mb_id);
			
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

	public boolean insert(BoardEntity board) {
		boolean result = false;
		int tmp =0;
		String query = "insert into jg_board "
				+ "values(seq_board.nextval, ?, ?, ?, ?, ?, ?, 'X', 0, sysdate, ?, ?)";
		
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setInt(1, board.getMb_id());//mb_id
			stmt.setString(2, board.getBr_title());//br_title
			stmt.setString(3, board.getBk_code());//bk_code
			stmt.setString(4, board.getBr_content());//br_content
			stmt.setInt(5, board.getBr_price());//br_price
			stmt.setString(6, board.getSale_purchase());//sale_purchase
			stmt.setString(7, board.getUpFile());//upFile
			stmt.setString(8, board.getDept_code());//dept_code
			
			
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

	public void hitUpdate(String br_num) {
		String query = "update jg_board set hit=hit+1 where br_num=?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setInt(1, Integer.parseInt(br_num));
			stmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(stmt);
			close(con);
		}
		
	}

	public BoardEntity select(String br_num) { //boardDetail에서 사용하는 코드
		BoardEntity board = new BoardEntity();
		
		String query = "select * from jg_board where br_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setInt(1, Integer.parseInt(br_num));
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				board.setBr_num(rs.getInt("br_num"));
				board.setMb_id(rs.getInt("mb_id"));
				board.setBr_title(rs.getString("br_title"));
				board.setBk_code(rs.getString("bk_code"));
				board.setBr_content(rs.getString("br_content"));
				board.setBr_price(rs.getInt("br_price"));
				board.setSale_purchase(rs.getString("sale_purchase"));
				board.setPurchase_done(rs.getString("purchase_done"));
				board.setHit(rs.getInt("hit"));
				board.setWrite_date(rs.getDate("write_date"));
				board.setUpFile(rs.getString("upFile"));
				board.setDept_code(rs.getString("dept_code"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return board;
	}

	public boolean update(BoardEntity board) {
		boolean result = false;
		int tmp = 0;
		
		String query = "update jg_board "
				+ 	   "set br_title = ?, br_content = ?, "
				+ 	   "br_price = ?, bk_code = ?, "
				+ 	   "sale_purchase = ? ";
		if(board.getUpFile() != null) {
			query +=", upFile = ? ";
		}
			query += "where br_num = ?";
		
		Connection con =null;
		PreparedStatement stmt =null;
		
		try {
			con =ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, board.getBr_title());
			stmt.setString(2, board.getBr_content());
			stmt.setInt(3, board.getBr_price());
			stmt.setString(4, board.getBk_code());
			stmt.setString(5, board.getSale_purchase());
			if(board.getUpFile() != null) {
				stmt.setString(6, board.getUpFile());
				stmt.setInt(7, board.getBr_num());
			}else {
				stmt.setInt(6, board.getBr_num());
			}

			
			
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
	
	public boolean deal(String br_num) {
		boolean result = false;
		int tmp= 0;
		String query = "update jg_board set PURCHASE_DONE = 'O' where BR_NUM = ?" ;
		
		Connection con=null;
		PreparedStatement stmt=null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setInt(1, Integer.parseInt(br_num));
			
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
	public boolean tradeCancle(String br_num) {
		boolean result = false;
		int tmp= 0;
		String query = "update jg_board set PURCHASE_DONE = 'X' where BR_NUM = ?" ;
		
		Connection con=null;
		PreparedStatement stmt=null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setInt(1, Integer.parseInt(br_num));
			
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
	public ArrayList<BoardEntity> my_select(String keyword, int startNum, int scope, String dept_code, String sale_purchase, int mb_id){
		ArrayList<BoardEntity> list = new ArrayList<BoardEntity>(); 
		String query = "select c.* from	(select rownum rnum, b.* "
										+ "from (select * "
												+ "from jg_board "
												+ "where br_num in (select br_num "
												+ 				   "from jg_board "
												+ 				   "where br_title like ? "
												+ 				   "or br_content like ? "
												+ 				   "or mb_id in (select mb_id "
												+ 							    "from jg_member "
												+ 							    "where mb_name like ?) "
												+ 				   "or bk_code in (select bk_code "
												+ 								  "from jg_book "
												+ 								  "where bk_title like ?)) "
												+ "and mb_id = ?"
												+ "and dept_code like ? "
												+ "and sale_purchase like ? "// 여기 까지는 필요 없음 
												+ "order by br_num desc) b) c "
						+ "where rnum between ? and ?";
		
		Connection con =null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con=ds.getConnection();
			stmt=con.prepareStatement(query);
			stmt.setString(1, "%" + keyword + "%");
			stmt.setString(2, "%" + keyword+ "%");
			stmt.setString(3, "%" + keyword+ "%");
			stmt.setString(4, "%" + keyword+ "%");
			stmt.setInt(5, mb_id);
			stmt.setString(6, "%" + "" + "%");
			stmt.setString(7, "%" + sale_purchase + "%");
			stmt.setInt(8, startNum);
			stmt.setInt(9, startNum + scope - 1);
			
			rs=stmt.executeQuery();
			
			while(rs.next()) {
				BoardEntity board = new BoardEntity();
				board.setBr_num(rs.getInt("br_num"));
				board.setMb_id(rs.getInt("mb_id"));
				board.setBr_title(rs.getString("br_title"));
				board.setBk_code(rs.getString("bk_code"));
				board.setBr_content(rs.getString("br_content"));
				board.setBr_price(rs.getInt("br_price"));
				board.setSale_purchase(rs.getString("sale_purchase"));
				board.setPurchase_done(rs.getString("purchase_done"));
				board.setHit(rs.getInt("hit"));
				board.setWrite_date(rs.getDate("write_date"));
				board.setUpFile(rs.getString("upFile"));
				board.setDept_code(rs.getString("dept_code"));
				
				list.add(board);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	public int my_totalRow(String keyword, String dept_code, String sale_purchase, int mb_id) {
		int totalRow = 0;
		
		String query = 	"select count(*) "
					 + 	"from jg_board "
					 + 	"where br_num in (select br_num "
					 + 				   	 "from jg_board "
					 + 				   	 "where br_title like ? "
					 + 				   	 "or br_content like ? "
					 + 				   	 "or mb_id in (select mb_id "
					 + 							      "from jg_member "
					 + 							      "where mb_name like ?) "
					 + 				   	 "or bk_code in (select bk_code "
					 + 								    "from jg_book "
					 + 								    "where bk_title like ?)) "
					 + "and mb_id = ?"
					 + 	"and dept_code like ? "
					 + 	"and sale_purchase like ?";  
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, "%" +keyword + "%");
			stmt.setString(2, "%" + keyword+ "%");
			stmt.setString(3, "%" + keyword + "%");
			stmt.setString(4, "%" + keyword + "%");
			stmt.setInt(5, mb_id);
			stmt.setString(6, "%" + dept_code + "%");
			stmt.setString(7, "%" + sale_purchase + "%");
	
			
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
}
