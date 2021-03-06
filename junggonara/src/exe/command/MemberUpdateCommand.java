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

public class MemberUpdateCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		HttpSession session = request.getSession();
		MemberEntity member_ck = (MemberEntity)session.getAttribute("member");
		ActionForward action = new ActionForward();
		String mb_pw = request.getParameter("mb_pw");
		
		if(member_ck == null) {
			JOptionPane.showMessageDialog(null, "로그인을 먼저 해주세요!");
			action.setPath("boardMain.do");
			action.setSend(true);
		}else {
			MemberEntity member = new MemberEntity();
			try {
				member.setMb_id(member_ck.getMb_id());
				member.setMb_pw(mb_pw);
			}catch(Exception e) {
				e.printStackTrace();
				JOptionPane.showMessageDialog(null, "회원수정 에러");
				action.setPath("myPage.do");
				action.setSend(true);
				return action;
			}
			MemberDAO dao = new MemberDAO();
			boolean result = dao.update(member);
			
			
			if(result == true) {
				action.setPath("boardMain.do");
				action.setSend(true);
			}else {
				JOptionPane.showMessageDialog(null, "회원수정 실패했습니다 다시 시도해주세요!");
				action.setPath("myPage.do");
				action.setSend(true);
			}
		}
		return action;
	}

}
