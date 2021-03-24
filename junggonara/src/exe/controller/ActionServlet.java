package exe.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exe.common.ActionForward;
import exe.common.Command;
import exe.factory.CommandFactory;

@WebServlet("*.do")
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		System.out.println(url);
		
		CommandFactory factory = CommandFactory.getInstance();
		Command command = factory.getCommand(url);
		
		ActionForward action = command.execute(request);
		
		if(action.getSend()) {
			response.sendRedirect(action.getPath());
		
		} else {
			RequestDispatcher rd = request.getRequestDispatcher(action.getPath());
			rd.forward(request, response);
		}
		
	}

}
