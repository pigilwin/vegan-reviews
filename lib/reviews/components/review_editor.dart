import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class ReviewEditor extends StatefulWidget{

  const ReviewEditor({
    required Key key,
    required this.review,
    required this.reviewFinished,
    this.reviewDeleted
  }): super(key: key);

  final Review review;
  final void Function(Review review, io.File image) reviewFinished;
  final void Function(Review review)? reviewDeleted;

  @override
  _ReviewEditorState createState() => _ReviewEditorState();
}

class _ReviewEditorState extends State<ReviewEditor> {

  final _formKey = GlobalKey<FormState>();//No type here due to it breaking the validation
  
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController supplierController;
  late int rating;
  late bool limitedTime;
  late String imageUrl;
  late String type;

  io.File? image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.review.name);
    descriptionController = TextEditingController(text: widget.review.description);
    priceController = TextEditingController(text: widget.review.price.toString());
    supplierController = TextEditingController(text: widget.review.supplier);
    rating = widget.review.stars;
    limitedTime = widget.review.limited;
    imageUrl = widget.review.imageUrl;
    type = widget.review.type;
  } 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
           _getName(),
           _getDescription(),
           _getPrice(),
           _getType(),
           _getStars(),
           _getLimited(),
           _getSupplier(),
           _getPhotoViewer(),
           _getPhotoButtons(context),
           _getSaveButton(context)
        ],
      ),
    );
  }

  Widget _getName() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Name'
        ),
        validator: (String? name) {
          if (name!.isEmpty) {
            return 'A name must be supplied';
          }
          return null;
        },
        controller: nameController,
      ),
    );
  }

  Widget _getDescription() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Description'
        ),
        validator: (String? name) {
          if (name!.isEmpty) {
            return 'A description must be supplied';
          }
          return null;
        },
        controller: descriptionController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }

  Widget _getPrice() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Price'
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please enter a price';
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid price';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: priceController,
      ),
    );
  }

  Widget _getType() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FoodTypeSelector(
        key: const Key('food-type-selector'),
        selected: (String foodType) {
          setState(() {
            type = foodType;
          });
        },
        value: type,
      ),
    );
  }

  Widget _getStars() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StarRating(
        key: const Key('can-be-editted-star-rating'),
        canBeEditted: true,
        onRatingChanged: (int newRating) {
          setState(() {
            rating = newRating;
          });
        },
        stars: Review.amountOfStars,
        rating: rating,
        size: 30.0,
      ),
    );
  }

  Widget _getLimited() {
    return SwitchListTile(
      value: limitedTime,
      onChanged: (bool newlimitedTime){
        setState(() {
          limitedTime = newlimitedTime;
        });
      },
      title: const Text('Limited time?'),
      subtitle: const Text('Was this a limited time option?'),
    );
  }

  Widget _getSupplier() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: supplierController,
        decoration: const InputDecoration(
          labelText: 'Supplier'
        ),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'A supplier must be set';
          }
          return null;
        },
      ),
    );
  }

  Widget _getPhotoViewer() {
    
    if (image != null){
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Image.file(image!),
      );
    }

    if (imageUrl.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Image.network(imageUrl),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _getPhotoButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Button(
          key: const Key('take-a-image-button'),
          buttonText: 'Take a image',
          onPressed: () async {
            final imagePicker = ImagePicker();
            final cameraImage = await imagePicker.pickImage(source: ImageSource.camera);
            setState(() {
              image = io.File(cameraImage!.path);
            });
          },
        ),
        Button(
          key: const Key('choose-a-image-button'),
          buttonText: 'Choose a image',
          onPressed: () async {
            final imagePicker = ImagePicker();
            final galleryImage = await imagePicker.pickImage(source: ImageSource.gallery);
            setState(() {
              image = io.File(galleryImage!.path);
            });
          },
        )
      ],
    );
  }

  Widget _getSaveButton(BuildContext context) {
    
    Widget deleteButton = const SizedBox.shrink();
    if (widget.reviewDeleted != null) {
      deleteButton = Button(
        key: const Key('delete-a-image-button'),
        buttonText: 'Delete',
        onPressed: () {
          widget.reviewDeleted!(widget.review);
        },
      );
    }
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
            key: const Key('save-button'),
            buttonText: 'Save',
            onPressed: () {
              if (isReviewValid()) {
                final review = Review(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  stars: rating,
                  limited: limitedTime,
                  supplier: supplierController.text,
                  id: widget.review.id,
                  type: type,
                  created: DateTime.now(),
                  imageUrl: widget.review.imageUrl
                );
                widget.reviewFinished(review, image!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Validation failed'),
                ));
              }
            },
          ),
          deleteButton
        ],
      ),
    );
  }

  bool isReviewValid() {
    
    if (imageUrl.isEmpty) {
      return false;
    }

    return _formKey.currentState!.validate();
  }
}