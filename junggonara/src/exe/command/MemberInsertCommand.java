package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.MemberDAO;
import exe.entity.MemberEntity;

public class MemberInsertCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) 
			throws IOException, ServletException {

		ActionForward action = new ActionForward();
		try {
			request.setCharacterEncoding("utf-8");
		}catch(Exception e) {
			e.printStackTrace();
		}
		String mb_id = request.getParameter("mb_id");
		String mb_name = request.getParameter("mb_name");
		String mb_pw = request.getParameter("mb_pw");
		String dept_code = request.getParameter("dept_code");
		
		MemberEntity member = new MemberEntity();
		try {											//�ƹ��͵� �Է¾����� ȸ�����Խ�
			member.setMb_id(Integer.parseInt(mb_id));	//�߻��ϴ� ������
			member.setMb_name(mb_name);					//result.jsp�� �Ѿ�� ����
			member.setMb_pw(mb_pw);
			member.setDept_code(dept_code);
		}catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "ȸ������ ����");
			action.setPath("memberInsertForm.do");
			action.setSend(true);
			return action;
		}
		MemberDAO dao = new MemberDAO();
		boolean result = dao.insert(member);
		
		
		if(result == true) {
			action.setPath("loginForm.do");
			action.setSend(true);
		}else {
			JOptionPane.showMessageDialog(null, "ȸ������ �����߽��ϴ� �ٽ� �õ����ּ���!");
			action.setPath("memberInsertForm.do");
			action.setSend(true);
		}
		return action;
	}

}
