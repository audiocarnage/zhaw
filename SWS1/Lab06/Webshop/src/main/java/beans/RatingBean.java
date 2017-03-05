package beans;

import helpClasses.Rating;

import java.util.ArrayList;

public class RatingBean {

	// This variable holds all ratings
	private ArrayList<Rating> allRatings;

	// This variable holds the current rating
	private ArrayList<Rating> ratingList;

	public ArrayList<Rating> getAllRatings() {
		return allRatings;
	}

	public void setAllRatings(ArrayList<Rating> allRatings) {
		this.allRatings = allRatings;
	}

	public ArrayList<Rating> getRatingListByProductID(int productID) {

		ArrayList<Rating> ratingListByProductID = new ArrayList<Rating>();
		for (Rating rating : allRatings) {
			if (rating.getProductID() == productID) {
				ratingListByProductID.add(rating);
			}
		}
		return ratingListByProductID;
	}

	public ArrayList<Rating> getRatingListByShopUserID(int shopUserID) {
		ArrayList<Rating> ratingListByShopUserID = new ArrayList<Rating>();
		for (Rating rating : allRatings) {
			if (rating.getProductID() == shopUserID) {
				ratingListByShopUserID.add(rating);
			}
		}
		return ratingListByShopUserID;
	}

	public int getAverageMark(int productID) {
		int sum = 0, i = 0;
		for (Rating rating : allRatings) {
			if (rating.getProductID() == productID) {
				sum += rating.getMark();
				i++;
			}
		}
		return i == 0 ? 0 : sum / i;
	}

	public ArrayList<Rating> getRatingList() {
		return ratingList;
	}

	public void setRatingList(ArrayList<Rating> ratingList) {
		this.ratingList = ratingList;
	}

}
