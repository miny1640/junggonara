package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.BookDAO;
import exe.entity.BookEntity;

public class BookInsertCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		try {
			request.setCharacterEncoding("utf-8");
		}catch(Exception e) {
			e.printStackTrace();
		}
		String bk_code = request.getParameter("bk_code");
		String bk_title = request.getParameter("bk_title");
		String dept_code = request.getParameter("dept_code");
		BookEntity book = new BookEntity();
		try {
			book.setBk_code(bk_code);
			book.setBk_title(bk_title);
			book.setDept_code(dept_code);
		}catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "å �߰� ����");
			action.setPath("manager.do?flag=3");
			action.setSend(true);
			return action;
		}
		BookDAO bookDAO = new BookDAO();
		boolean result = bookDAO.insert(book);
		
		
		if(result == true) {
			action.setPath("manager.do");
			action.setSend(true);
		}else {
			JOptionPane.showMessageDialog(null, "å �߰� �����߽��ϴ� �ٽ� �õ����ּ���!");
			action.setPath("manager.do?flag=3");
			action.setSend(true);
		}
		return action;
	}
}
