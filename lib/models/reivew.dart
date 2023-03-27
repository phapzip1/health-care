

class Review {
  // final String avatar;
  final String name;
  final DateTime timePosted;
  final double rating;
  final String context;

  Review(
      {required this.name,
      required this.timePosted,
      required this.rating,
      required this.context});
}
