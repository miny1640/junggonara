package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.entity.MemberEntity;

public class MyPageCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		HttpSession session = request.getSession();
		MemberEntity member = (MemberEntity)session.getAttribute("member");
		ActionForward action = new ActionForward();
		if(member == null) {
			JOptionPane.showMessageDialog(null, "로그인을 먼저 해주세요!");
			action.setPath("boardMain.do");
			action.setSend(true);
		}else {
			action.setPath("WEB-INF/mypage.jsp");
			action.setSend(false);
		}
		return action;
	}

}
