package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.DepartmentDAO;
import exe.entity.DepartmentEntity;

public class DeptInsertCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		try {
			request.setCharacterEncoding("utf-8");
		}catch(Exception e) {
			e.printStackTrace();
		}
		String dept_code = request.getParameter("dept_code");
		String dept_name = request.getParameter("dept_name");
		String m_code = request.getParameter("m_code");
		DepartmentEntity dept = new DepartmentEntity();
		try {
			dept.setDept_code(dept_code);
			dept.setDept_name(dept_name);
			dept.setM_code(m_code);
		}catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "å �߰� ����");
			action.setPath("manager.do?flag=2");
			action.setSend(true);
			return action;
		}
		DepartmentDAO dao = new DepartmentDAO();
		boolean result = dao.insert(dept);
		
		
		if(result == true) {
			action.setPath("manager.do");
			action.setSend(true);
		}else {
			JOptionPane.showMessageDialog(null, "å �߰� �����߽��ϴ� �ٽ� �õ����ּ���!");
			action.setPath("manager.do?flag=2");
			action.setSend(true);
		}
		return action;
	}

}
