class Methods {
  static calculateRating(double totalStars, int totalReviews) {
    final rating = ((20 * totalStars) / totalReviews) / 20;
    return rating;
  }
}
