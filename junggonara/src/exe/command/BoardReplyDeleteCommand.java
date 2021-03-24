package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.CommentDAO;
import exe.entity.MemberEntity;

public class BoardReplyDeleteCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		HttpSession session = request.getSession();
		CommentDAO dao = new CommentDAO();
		String br_num = request.getParameter("br_num");
		boolean result = false;
		MemberEntity member = (MemberEntity)session.getAttribute("member");
		if(member == null) {
			JOptionPane.showMessageDialog(null, "�α����� ���� ���ּ���!");
			action.setPath("boardMain.do");
			action.setSend(true);
		}else {
			try {
			String maxPosition = request.getParameter("maxPosition");
			String position = request.getParameter("position");
			String cm_no = request.getParameter("cm_no");
			result = dao.delete(cm_no, maxPosition, position);
			}catch(Exception e){
				e.printStackTrace();
				JOptionPane.showMessageDialog(null, "���� ����");
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
				return action;
			}
			if(result == true) {
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
			}else {
				JOptionPane.showMessageDialog(null, "�������� ���߽��ϴ�!");
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
			}
		}
		return action;
	}

}