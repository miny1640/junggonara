package exe.factory;

import java.util.HashMap;

import exe.command.BoardDeleteCommand;
import exe.command.BoardDetailCommand;
import exe.command.BoardInsertCommand;
import exe.command.BoardInsertFormCommand;
import exe.command.BoardMainCommand;
import exe.command.BoardReplyAnswerCommand;
import exe.command.BoardReplyCommand;
import exe.command.BoardReplyDeleteCommand;
import exe.command.BoardUpdateCommand;
import exe.command.BoardUpdateFormCommand;
import exe.command.BookInsertCommand;
import exe.command.DeptInsertCommand;
import exe.command.HitUpdateCommand;
import exe.command.LoginCommand;
import exe.command.LoginFormCommand;
import exe.command.LogoutCommand;
import exe.command.MajorInsertCommand;
import exe.command.ManagerCommand;
import exe.command.MemberInsertCommand;
import exe.command.MemberInsertFormCommand;
import exe.command.MemberUpdateCommand;
import exe.command.MyPageCommand;
import exe.command.MyPageWritingCommand;
import exe.command.PurchaseCommand;
import exe.command.SaleCommand;
import exe.command.SearchPasswordCommand;
import exe.command.SearchPasswordFormCommand;
import exe.command.TradeCancleCommand;
import exe.common.Command;


public class CommandFactory {
	private HashMap<String, Command> commandList = new HashMap<String, Command>();
	private static CommandFactory factory = new CommandFactory();
	
	private CommandFactory () {
		commandList.put("/junggonara/boardMain.do", new BoardMainCommand());
		commandList.put("/junggonara/manager.do", new ManagerCommand());
		
		//������ ���Ѻ�
		commandList.put("/junggonara/majorInsert.do", new MajorInsertCommand());
		commandList.put("/junggonara/deptInsert.do", new DeptInsertCommand());
		commandList.put("/junggonara/bookInsert.do", new BookInsertCommand());
		
		//��� ������
		commandList.put("/junggonara/memberInsert.do", new MemberInsertCommand());
		commandList.put("/junggonara/memberUpdate.do", new MemberUpdateCommand());
		commandList.put("/junggonara/boardInsert.do", new BoardInsertCommand());
		commandList.put("/junggonara/boardUpdate.do", new BoardUpdateCommand());
		commandList.put("/junggonara/hitUpdate.do", new HitUpdateCommand());
		commandList.put("/junggonara/login.do", new LoginCommand());
		commandList.put("/junggonara/logout.do", new LogoutCommand());
		commandList.put("/junggonara/boardDelete.do", new BoardDeleteCommand());
		commandList.put("/junggonara/tradeCancle.do", new TradeCancleCommand());
		commandList.put("/junggonara/purchase.do", new PurchaseCommand());
		commandList.put("/junggonara/sale.do", new SaleCommand());
		commandList.put("/junggonara/searchPassword.do", new SearchPasswordCommand());
		commandList.put("/junggonara/boardReply.do", new BoardReplyCommand());
		commandList.put("/junggonara/boardReplyAnswer.do", new BoardReplyAnswerCommand());
		commandList.put("/junggonara/boardReplyDelete.do", new BoardReplyDeleteCommand());
		
		//form��
		commandList.put("/junggonara/memberInsertForm.do", new MemberInsertFormCommand());
		commandList.put("/junggonara/loginForm.do", new LoginFormCommand());
		commandList.put("/junggonara/boardInsertForm.do", new BoardInsertFormCommand());
		commandList.put("/junggonara/boardUpdateForm.do", new BoardUpdateFormCommand());
		commandList.put("/junggonara/boardDetail.do", new BoardDetailCommand());
		commandList.put("/junggonara/searchPasswordForm.do", new SearchPasswordFormCommand());
		commandList.put("/junggonara/myPage.do", new MyPageCommand());
		commandList.put("/junggonara/mywriting.do", new MyPageWritingCommand());
	}
	
	public static CommandFactory getInstance() {
		return factory;
	}
	
	public Command getCommand(String url) {
		return commandList.get(url);
	}
}