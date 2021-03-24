package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.MemberDAO;
import exe.entity.MemberEntity;

public class LoginCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		MemberEntity member = new MemberEntity();
		MemberDAO dao = new MemberDAO();
		String pw = null;
		
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			pw = request.getParameter("pw");
			member = dao.login(id);
		}catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "ID�� ���ڸ� �Է��ؾ� �մϴ�. �ٽ� �õ����ּ���!1");
			action.setPath("loginForm.do");
			action.setSend(true);
			return action;
		}
		if(member != null) { // �� �κ��� login
			
			if(member.getMb_id()==0&&member.getMb_pw().equals("0")) {
				HttpSession session = request.getSession();
				session.setAttribute("member", member);
				action.setPath("manager.do");
				action.setSend(true);
			}else if(member.getMb_pw().equals(pw)) {
				HttpSession session = request.getSession();
				session.setAttribute("member", member);
				action.setPath("boardMain.do");
				action.setSend(true);
			} else {
				JOptionPane.showMessageDialog(null, "PW�� Ȯ�����ּ���.");
				action.setPath("loginForm.do");
				action.setSend(true);
			}
			
		
		} else{
			JOptionPane.showMessageDialog(null, "ID�� Ȯ�����ּ���.");
			action.setPath("loginForm.do");
			action.setSend(true);
		}
		
		return action;
	}
	
}