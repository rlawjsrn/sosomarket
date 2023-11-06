package com.tbk.prj.member;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class MemberLogInServlet
 */
@WebServlet("/LogIn.do")
public class MemberLogInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberLogInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		//int idck = 
		MemberVO vo = new MemberDAO().loginmember(memberId, password);
		// 로그인 성공
		if(memberId.equals(vo.getMemberId())&& password.equals(vo.getPassword())) {
			System.out.println("1 :"+vo.getMemberId());
			System.out.println("2 :"+vo.getPassword());
			HttpSession session = request.getSession();
			
			session.setAttribute("memberId", vo.getMemberId());
			session.setAttribute("password", vo.getPassword());
			session.setAttribute("nickname", vo.getNickname());
			
			response.sendRedirect("member/login.jsp");
			
		}else {// 로그인 실패
			request.getSession().setAttribute("messageContent", "아이디와 비밀번호를 확인해주세요.");
			response.sendRedirect("member/login.jsp");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
