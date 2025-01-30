#Note-Taking App with Firebase(Flutter Bootcamp Project)

#Overview
The Note-Taking App is a Flutter-based application that allows users to create, edit, delete, and view notes along with search functionality. It integrates Firebase Authentication for user login and Firestore for storing and retrieving notes. The app follows the MVVM (Model-View-ViewModel) design pattern to separate concerns and ensure clean architecture.

#Key Features:
• Firebase Authentication: Users can sign up and log in using email/password authentication.
• Note Management: Users can add, edit, search and delete notes. Notes are stored and retrieved from Firestore.
• State Management: The app uses Provider to manage the authentication state and note state.
• Firestore Integration: Notes are stored in Firestore under each user's unique UID.
• UI Components: A simple and clean UI with a login screen, home screen to list notes, and screens to add/edit notes.

#Project Stucture:
lib/
├── main.dart                  # Entry point for the app.
├── models/
│   └── note_model.dart        # Contains the Note model.
├── view/
│   ├── login_screen.dart      # Login screen for authentication.
│   ├── signup_screen.dart     # Signup screen for new users.
│   ├── home_screen.dart       # Home screen where notes are displayed.
│   ├── add_edit_note_screen.dart  # Screen for adding and editing notes.
│   └── widgets/
│       └── note_tile.dart     # Widget to display individual note details.
├── viewmodel/
│   ├── auth_viewmodel.dart    # Logic for handling authentication.
│   └── notes_viewmodel.dart   # Logic for handling notes (CRUD operations).
└── firebase/
    ├── firestore_service.dart # Service for interacting with Firestore.
    └── auth_service.dart # Service for Firebase Authentication.


#Firestore Rules:
service cloud.firestore {
  match /databases/{database}/documents {
    // Match any document in the Firestore database
    match /{document=**} {
      // Allow read and write if the user is authenticated
      allow read, write: if request.auth != null;
    }
  }
}


