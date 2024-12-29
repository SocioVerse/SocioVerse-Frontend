
# SocioVerse Frontend

## Overview
SocioVerse Frontend is a feature-rich social media application designed to offer seamless user experiences. Built with **Flutter**, it provides a responsive and visually appealing interface that caters to diverse functionalities, including user authentication, real-time interactions, and multimedia content management.

## Features

### Authentication
- Secure **Firebase Authentication**.
- Supports email/password login and social sign-ins.

### Real-Time Interactions
- Instant messaging with **Socket.IO** integration.
- Push notifications for new messages, likes, comments, and more.

### Content Management
- Post creation with hashtag and location tagging.
- Stories, threads, and feed management.

### Search and Explore
- Advanced search for hashtags, locations, and user profiles.

### User Profiles
- Detailed user profile with settings for privacy and customization.
- Follow and unfollow functionalities.

## Folder Structure
The project follows a modular structure for maintainability and scalability:

```
│   firebase_options.dart
│   main.dart
│   push_notifications.dart
│
├───Controllers
│   │   activityPageProvider.dart
│   │   bottomNavigationProvider.dart
│   └───Widget
│           newThreadWidgetProvider.dart
│
├───Helper
│   │   api_constants.dart
│   ├───Debounce
│   │       debounce.dart
│   ├───FirebaseHelper
│   │       firebaseHelperFunctions.dart
│   ├───ServiceHelpers
│   │       apiHelper.dart
│   └───SharedPreference
│           shared_preferences_methods.dart
│
├───Models
│       userModel.dart
│       feedModel.dart
│
├───Services
│       authentication_services.dart
│       feed_services.dart
│       user_profile_services.dart
│
├───Sockets
│       socketMain.dart
│
├───Utils
│       CalculatingFunctions.dart
│       Validators.dart
│
└───Views
    ├───Pages
    │   ├───AccountSetup
    │   │       fillProfileDetails.dart
    │   ├───Authentication
    │   │       passwordSignInPage.dart
    │   ├───NavbarScreens
    │   │   ├───Activity
    │   │   │       activityPage.dart
    │   │   ├───Feeds
    │   │   │       feedPage.dart
    │   │   └───UserProfileDetails
    │   │           userProfilePage.dart
    │   ├───SocioThread
    │   │       threadSection.dart
    │   └───SocioVerse
    │           MainPage.dart
    │
    ├───UI
    │       theme.dart
    └───Widgets
            activityListTileWidget.dart
```

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/SocioVerse/SocioVerse-Frontend.git
   ```

2. Navigate to the project directory:
   ```bash
   cd SocioVerse-Frontend
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Set up Firebase:
   - Add your `google-services.json` file in the `/android/app/` directory.
   - Add your `GoogleService-Info.plist` file in the `/ios/Runner/` directory.

5. Run the application:
   ```bash
   flutter run
   ```

## Tech Stack

- **Frontend Framework**: Flutter
- **State Management**: Provider
- **Backend Services**: Firebase
- **Real-Time Communication**: Socket.IO

## Development Guidelines

- Use **Provider** for state management.
- Follow the folder structure to ensure code readability.
- Add reusable widgets to the `/Widgets` directory.
- Test new features thoroughly before merging.


## Contributions
We welcome contributions! Please open an issue or submit a pull request with your proposed changes.

---

For more details, visit the repository: [SocioVerse Frontend](https://github.com/SocioVerse/SocioVerse-Frontend)
