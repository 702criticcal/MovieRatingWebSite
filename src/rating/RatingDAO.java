package rating;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class RatingDAO {
	public int write (Rating rating) {
		String sql = "INSERT INTO rating VALUES(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rating.getUserID().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, rating.getMovieName().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, rating.getOpeningYear().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, rating.getWatchingYear());
			pstmt.setInt(5, rating.getWatchingMonth());
			pstmt.setString(6, rating.getMovieDivide().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, rating.getRatingTitle().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, rating.getRatingContent().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, rating.getTotalScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, rating.getStoryScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, rating.getProductionScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, rating.getPerformanceScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(13, rating.getImageScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1; //데이터 베이스 오류
	}
	
	public ArrayList<Rating> getList (String movieDivide, String searchType, String search, int pageNumber) {
		if(movieDivide.equals("전체") ) 
			movieDivide = "";
		ArrayList<Rating> ratingList = null;
		String sql = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("최신순")) {
				sql = "SELECT * FROM rating WHERE movieDivide LIKE ? AND CONCAT(movieName, openingYear, ratingTitle, ratingContent) LIKE "
						+ "? ORDER BY ratingID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if (searchType.equals("추천순")) {
				sql = "SELECT * FROM rating WHERE movieDivide LIKE ? AND CONCAT(movieName, openingYear, ratingTitle, ratingContent) LIKE "
						+ "? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + movieDivide + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			ratingList = new ArrayList<Rating>();
			while(rs.next()) {
				Rating rating = new Rating(rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getInt(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getString(14),
						rs.getInt(15)
				);
				ratingList.add(rating);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return ratingList; //데이터 베이스 오류
	}
	
	public int like(String ratingID) {
		String sql = "UPDATE rating SET likeCount = likeCount + 1 WHERE ratingID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(ratingID));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1; 
	}
	
	public int delete(String ratingID) {
		String sql = "DELETE FROM rating WHERE ratingID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(ratingID));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1; 
	}
	
	public String getUserID(String ratingID) {
		String sql = "SELECT userID FROM rating WHERE ratingID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(ratingID));
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return null; 
	}
}
