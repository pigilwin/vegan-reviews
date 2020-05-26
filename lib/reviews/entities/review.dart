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

  factory Review.empty() {
    return const Review(
      name: '',
      description: '',
      imagePath: '',
      stars: 0,
      worthIt: false,
      price: 0,
      supplier: '',
      limited: false,
      emoji: ''
    );
  }

  final String name;
  final String description;
  final String imagePath;
  final int stars;
  final bool worthIt;
  final double price;
  final String supplier;
  final bool limited;
  final String emoji;
}