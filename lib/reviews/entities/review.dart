class Review {

  const Review({
    this.name,
    this.description,
    this.imagePath,
    this.stars,
    this.worthIt,
    this.price,
    this.supplier,
    this.limited,
    this.emoji
  });

  final String name;
  final String description;
  final String imagePath;
  final int stars;
  final bool worthIt;
  final int price;
  final String supplier;
  final bool limited;
  final String emoji;
}