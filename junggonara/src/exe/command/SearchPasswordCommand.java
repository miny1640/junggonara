package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.swing.JOptionPane;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.MemberDAO;
import exe.entity.MemberEntity;

public class SearchPasswordCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		
		ActionForward action = new ActionForward();
		MemberEntity member = new MemberEntity();
		MemberDAO dao = new MemberDAO();
		System.out.println(request.getParameter("schoolnumber"));
		
		int id = 0;
		
		try{
			id = Integer.parseInt(request.getParameter("schoolnumber"));
			member = dao.select(id);
		} catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "비밀번호 찾기 오류");
			action.setPath("searchPasswordForm.do");
			action.setSend(true);
			return action;
		}
		
		if(member!=null) {
			System.out.println("---> " + member.getMb_pw());
			JOptionPane.showMessageDialog(null, member.getMb_pw());
			action.setPath("searchPasswordForm.do");
			action.setSend(true);
		}else {
			JOptionPane.showMessageDialog(null, "비밀번호를 찾지 못했습니다. 다시 시도해주세요!");
			action.setPath("searchPasswordForm.do");
			action.setSend(true);
		}
		return action; 
	}
}

