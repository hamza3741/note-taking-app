# Note-Taking App with Firebase(Flutter Bootcamp Project)

# Overview
The Note-Taking App is a Flutter-based application that allows users to create, edit, delete, and view notes along with search functionality. It integrates Firebase Authentication for user login and Firestore for storing and retrieving notes. The app follows the MVVM (Model-View-ViewModel) design pattern to separate concerns and ensure clean architecture.

# Key Features:
• Firebase Authentication: Users can sign up and log in using email/password authentication. <br>
• Note Management: Users can add, edit, search and delete notes. Notes are stored and retrieved from Firestore. <br>
• State Management: The app uses Provider to manage the authentication state and note state. <br>
• Firestore Integration: Notes are stored in Firestore under each user's unique UID.<br>
• UI Components: A simple and clean UI with a login screen, home screen to list notes, and screens to add/edit notes.<br> 

# Project Stucture:
lib/ <br>
├── main.dart                  # Entry point for the app. <br>
├── models/ <br>
│   └── note_model.dart        # Contains the Note model. <br>
├── view/ <br>
│   ├── login_screen.dart      # Login screen for authentication. <br>
│   ├── signup_screen.dart     # Signup screen for new users. <br>
│   ├── home_screen.dart       # Home screen where notes are displayed. <br>
│   ├── add_edit_note_screen.dart  # Screen for adding and editing notes. <br>
│   └── widgets/ <br>
│       └── note_tile.dart     # Widget to display individual note details. <br>
├── viewmodel/ <br>
│   ├── auth_viewmodel.dart    # Logic for handling authentication. <br>
│   └── notes_viewmodel.dart   # Logic for handling notes (CRUD operations). <br>
└── firebase/ <br>
    ├── firestore_service.dart # Service for interacting with Firestore. <br>
    └── auth_service.dart # Service for Firebase Authentication. <br>


# Firestore Rules:
service cloud.firestore { <br>
  match /databases/{database}/documents { <br>
    // Match any document in the Firestore database <br>
    match /{document=**} { <br>
      // Allow read and write if the user is authenticated <br>
      allow read, write: if request.auth != null; <br>
    } <br>
  } <br>
} <br>


