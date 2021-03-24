package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.BoardDAO;
import exe.entity.MemberEntity;

public class BoardDeleteCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		HttpSession session = request.getSession();
		BoardDAO boardDAO = new BoardDAO();
		boolean result = false;
		String br_num = request.getParameter("br_num");
		MemberEntity member = (MemberEntity)session.getAttribute("member");
		if(member == null) {
			JOptionPane.showMessageDialog(null, "로그인을 먼저 해주세요!");
			action.setPath("boardMain.do");
			action.setSend(true);
		}else {
			try {
				result = boardDAO.delete(br_num, member.getMb_id());
			}catch(Exception e){
				e.printStackTrace();
				JOptionPane.showMessageDialog(null, "삭제 에러");
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
				return action;
			}
			if(result == true) {
				action.setPath("boardMain.do");
				action.setSend(true);
			}else {
				JOptionPane.showMessageDialog(null, "삭제 실패했습니다.");
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
			}
		}
		return action;
	}
}