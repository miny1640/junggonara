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

public class SaleCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		
		ActionForward action = new ActionForward();
		HttpSession session = request.getSession();
		BoardDAO dao = new BoardDAO();
		boolean result = false;
		String br_num = request.getParameter("br_num");
		MemberEntity member = (MemberEntity)session.getAttribute("member");
		if(member == null) {
			JOptionPane.showMessageDialog(null, "로그인을 먼저 해주세요!");
			action.setPath("boardMain.do");
			action.setSend(true);
		}else {
			try {
			result = dao.deal(br_num);
			System.out.println(br_num);
			}catch(Exception e){
				e.printStackTrace();
				JOptionPane.showMessageDialog(null, "판매 에러");
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
				return action;
			}
			if(result == true) {
				action.setPath("boardMain.do");
				action.setSend(true);
			}else {
				JOptionPane.showMessageDialog(null, "판매하지 못했습니다!");
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
			}
		}
		return action;
	}

}
