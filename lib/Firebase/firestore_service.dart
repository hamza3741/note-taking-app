import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/note_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch notes for a specific user
  Future<List<Note>> fetchNotes(String userId) async {
    try {
      final querySnapshot = await _db
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => Note.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching notes: $e');
      return [];
    }
  }

  // Add a new note
  Future<void> addNote(Note note, String userId) async {
    try {
      final docRef = await _db.collection('notes').add({
        'title': note.title,
        'content': note.content,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // Optionally, update the Note object with the generated ID
      await docRef.update({'id': docRef.id});
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  // Update an existing note
  Future<void> updateNote(Note note) async {
    try {
      await _db.collection('notes').doc(note.id).update({
        'title': note.title,
        'content': note.content,
      });
    } catch (e) {
      print('Error updating note: $e');
    }
  }

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      await _db.collection('notes').doc(noteId).delete();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
