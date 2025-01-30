import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/Model/note_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ViewModel/notes_viewmodel.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({Key? key, required this.note}) : super(key: key);

  final Note? note; // Added support for editing existing notes

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      // If editing, populate the fields with the existing note's details
      titleController.text = widget.note?.title ?? ''; // Handle null safely
      contentController.text = widget.note?.content ?? ''; // Handle null safely
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50], // Light cream background
      appBar: AppBar(
        title: Text(
          widget.note == null ? 'Add Note' : 'Edit Note',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber, // Yellowish theme
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Title TextField
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Title cannot be empty' : null,
                ),
                const SizedBox(height: 16),
        
                // Content TextField
                TextFormField(
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    labelStyle: TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 10,
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? 'Content cannot be empty'
                      : null,
                ),
                const SizedBox(height: 24),
        
                // Save Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final noteViewModel =
                      Provider.of<NoteViewModel>(context, listen: false);
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No user signed in.')),
                        );
                        return;
                      }
                      final userId = user.uid;
                      final noteId =
                          widget.note?.id ?? DateTime
                              .now()
                              .millisecondsSinceEpoch
                              .toString();
        
                      final note = Note(
                        id: noteId,
                        title: titleController.text.isEmpty
                            ? 'Untitled'
                            : titleController.text,
                        content: contentController.text.isEmpty
                            ? 'No content'
                            : contentController.text,
                      );
        
                      if (widget.note == null) {
                        await noteViewModel.addNote(note, userId);
                      } else {
                        await noteViewModel.updateNote(note);
                      }
        
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.note == null ? 'Save' : 'Update',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold,),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(80, 50),
                    backgroundColor: Colors.amber.shade800,
                    // Darker yellow button
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
