package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.CommentDAO;
import exe.entity.CommentEntity;
import exe.entity.MemberEntity;

public class BoardReplyAnswerCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		HttpSession session = request.getSession();
		MemberEntity member = (MemberEntity) session.getAttribute("member");
		
		if(member == null) {
			JOptionPane.showMessageDialog(null, "�α����� ���� ���ּ���!");
			action.setPath("boardMain.do");
			action.setSend(true);
		} else {
			//�ѱ�ó��
			request.setCharacterEncoding("utf-8");

			//���۵� �����͸� �޴´�.
			String cm_content = request.getParameter("comment");
			String br_num = request.getParameter("br_num");
			String secret = request.getParameter("secret");
			String ref = request.getParameter("ref");
			String position = request.getParameter("position");
			cm_content = "��" + cm_content;
			if(secret == null) {
				secret = "X";
			}
			
			//DAO ��ü�� �����Ѵ�.
			CommentDAO dao = new CommentDAO();
			CommentEntity comment = new CommentEntity();
			
			comment.setBr_num(Integer.parseInt(br_num)); 
			comment.setMb_id(member.getMb_id());
			comment.setCm_content(cm_content);
			comment.setSecret(secret);
			comment.setRef(Integer.parseInt(ref));
			comment.setPosition(Integer.parseInt(position));

			boolean result = dao.replyAnswer(comment);

			if (result == true) {
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
			} else {
				JOptionPane.showMessageDialog(null, "������ �Է����ּ���!");
				action.setPath("boardDetail.do?br_num="+br_num);
				action.setSend(true);
			}
		}
		return action;
	}
}
