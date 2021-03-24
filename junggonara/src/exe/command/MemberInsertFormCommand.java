package exe.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import exe.common.ActionForward;
import exe.common.Command;

public class MemberInsertFormCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		
		action.setPath("WEB-INF/memberInsertForm.jsp");
		action.setSend(false);
		return action;
	}

}
