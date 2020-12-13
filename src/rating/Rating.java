package rating;

public class Rating {
	int ratingID;
	String userID;
	String movieName;
	String openingYear;
	int watchingYear;
	int watchingMonth;
	String movieDivide;
	String ratingTitle;
	String ratingContent;
	String totalScore;
	String storyScore;
	String productionScore;
	String performanceScore;
	String imageScore;
	int likeCount;
	
	public Rating() {
		
	}
	
	public Rating(int ratingID, String userID, String movieName, String openingYear, int watchingYear,
			int watchingMonth, String movieDivide, String ratingTitle, String ratingContent,
			String totalScore, String storyScore, String productionScore, String performanceScore, String imageScore, int likeCount) {
		super();
		this.ratingID = ratingID;
		this.userID = userID;
		this.movieName = movieName;
		this.openingYear = openingYear;
		this.watchingYear = watchingYear;
		this.watchingMonth = watchingMonth;
		this.movieDivide = movieDivide;
		this.ratingTitle = ratingTitle;
		this.ratingContent = ratingContent;
		this.totalScore = totalScore;
		this.storyScore = storyScore;
		this.productionScore = productionScore;
		this.performanceScore = performanceScore;
		this.imageScore = imageScore;
		this.likeCount = likeCount;
	}
	
	public int getRatingID() {
		return ratingID;
	}
	public void setRatingID(int ratingID) {
		this.ratingID = ratingID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getOpeningYear() {
		return openingYear;
	}
	public void setOpeningYear(String openingYear) {
		this.openingYear = openingYear;
	}
	public int getWatchingYear() {
		return watchingYear;
	}
	public void setWatchingYear(int watchingYear) {
		this.watchingYear = watchingYear;
	}
	public int getWatchingMonth() {
		return watchingMonth;
	}
	public void setWatchingMonth(int watchingMonth) {
		this.watchingMonth = watchingMonth;
	}
	public String getMovieDivide() {
		return movieDivide;
	}
	public void setMovieDivide(String movieDivide) {
		this.movieDivide = movieDivide;
	}
	public String getRatingTitle() {
		return ratingTitle;
	}
	public void setRatingTitle(String ratingTitle) {
		this.ratingTitle = ratingTitle;
	}
	public String getRatingContent() {
		return ratingContent;
	}
	public void setRatingContent(String ratingContent) {
		this.ratingContent = ratingContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getStoryScore() {
		return storyScore;
	}
	public void setStoryScore(String storyScore) {
		this.storyScore = storyScore;
	}
	public String getProductionScore() {
		return productionScore;
	}
	public void setProductionScore(String productionScore) {
		this.productionScore = productionScore;
	}
	public String getPerformanceScore() {
		return performanceScore;
	}
	public void setPerformanceScore(String performanceScore) {
		this.performanceScore = performanceScore;
	}
	public String getImageScore() {
		return imageScore;
	}
	public void setImageScore(String imageScore) {
		this.imageScore = imageScore;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
	
}
