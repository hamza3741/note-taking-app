import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/note_model.dart';
import '../../ViewModel/notes_viewmodel.dart';
import '../add_edit_note_screen.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  const NoteTile({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.amber.shade400, // Light yellowish background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Better spacing
        title: Text(
          note.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Make title bold
            fontSize: 16, // Slightly larger font
            color: Colors.black87, // Darker text for readability
          ),
        ),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black54), // Subtle text color for subtitle
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueAccent), // Make edit icon blue
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddEditNoteScreen(note: note)),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red), // Keep delete icon red
              onPressed: () {
                Provider.of<NoteViewModel>(context, listen: false).deleteNote(note.id!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
