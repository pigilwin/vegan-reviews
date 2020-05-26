part of 'reviews_bloc.dart';

class ReviewsService {
  final Firestore _firestore = Firestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> add(Review review) async {
    final StorageReference reference = _firebaseStorage.ref().child(review.imageName);
    final StorageUploadTask task = reference.putFile(review.image);
    await task.onComplete;
    await _firestore.collection('reviews').document(review.id).setData(review.toMap());
  }
}