package exe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import exe.entity.BookEntity;

public class BookDAO extends CommonDAO {
	public ArrayList<BookEntity> select(String dept_code){//학과별 책정보 가져오는 기능
		ArrayList<BookEntity> list = new ArrayList<BookEntity>();
		String query="select * from jg_book where dept_code = ?";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, dept_code);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				BookEntity book = new BookEntity();
				book.setBk_code(rs.getString("bk_code"));
				book.setBk_title(rs.getString("bk_title"));
				book.setDept_code(rs.getString("dept_code"));
				
				list.add(book);
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
	public BookEntity selectBook(String bk_code){//해당 책 코드별 책이름 출력
		BookEntity book = new BookEntity();
		String query="select * from jg_book where bk_code = ?";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, bk_code);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				book.setBk_code(rs.getString("bk_code"));
				book.setBk_title(rs.getString("bk_title"));
				book.setDept_code(rs.getString("dept_code"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return book;
	}
	public int countBook() {
		int totalRow = 0;
		
		String query = 	"select count(*) from jg_book";

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
	public boolean insert(BookEntity book) {
		boolean result = false;
		int tmp = 0;
		String query = "insert into jg_book values(?, ?, ?)";
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, book.getBk_code());
			stmt.setString(2, book.getBk_title());
			stmt.setString(3, book.getDept_code());
			
			
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
