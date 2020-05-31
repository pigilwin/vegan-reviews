import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class ReviewEditor extends StatefulWidget{

  const ReviewEditor({
    @required this.review,
    @required this.reviewFinished,
    this.reviewDeleted
  });

  final Review review;
  final void Function(Review review) reviewFinished;
  final void Function(Review review) reviewDeleted;

  @override
  _ReviewEditorState createState() => _ReviewEditorState();
}

class _ReviewEditorState extends State<ReviewEditor> {

  final _formKey = GlobalKey<FormState>();//No type here due to it breaking the validation
  
  TextEditingController nameController;
  TextEditingController descriptionController;
  TextEditingController priceController;
  TextEditingController supplierController;
  int rating;
  bool limitedTime;
  io.File image;
  String imageUrl;
  String type;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.review.name);
    descriptionController = TextEditingController(text: widget.review.description);
    priceController = TextEditingController(text: widget.review.price.toString());
    supplierController = TextEditingController(text: widget.review.supplier);
    rating = widget.review.stars ?? 0;
    limitedTime = widget.review.limited;
    image = widget.review.image;
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
        validator: (String name) {
          if (name.isEmpty) {
            return "A name must be supplied";
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
        validator: (String name) {
          if (name.isEmpty) {
            return "A description must be supplied";
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
        validator: (String value) {
          if (value.isEmpty) {
            return "Please enter a price";
          }
          if (double.tryParse(value) == null) {
            return "Please enter a valid price";
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
        canBeEditted: true,
        onRatingChanged: (int newRating) {
          setState(() {
            rating = newRating;
          });
        },
        stars: 10,
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
      title: const Text("Limited time?"),
      subtitle: const Text("Was this a limited time option?"),
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
        validator: (String value) {
          if (value.isEmpty) {
            return "A supplier must be set";
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
        child: Image.file(image),
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
          buttonText: 'Take a image',
          onPressed: () async {
            final io.File cameraImage = await ImagePicker.pickImage(source: ImageSource.camera);
            setState(() {
              image = cameraImage;
            });
          },
        ),
        Button(
          buttonText: "Choose a image",
          onPressed: () async {
            final io.File galleryImage = await ImagePicker.pickImage(source: ImageSource.gallery);
            setState(() {
              image = galleryImage;
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
        buttonText: 'Delete',
        onPressed: () {
          widget.reviewDeleted(widget.review);
        },
      );
    }
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
            buttonText: 'Save',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                final Review review = Review(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text),
                  stars: rating,
                  limited: limitedTime,
                  supplier: supplierController.text,
                  id: widget.review.id,
                  type: type,
                  created: DateTime.now(),
                  imageUrl: widget.review.imageUrl
                );
                review.image = image;
                widget.reviewFinished(review);
              }
            },
          ),
          deleteButton
        ],
      ),
    );
  }
}