<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="rating.*, util.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String movieName = null;
	String openingYear = null;
	int watchingYear = 0;
	int watchingMonth = 0;
	String movieDivide = null;
	String ratingTitle = null;
	String ratingContent = null;
	String totalScore = null;
	String storyScore = null;
	String productionScore = null;
	String performanceScore = null;
	String imageScore = null;
	
	if(request.getParameter("movieName") != null)
		movieName = request.getParameter("movieName");
	if(request.getParameter("openingYear") != null)
		openingYear = request.getParameter("openingYear");
	if(request.getParameter("watchingYear") != null) {
		try {
			watchingYear = Integer.parseInt(request.getParameter("watchingYear"));
		} catch(Exception e) {
			System.out.println("시청년도 데이터 오류");
		}
	}
	if(request.getParameter("watchingMonth") != null) {
		try {
			watchingMonth = Integer.parseInt(request.getParameter("watchingMonth"));
		} catch(Exception e) {
			System.out.println("시청월 데이터 오류");
		}
	}
	if(request.getParameter("movieDivide") != null)
		movieDivide = request.getParameter("movieDivide");
	if(request.getParameter("ratingTitle") != null)
		ratingTitle = request.getParameter("ratingTitle");
	if(request.getParameter("ratingContent") != null)
		ratingContent = request.getParameter("ratingContent");
	if(request.getParameter("totalScore") != null)
		totalScore = request.getParameter("totalScore");
	if(request.getParameter("storyScore") != null)
		storyScore = request.getParameter("storyScore");
	if(request.getParameter("productionScore") != null)
		productionScore = request.getParameter("productionScore");
	if(request.getParameter("performanceScore") != null)
		performanceScore = request.getParameter("performanceScore");
	if(request.getParameter("imageScore") != null)
		imageScore = request.getParameter("imageScore");
	
	if(movieName == null || openingYear == null || watchingYear == 0 || watchingMonth == 0 || movieDivide == null || ratingTitle == null || ratingContent == null || totalScore == null ||
		storyScore == null || productionScore == null || performanceScore == null || imageScore == null ||ratingTitle.equals("") || ratingContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	RatingDAO ratingDAO = new RatingDAO();
	int result = ratingDAO.write(new Rating(0, userID, movieName, openingYear, watchingYear, watchingMonth, movieDivide, ratingTitle, ratingContent, totalScore, storyScore,
											productionScore, performanceScore, imageScore, 0));
	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('영화 평가 등록 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>