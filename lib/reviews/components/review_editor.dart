import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class ReviewEditor extends StatefulWidget{

  const ReviewEditor({
    @required this.review,
    @required this.reviewFinished
  });

  final Review review;
  final void Function(Review review) reviewFinished;

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
  bool worthIt;
  bool limitedTime;
  io.File image;
  String type;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.review.name);
    descriptionController = TextEditingController(text: widget.review.description);
    priceController = TextEditingController(text: widget.review.price.toString());
    supplierController = TextEditingController(text: widget.review.supplier);
    rating = widget.review.stars ?? 0;
    worthIt = widget.review.worthIt;
    limitedTime = widget.review.limited;
    image = widget.review.image;
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
           _getWorthIt(),
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

  Widget _getWorthIt() {
    return SwitchListTile(
      value: worthIt,
      onChanged: (bool newWorthIt){
        setState(() {
          worthIt = newWorthIt;
        });
      },
      title: const Text("Worth It?"),
      subtitle: const Text("Was the food worth it?"),
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
    if (image == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.file(image),
    );
  }

  Widget _getPhotoButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Button(
          buttonText: 'Take a image',
          onPressed: () async {
            final io.File cameraImage = _renameImage(await ImagePicker.pickImage(source: ImageSource.camera));
            setState(() {
              image = cameraImage;
            });
          },
        ),
        Button(
          buttonText: "Choose a image",
          onPressed: () async {
            final io.File galleryImage = _renameImage(await ImagePicker.pickImage(source: ImageSource.gallery));
            setState(() {
              image = galleryImage;
            });
          },
        )
      ],
    );
  }

  Widget _getSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Button(
        buttonText: 'Save',
        onPressed: () {
          if (_formKey.currentState.validate()) {
            final Review review = Review(
              name: nameController.text,
              description: descriptionController.text,
              price: double.tryParse(priceController.text),
              stars: rating,
              worthIt: worthIt,
              limited: limitedTime,
              supplier: supplierController.text,
              image: image,
              id: widget.review.id,
              type: type,
              created: DateTime.now()
            );
            widget.reviewFinished(review);
          }
        },
      ),
    );
  }

  io.File _renameImage(io.File file) {
    final String dir = dirname(file.path);
    final String newPath = join(dir, "${widget.review.id}.jpg");
    return file.renameSync(newPath);
  }
}