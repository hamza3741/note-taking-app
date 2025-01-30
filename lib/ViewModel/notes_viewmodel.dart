import 'package:flutter/material.dart';
import '../Firebase/firestore_service.dart';
import '../Model/note_model.dart';

class NoteViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Note> notes = [];
  List<Note> filteredNotes = [];

  Future<void> fetchNotes(String userId) async {
    notes = await _firestoreService.fetchNotes(userId);
    notifyListeners();
  }

  void searchNotes(String query) {
    if (query.isEmpty) {
      filteredNotes = notes;
    } else {
      filteredNotes = notes.where((note) => note.title.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  Future<void> addNote(Note note, String userId) async {
    await _firestoreService.addNote(note, userId);
    await fetchNotes(userId);
  }

  Future<void> updateNote(Note note ) async {
    await _firestoreService.updateNote(note);
    notifyListeners();
  }

  Future<void> deleteNote(String noteId) async {
    await _firestoreService.deleteNote(noteId);
    notes.removeWhere((note) => note.id == noteId);
    notifyListeners();
  }
}
