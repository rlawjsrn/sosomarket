package com.tbk.prj.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CommunityPostUpdateServlet
 */
@WebServlet("/CommunityPostUpdate.do")
public class CommunityPostUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CommunityPostUpdateServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");

		String postId = request.getParameter("postId");
		String postTitle = request.getParameter("postTitle");
		String postDetail = request.getParameter("postDetail");

		System.out.println("Received parameters - postId: " + postId);
		
		  if (postTitle != null && postDetail != null && !postDetail.isEmpty() && !postTitle.isEmpty()) {
		            CommunityVO post = new CommunityVO();
		            post.setPostId(postId);
		            post.setPostTitle(postTitle);
		            post.setPostDetail(postDetail);

		            CommunityDAO dao = new CommunityDAO();

		            System.out.println("Updating post with ID: " + postId);
		            boolean postUpdated = dao.updatePost(post);
	                response.getWriter().write(postUpdated ? "success" : "failure");
	                if (postUpdated) {
	                    System.out.println("Post updated successfully");
	                } else {
	                    System.out.println("Failed to update post");
	                }
		    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}