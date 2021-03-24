package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.entity.MemberEntity;

public class ManagerCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		HttpSession session = request.getSession();
		MemberEntity member = (MemberEntity)session.getAttribute("member");
		ActionForward action = new ActionForward();
		if(member == null) {
			JOptionPane.showMessageDialog(null, "�α����� ���� ���ּ���!");
			action.setPath("boardMain.do");
			action.setSend(true);
		}else if(member.getMb_id()==0&&member.getMb_pw().equals("0")){
			action.setPath("manager.jsp");
			action.setSend(false);
		}else {
			JOptionPane.showMessageDialog(null, "�����ڰ� �ƴմϴ�. �������� �Ѿ�ϴ�.");
			action.setPath("boardMain.do");
			action.setSend(true);
		}
		return action;
	}

}
