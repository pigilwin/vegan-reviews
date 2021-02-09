part of 'reviews_bloc.dart';

class ReviewsService {

  final firestore.FirebaseFirestore _firestore = firestore.FirebaseFirestore.instance;
  final storage.FirebaseStorage _firebaseStorage = storage.FirebaseStorage.instance;

  void onCollectionChanges(Function(List<Review>, List<String>) notifier) {
    _firestore.collection('reviews').snapshots().listen((firestore.QuerySnapshot snapshot) async { 
      final changedReviews = <Review>[];
      final deletedReviews = <String>[];

      for (var change in snapshot.docChanges){
        if (change.type != firestore.DocumentChangeType.removed){
          changedReviews.add(await _fromDocumentChange(change));
        } else {
          deletedReviews.add(change.doc.id);
        }
      }
      notifier(changedReviews, deletedReviews);
    });
  }

  Future<void> add(Review review) async {
    final reference = _firebaseStorage.ref().child(review.imageName);
    await reference.putFile(review.image);
    await _firestore.collection('reviews').doc(review.id).set(review.toMap());
  }

  Future<void> edit(Review review) async {
    if (review.image != null){//If we have selected a new image then we will delete the old one and upload
      try{
        await _firebaseStorage.ref().child(review.imageName).delete();//If the image does exist then delete it
      } on PlatformException {
        print('No image to delete');
      }
      await _firebaseStorage.ref().child(review.imageName).putFile(review.image);
    }
    await _firestore.collection('reviews').doc(review.id).update(review.toMap());
  }

  Future<void> delete(Review review) async {
    try{
      await _firebaseStorage.ref().child(review.imageName).delete();//If the image does exist then delete it
    } on PlatformException {
      print('No image to delete');
    }
    await _firestore.collection('reviews').doc(review.id).delete();
  }

  Future<Review> _fromDocumentChange(firestore.DocumentChange documentChange) async {
    final data = documentChange.doc.data();
    final imageName = '${documentChange.doc.id}.jpg';
    
    var imageUrl = '';
    try{
      final reference = _firebaseStorage.ref().child(imageName);
      imageUrl = await reference.getDownloadURL();
    } on PlatformException{
      imageUrl = '';//An error is thrown if the image is not found
    }
    
    return Review(
      id: documentChange.doc.id,
      name: data['name'],
      description: data['description'],
      stars: data['stars'],
      type: data['type'],
      imageUrl: imageUrl,
      supplier: data['supplier'],
      limited: _intToBool(data['limited']),
      price: data['price'],
      created: DateTime.tryParse(data['created'])
    );
  }

  bool _intToBool(int i) {
    if (i > 0) {
      return true;
    }
    return false;
  }
}