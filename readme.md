# Kompasid
⚡ Function

- List Berita
- Interaksi Artikel
    - Share
    - Bookmark
    - Detail
- Audio
- Data from JSON


🛠 Tech Stack & Architecture Flow

## Core Technologies
- **Language**: Swift 5.x
- **Architecture**: MVVM (Model-View-ViewModel)
- **UI Framework**: SwiftUI
- **Local Storage**: Core Data
- **Audio**: AVAudioPlayer
- **Data Format**: JSON

## Project Structure
```
Kompasid/
├── App/                    # Application entry point
│   ├── KompasidApp.swift   # Main app configuration
│   └── ContentView.swift   # Root view
├── Models/                 # Data models
│   ├── ArticleModel.swift  # Article data structure
│   ├── BreakingNews.swift  # Breaking news model
│   ├── HotTopics.swift     # Hot topics model
│   └── ...other models
├── Views/                  # SwiftUI Views
│   ├── HomeView.swift      # Main home screen
│   ├── ArticleDetailView.swift # Article detail
│   ├── BookmarkedArticlesView.swift # Bookmarks
│   ├── AudioPlayerView.swift # Audio player
│   └── ...other views
├── ViewModels/             # Business logic
│   └── HomeViewModel.swift # Main view model
├── Services/               # External services
│   ├── JSONDataService.swift # JSON data handling
│   ├── CoreDataService.swift # Database operations
│   └── AudioPlayerManager.swift # Audio management
├── CoreData/               # Database layer
│   ├── CoreDataStack.swift # Core Data setup
│   └── Kompasid.xcdatamodeld # Data model
├── Utils/                  # Utilities & extensions
│   ├── Color+Extensions.swift # Color system
│   └── Article+Extensions.swift # Model extensions
└── Resources/              # Assets & data files
    ├── Assets.xcassets/    # Images & icons
    └── *.json             # Sample data files
```

## Data Flow Architecture
```
JSON Files → JSONDataService → Models → ViewModels → Views
     ↓              ↓              ↓         ↓         ↓
Local Storage ← CoreDataService ← Article ← HomeViewModel ← SwiftUI
```

## Component Interactions
- **Views** → **ViewModels**: User interactions & state binding
- **ViewModels** → **Services**: Data requests & business logic
- **Services** → **Models**: Data transformation & validation
- **CoreData** ↔ **Services**: Persistent storage operations
- **JSON** → **Services**: Initial data loading

📋 Requirements

1. iOS 14.0+
2. Xcode 13.0+
3. Swift 5.x

Demo 

![App Demo](Demo/recording.gif)
