import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/View/login_screen.dart';
import 'package:provider/provider.dart';
import '../ViewModel/Auth_viewmodel.dart';
import '../ViewModel/notes_viewmodel.dart';
import './add_edit_note_screen.dart';
import 'Widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);


    // Fetch the notes once the user is logged in
    final userId = authViewModel.user?.uid ?? '';

    if (userId.isNotEmpty) {
      noteViewModel.fetchNotes(userId);
    }

    // Filtering notes based on search query
    final filteredNotes = _searchQuery.isEmpty
        ? noteViewModel.notes
        : noteViewModel.notes
        .where((note) => note.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();


    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber, // Background color for the header
              ),
              child: Center(
                child: Text(
                  'Hello Dear User!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                authViewModel.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Notes...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),

          // Notes List
          Expanded(
            child: filteredNotes.isEmpty
                ? const Center(
              child: Text(
                'No notes found!',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  return NoteTile(note: filteredNotes[index]);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditNoteScreen(note: null),
            ),
          );
        },
        backgroundColor: Colors.amber[100],
        child: const Icon(Icons.add,color: Colors.black87,),
      ),
    );
  }
}
