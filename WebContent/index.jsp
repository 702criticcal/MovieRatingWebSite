<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder" %>
<%@ page import="user.*, rating.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>준수의 영화 평가 사이트</title>
<!-- bootstrap CSS 추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- custom CSS 추가 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String movieDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	
	if(request.getParameter("movieDivide") != null) 
		movieDivide = request.getParameter("movieDivide");
	if(request.getParameter("searchType") != null) 
		searchType = request.getParameter("searchType");
	if(request.getParameter("search") != null) 
		search = request.getParameter("search");
	if(request.getParameter("pageNumber") != null) 
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch(Exception e) {
			System.out.println("검색 페이지 번호 오류");
			
		}
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
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(!emailChecked) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">준수의 영화 평가 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null) {
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	} else {
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search"/>
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="movieDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="액션" <% if(movieDivide.equals("액션")) out.println("selected"); %>>액션</option>
				<option value="애니메이션" <% if(movieDivide.equals("애니메이션")) out.println("selected"); %>>애니메이션</option>
				<option value="어린이" <% if(movieDivide.equals("어린이")) out.println("selected"); %>>어린이</option>
				<option value="코미디" <% if(movieDivide.equals("코미디")) out.println("selected"); %>>코미디</option>
				<option value="고전" <% if(movieDivide.equals("고전")) out.println("selected"); %>>고전</option>
				<option value="다큐멘터리" <% if(movieDivide.equals("다큐멘터리")) out.println("selected"); %>>다큐멘터리</option>
				<option value="드라마" <% if(movieDivide.equals("드라마")) out.println("selected"); %>>드라마</option>
				<option value="SF" <% if(movieDivide.equals("SF")) out.println("selected"); %>>SF</option>
				<option value="공포" <% if(movieDivide.equals("공포")) out.println("selected"); %>>공포</option>
				<option value="음악" <% if(movieDivide.equals("음악")) out.println("selected"); %>>음악</option>
				<option value="로맨스" <% if(movieDivide.equals("로맨스")) out.println("selected"); %>>로맨스</option>
				<option value="스릴러" <% if(movieDivide.equals("스릴러")) out.println("selected"); %>>스릴러</option>
				<option value="스포츠" <% if(movieDivide.equals("스포츠")) out.println("selected"); %>>스포츠</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순" <% if(movieDivide.equals("추천순")) out.println("selected"); %>>추천순</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요."/>
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>
<%
	ArrayList<Rating> ratingList = new ArrayList<Rating>();
	ratingList = new RatingDAO().getList(movieDivide, searchType, search, pageNumber);
	if(ratingList != null) 
		for(int i = 0; i < ratingList.size(); i++) {
	if(i == 5) break;
	Rating rating = ratingList.get(i);
%>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= rating.getMovieName()%>&nbsp;<small><%= rating.getOpeningYear()%></small></div>
					<div class="col-4 text-right">
						종합<span style="color: red;"><%= rating.getTotalScore() %></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%= rating.getRatingTitle() %>&nbsp;<small>(<%= rating.getWatchingYear()%>년 <%= rating.getWatchingMonth()%>월)</small>
				</h5>
				<p class="card-text"><%= rating.getRatingContent()%>
				<div class="row">
					<div class="col-9 text-left">
						스토리<span style="color:red;"><%= rating.getStoryScore()%></span>
						연출<span style="color:red;"><%= rating.getProductionScore()%></span>
						연기<span style="color:red;"><%= rating.getPerformanceScore()%></span>
						영상미<span style="color:red;"><%= rating.getImageScore()%></span>
						<span style="color: green;">(추천 : <%= rating.getLikeCount()%>)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?ratingID=<%= rating.getRatingID()%>">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?ratingID=<%= rating.getRatingID()%>">삭제</a>
					</div>
				</div>
			</div>
		</div>
<%
	}
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	 if(pageNumber <= 0) {
%>
			<a class="page-link disabled">이전</a>
<%		 
	 } else {
%>
	<a class="page-link" href="./index.jsp?movieDivide=<%=URLEncoder.encode(movieDivide, "UTF-8") %>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=
	<%= pageNumber - 1 %>">이전</a>
<%
	 }
%>
		</li>
		<li>
<%
	 if(ratingList.size() < 6) {
%>
	<a class="page-link disabled">다음</a>
<%		 
	 } else {
%>
	<a class="page-link" href="./index.jsp?movieDivide=
	<%=URLEncoder.encode(movieDivide, "UTF-8") %>&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>
	&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%= pageNumber + 1 %>">다음</a>
<%
	 }
%>		
		</li>
	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./ratingRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>영화 제목</label>
								<input type="text" name="movieName" class="form-control" maxlength="20"/>
							</div>
							<div class="form-group col-sm-6">
								<label>개봉년도</label>
								<input type="text" name="openingYear" class="form-control" maxlength="4"/>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>시청년도</label>
								<select name="watchingYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020" selected>2020</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>시청월</label>
								<select name="watchingMonth" class="form-control">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12" selected>12</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>영화 장르</label>
								<select name="movieDivide" class="form-control">
									<option value="액션" selected>액션</option>
									<option value="애니메이션">애니메이션</option>
									<option value="어린이">어린이</option>
									<option value="코미디">코미디</option>
									<option value="고전" selected>고전</option>
									<option value="다큐멘터리">다큐멘터리</option>
									<option value="드라마">드라마</option>
									<option value="SF">SF</option>
									<option value="공포" selected>공포</option>
									<option value="음악">음악</option>
									<option value="로맨스">로맨스</option>
									<option value="스릴러">스릴러</option>
									<option value="스포츠" selected>스포츠</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="ratingTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="ratingContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>종합</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>스토리</label>
								<select name="storyScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>연출</label>
								<select name="productionScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>연기</label>
								<select name="performanceScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>영상미</label>
								<select name="imageScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="E">E</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>신고 제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		준수의 영화 평가 사이트
	</footer>
	<!-- jQuery 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- pooper 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap.js 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>