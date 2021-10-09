import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewCard extends StatelessWidget {

  const ReviewCard({
    required this.review,
    required this.isSaved,
    required this.onTap,
    required this.toggleSave
  });

  final Review review;
  final bool isSaved;
  final VoidCallback? onTap;
  final VoidCallback? toggleSave;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: review.limited ? Colors.red.withOpacity(10) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _getImage(),
              _getText(),
              _getStars(),
              _getPrice(),
              _getSupplier(),
              _getType(),
              _getCreatedTimeWithSaveIcon()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImage() {
    if (review.imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }
    return Image.network(review.imageUrl,
      loadingBuilder: (BuildContext context, Widget widget, ImageChunkEvent? event) {
        if (event == null) {
          return widget;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Widget _getText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: review.name + ': ', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(text: review.description, style: const TextStyle(color: Colors.black))
                ]
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _getStars() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          StarRating(
            key: const Key('can-not-be-editted-star-rating'),
            canBeEditted: false,
            stars: Review.amountOfStars,
            rating: review.stars,
            size: 20.0,
            onRatingChanged: null,
          ),
        ],
      ),
    );
  }

  Widget _getPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(text: 'Price: £', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(text: review.price.toString(), style: const TextStyle(color: Colors.black))
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _getSupplier() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(text: 'Supplier: ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(text: review.supplier, style: const TextStyle(color: Colors.black))
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _getType() {

    String? type = '';
    if (Review.savouryEmojiMap.containsKey(review.type)) {
      type = Review.savouryEmojiMap[review.type];
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(type!, style: const TextStyle(fontSize: 22))
      ],
    );
  }

  Widget _getCreatedTimeWithSaveIcon() {
    final dateFormat = DateFormat.yMMMMEEEEd();
    final icon = isSaved ? Icons.save : Icons.save_outlined;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(dateFormat.format(review.created)),
        IconButton(
          icon: Icon(icon),
          onPressed: toggleSave,
        )
      ],
    );
  }
}