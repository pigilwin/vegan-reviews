part of 'reviews_bloc.dart';

class ReviewsService {
  final Firestore _firestore = Firestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List<Review>> fetch() async {
    final QuerySnapshot snapshot = await _firestore.collection('reviews').getDocuments();
    final List<Review> reviews = [];
    for (DocumentSnapshot documentSnapshot in snapshot.documents) {
      
      final Map<String, dynamic> data = documentSnapshot.data;
      final String imageName = data['image-name'];
      
      io.File image;

      if (imageName.isNotEmpty) {
        final io.Directory directory = await getTemporaryDirectory();
        final StorageReference reference = _firebaseStorage.ref().child(imageName);
        image = io.File(join(directory.path, imageName));
        reference.writeToFile(image);
      }
      
      reviews.add(Review(
        id: documentSnapshot.documentID,
        name: data['name'],
        description: data['description'],
        stars: data['stars'],
        type: data['type'],
        image: image,
        supplier: data['supplier'],
        worthIt: _intToBool(data['worthIt']),
        limited: _intToBool(data['limited']),
        price: data['price'],
        created: DateTime.tryParse(data['created'])
      ));
    }
    return reviews;
  }


  Future<void> add(Review review) async {
    final StorageReference reference = _firebaseStorage.ref().child(review.imageName);
    final StorageUploadTask task = reference.putFile(review.image);
    await task.onComplete;
    await _firestore.collection('reviews').document(review.id).setData(review.toMap());
  }

  Future<void> edit(Review review) async {
    await _firebaseStorage.ref().child(review.imageName).delete();
    final StorageUploadTask task = _firebaseStorage.ref().child(review.imageName).putFile(review.image);
    await task.onComplete;
    await _firestore.collection('reviews').document(review.id).setData(review.toMap());
  }

  Future<void> delete(Review review) async {
    review.image.deleteSync();
    await _firebaseStorage.ref().child(review.imageName).delete();
    await _firestore.collection('reviews').document(review.id).delete();
  }

  bool _intToBool(int i) {
    if (i > 0) {
      return true;
    }
    return false;
  }
}