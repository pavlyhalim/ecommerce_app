class Review {
  final String reviewerName;
  final String reviewText;
  final double rating;
  int likes;
  final List<String> comments;

  Review({
    required this.reviewerName,
    required this.reviewText,
    required this.rating,
    this.likes = 0,
    required this.comments,
  });
}