package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.MajorDAO;
import exe.entity.MajorEntity;

public class MajorInsertCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		try {
			request.setCharacterEncoding("utf-8");
		}catch(Exception e) {
			e.printStackTrace();
		}
		String m_code = request.getParameter("m_code");
		String m_name = request.getParameter("m_name");
		MajorEntity major = new MajorEntity();
		try {
			major.setM_code(m_code);
			major.setM_name(m_name);
		}catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "å �߰� ����");
			action.setPath("manager.do?flag=1");
			action.setSend(true);
			return action;
		}
		MajorDAO dao = new MajorDAO();
		boolean result = dao.insert(major);
		
		
		if(result == true) {
			action.setPath("manager.do");
			action.setSend(true);
		}else {
			JOptionPane.showMessageDialog(null, "å �߰� �����߽��ϴ� �ٽ� �õ����ּ���!");
			action.setPath("manager.do?flag=1");
			action.setSend(true);
		}
		return action;
	}

}
