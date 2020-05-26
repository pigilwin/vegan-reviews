import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewEditor extends StatefulWidget{

  const ReviewEditor({
    @required this.review
  });

  final Review review;

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
           _getStars(),
           _getWorthIt(),
           _getLimited(),
           _getSupplier(),
           _getPhotoViewer(),
           _getPhotoButtons(),
           _getSaveButton()
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
        controller: nameController,
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
      value: worthIt,
      onChanged: (bool newWorthIt){
        setState(() {
          worthIt = newWorthIt;
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

  Widget _getPhotoButtons() {
    final Color color = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlatButton(
          color: color,
          child: const Text("Take a image", style: TextStyle(fontSize: 20)),
          onPressed: () async {
            final io.File cameraImage = await ImagePicker.pickImage(source: ImageSource.camera);
            setState(() {
              image = cameraImage;
            });
          },
        ),
        FlatButton(
          color: color,
          child: const Text("Choose a image", style: TextStyle(fontSize: 20)),
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

  Widget _getSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        child: const Text("Save", style: TextStyle(fontSize: 20)),
        onPressed: () {
          if (_formKey.currentState.validate()) {

          }
        },
      ),
    );
  }
}