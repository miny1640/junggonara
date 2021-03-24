package exe.command;

import java.io.File;
import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import exe.common.ActionForward;
import exe.common.Command;
import exe.dao.BoardDAO;
import exe.entity.BoardEntity;
import exe.entity.MemberEntity;

public class BoardInsertCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request) throws IOException, ServletException {
		ActionForward action = new ActionForward();
		HttpSession session = request.getSession();
		MemberEntity member = (MemberEntity)session.getAttribute("member");
		
		if(member == null) {
			JOptionPane.showMessageDialog(null, "�α����� ���� ���ּ���!");
			action.setPath("boardMain.do");
			action.setSend(true);
		}else {
			try {
				request.setCharacterEncoding("utf-8");
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			int size = 1024 * 1024 * 50;
			//String savePath => Command�� ����� ����
			try {
				MultipartRequest mr = 
						new MultipartRequest(request, savePath, size,"utf-8",
								new DefaultFileRenamePolicy());
				
				String mb_id = mr.getParameter("mb_id");
				String br_title = mr.getParameter("br_title");
				String bk_code = mr.getParameter("bk_code");
				String br_content = mr.getParameter("br_content");
				String br_price = mr.getParameter("br_price");
				String sale_purchase = mr.getParameter("sale_purchase");
				if(sale_purchase == null) {
					sale_purchase = " ";
				}
				String fileName = "";
				if(mr.getFilesystemName("upFile") == null) {
					fileName = null;
				}else {
					StringTokenizer st = new StringTokenizer(mr.getFilesystemName("upFile"), ".");
					st.nextToken();
					
					fileName = System.currentTimeMillis() + "." + st.nextToken();
					
					File file = new File(savePath + "/" + mr.getFilesystemName("upFile"));
//					System.out.println("==> " + file.getAbsolutePath() + " : " + file.exists());
					file.renameTo(new File(savePath + "/" + fileName));
				}
				
				String dept_code = mr.getParameter("dept_code");
				
				if(br_price == null) {
					br_price="0";
				}
				
				BoardEntity board = new BoardEntity();
				
				board.setMb_id(Integer.parseInt(mb_id));
				board.setBr_title(br_title);
				board.setBk_code(bk_code);
				board.setBr_content(br_content);
				board.setBr_price(Integer.parseInt(br_price));
				board.setSale_purchase(sale_purchase);
				board.setUpFile(fileName);
				board.setDept_code(dept_code);
				
				BoardDAO dao = new BoardDAO();
				boolean result = dao.insert(board);
				if(result == true) {
					action.setPath("boardMain.do");
					action.setSend(true);
				}else {
					JOptionPane.showMessageDialog(null, "�Խù��� �ۼ����� ���Ͽ����ϴ�. �ٽ� �õ����ּ���!");
					action.setPath("boardInsertForm.do");
					action.setSend(false);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
				JOptionPane.showMessageDialog(null, "�Խù� �ۼ� ����");
				action.setPath("boardInsertForm.do");
				action.setSend(false);
			}
		}
		return action;
	}
}
