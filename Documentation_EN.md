# PhotoManagerApp Documentation

## Table of Contents

1. [Project Overview](#project-overview)
2. [Specifications](#specifications)
3. [Project Structure](#project-structure)
4. [Client Module](#client-module)
    - [Models](#models-client)
    - [ViewModels](#viewmodels-client)
    - [Views](#views-client)
    - [MainApp_Client](#mainapp_client)
5. [Server Module](#server-module)
    - [Models](#models-server)
    - [Controllers](#controllers-server)
    - [Migrations](#migrations-server)
    - [Services](#services-server)
    - [MainApp_Server](#mainapp_server)
6. [Testing](#testing)
    - [Client Tests](#client-tests)
    - [Server Tests](#server-tests)
    - [Shared Tests](#shared-tests)
    - [Client UI Tests](#client-ui-tests)

## Project Overview

PhotoManagerApp is a client-server application built with Swift and Vapor, designed for managing photos, albums, users, and comments. The application includes a client module written with SwiftUI and a server module using Vapor and Fluent.

## Specifications

### Functional Requirements
1. User registration and login functionality.
2. Photo upload and storage.
3. Album creation and management.
4. Commenting system for photos.
5. Admin panel for managing users and content.

### Non-functional Requirements
1. The application should ensure data integrity and security.
2. The system should be scalable to handle multiple users and large photo storage.

### Project Description
PhotoManagerApp is designed to provide a seamless experience for managing photo albums and user interactions. The application allows users to register, upload photos, create albums, and comment on photos. Admin users have additional capabilities to manage the content and users.

### Potential Users
1. Photographers
2. Social media enthusiasts
3. General users who want to manage their photo collections.

### Benefits
1. Easy and organized way to manage photos and albums.
2. User-friendly interface for uploading and viewing photos.
3. Interactive features like commenting enhance user engagement.

## Project Structure

```plaintext
PhotoManagerApp_Swift_Project4/
├── Client
│   ├── Assets
│   │   ├── AppIcon.appiconset
│   │   ├── AccentColor.colorset
│   ├── Preview Content
│   │   ├── Preview Assets.xcassets
│   ├── ViewModels
│   │   ├── AlbumViewModel.swift
│   │   ├── UserViewModel.swift
│   │   ├── CommentViewModel.swift
│   │   ├── PhotoViewModel.swift
│   ├── Views
│   │   ├── AlbumDetailView.swift
│   │   ├── AdminPanelView.swift
│   │   ├── LoginView.swift
│   │   ├── AlbumListView.swift
│   │   ├── UserDetailView.swift
│   │   ├── RegisterView.swift
│   │   ├── PhotoListView.swift
│   │   ├── CommentDetailView.swift
│   │   ├── ContentView.swift
│   │   ├── CommentView.swift
│   │   ├── PhotoDetailView.swift
│   ├── Models
│   │   ├── CommentModel_Client.swift
│   │   ├── UserModel_Client.swift
│   │   ├── PhotoModel_Client.swift
│   │   ├── AlbumModel_Client.swift
│   ├── MainApp_Client.swift
├── Server
│   ├── Migrations
│   │   ├── CreateUser.swift
│   │   ├── CreateAlbum.swift
│   │   ├── CreateComment.swift
│   │   ├── CreatePhoto.swift
│   ├── Services
│   │   ├── AuthService.swift
│   │   ├── PhotoStorageService.swift
│   ├── Models
│   │   ├── UserModel_Server.swift
│   │   ├── AlbumModel_Server.swift
│   │   ├── PhotoModel_Server.swift
│   │   ├── CommentModel_Server.swift
│   ├── Controllers
│   │   ├── UserController_Server.swift
│   │   ├── PhotoController_Server.swift
│   │   ├── CommentController_Server.swift
│   │   ├── AlbumController_Server.swift
│   ├── MainApp_Server.swift
├── SharedTests
│   ├── SharedTests.swift
├── ServerTests
│   ├── ServerTests.swift
├── ClientTests
│   ├── ClientTests.swift
├── ClientUITests
│   ├── ClientUITests.swift
│   ├── ClientUITestsLaunchTests.swift
├── .gitignore
├── .gitattributes
├── LICENSE
└── README.md
```

## Client Module

### Models (Client)

- **CommentModel_Client.swift**
  - **Properties**:
    - id (UUID),
    - text (String),
    - photoID (UUID),
    - userID (UUID)
  - **Primary Key**: id
  - **Foreign Keys**:
    - photoID,
    - userID
  - **Relations**: Belongs to User and Photo

- **UserModel_Client.swift**
  - **Properties**:
    - id (UUID),
    - username (String),
    - email (String),
    - password (String)
  - **Primary Key**: id
  - **No Foreign Keys**
  - **Relations**: Has many Comments, Has many Albums

- **PhotoModel_Client.swift**
  - **Properties**:
    - id (UUID),
    - title (String),
    - url (String),
    - albumID (UUID)
  - **Primary Key**: id
  - **Foreign Key**: albumID
  - **Relations**: Belongs to Album, Has many Comments

- **AlbumModel_Client.swift**
  - **Properties**:
    - id (UUID),
    - title (String),
    - userID (UUID)
  - **Primary Key**: id
  - **Foreign Key**: userID
  - **Relations**: Belongs to User, Has many Photos

### ViewModels (Client)

- **AlbumViewModel.swift**
  - **Methods**:
    - _fetchAlbums()_
    - _createAlbum()_
    - _updateAlbum()_
    - _deleteAlbum()_
  - **Properties**:
    - albums (Published<[Album]>)
  - **Description**: Manages the state and logic for album-related views.

- **UserViewModel.swift**
  - **Methods**:
    - _fetchUsers()_
    - _createUser()_
    - _updateUser()_
    - _deleteUser()_
  - **Properties**:
    - users (Published<[User]>)
  - **Description**: Manages the state and logic for user-related views.

- **CommentViewModel.swift**
  - **Methods**:
    - _fetchComments()_
    - _createComment()_
    - _updateComment()_
    - _deleteComment()_
  - **Properties**:
    - comments (Published<[Comment]>)
  - **Description**: Manages the state and logic for comment-related views.

- **PhotoViewModel.swift**
  - **Methods**:
    - _fetchPhotos()_
    - _createPhoto()_
    - _updatePhoto()_
    - _deletePhoto()_
  - **Properties**:
    - photos (Published<[Photo]>)
  - **Description**: Manages the state and logic for photo-related views.

### Views (Client)

- **AlbumDetailView.swift**
  - **Description**: Displays the details of a specific album, including its photos.
  - **Methods**: view body displaying album details and photos, update and delete album functionalities.

- **AdminPanelView.swift**
  - **Description**: Admin panel for managing users and content.
  - **Methods**:view body displaying admin options, user and content management functionalities.

- **LoginView.swift**
  - **Description**: View for user login.
  - **Methods**:view body displaying login form, login functionality.

- **AlbumListView.swift**
  - **Description**: View for listing all albums.
  - **Methods**:view body displaying list of albums, fetch albums functionality.

- **UserDetailView.swift**
  - **Description**: Displays the details of a specific user.
  - **Methods**:view body displaying user details, update and delete user functionalities.

- **RegisterView.swift**
  - **Description**: View for user registration.
  - **Methods**:view body displaying registration form, register functionality.

- **PhotoListView.swift**
  - **Description**: View for listing all photos.
  - **Methods**:view body displaying list of photos, fetch photos functionality.

- **CommentDetailView.swift**
  - **Description**: Displays the details of a specific comment.
  - **Methods**:view body displaying comment details, update and delete comment functionalities.

- **ContentView.swift**
  - **Description**: Main view of the application. Navigation to login and registration views.
  - **Methods**:view body with navigation links to LoginView and RegisterView.

- **CommentView.swift**
  - **Description**: View for creating and managing comments.
  - **Methods**:view body displaying comment form, create and update comment functionalities.

- **PhotoDetailView.swift**
  - **Description**: Displays the details of a specific photo.
  - **Methods**:view body displaying photo details, update and delete photo functionalities.

### MainApp_Client.swift

- **MainApp_Client.swift**
  - **Description**: Entry point of the client application.
  - **Methods**: struct MainApp_Client conforming to SwiftUI.App, Scene body with WindowGroup displaying ContentView.

## Server Module

### Models (Server)

- **UserModel_Server.swift**
  - **Properties**:
    - id (UUID),
    - username (String),
    - email (String),
    - password (String)
  - **Primary Key**: id
  - **No Foreign Keys**
  - **Relations**: Has many Comments, Has many Albums

- **AlbumModel_Server.swift**
  - **Properties**:
    - id (UUID),
    - title (String),
    - userID (UUID)
  - **Primary Key**: id
  - **Foreign Key**: userID
  - **Relations**: Belongs to User, Has many Photos

- **PhotoModel_Server.swift**
  - **Properties**:
    - id (UUID),
    - title (String),
    - url (String), albumID (UUID)
  - **Primary Key**: id
  - **Foreign Key**: albumID
  - **Relations**: Belongs to Album, Has many Comments

- **CommentModel_Server.swift**
  - **Properties**:
    - id (UUID),
    - text (String),
    - photoID (UUID),
    - userID (UUID)
  - **Primary Key**: id
  - **Foreign Keys**: photoID, userID
  - **Relations**: Belongs to User and Photo

### Controllers (Server)

**UserController_Server.swift**

- **Methods**:
  - _boot(routes: RoutesBuilder)_
    - **HTTP method**: None
    - **Access**: public
    - **Description**: Registers routes for user-related actions.

  - _login(req: Request)_
    - **HTTP method**: POST
    - **Access**: public
    - **Description**: Authenticates a user.

  - _register(req: Request)_
    - **HTTP method**: POST
    - **Access**: public
    - **Description**: Registers a new user.

  - _getAllUsers(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches all users.

  - _getUser(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches all users.

  - _updateUser(req: Request)_
    - **HTTP method**: PUT
    - **Access**: public
    - **Description**: Updates a specific user's details.

  - _deleteUser(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: public
    - **Description**: Deletes a specific user.

- **Fields and Properties**: None

- **Description**: Manages user-related operations including authentication, registration, and CRUD operations.

**PhotoController_Server.swift**

- **Methods**:
  - _boot(routes: RoutesBuilder)_
    - **HTTP method**: None
    - **Access**: public
    - **Description**: Registers routes for photo-related actions.

  - _create(req: Request)_
    - **HTTP method**: POST
    - **Access**: public
    - **Description**: Creates a new photo.

  - _getAll(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches all photos.

  - _get(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches a specific photo by ID.

  - _update(req: Request)_
    - **HTTP method**: PUT
    - **Access**: public
    - **Description**: Updates a specific photo's details.

  - _delete(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: public
    - **Description**: Deletes a specific photo.

- **Fields and Properties**: None

- **Description**: Manages photo-related operations including creation, retrieval, update, and deletion.

**CommentController_Server.swift**

- **Methods**:
  - _boot(routes: RoutesBuilder)_ - Registers routes for comment-related actions (public).
    - **HTTP method**: None
    - **Access**: public
    - **Description**: Registers routes for comment-related actions.

  - _create(req: Request)_
    - **HTTP method**: POST
    - **Access**: public
    - **Description**: Creates a new comment.

  - _getAll(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches all comments.

  - _get(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches a specific comment by ID .

  - _update(req: Request)_
    - **HTTP method**: PUT
    - **Access**: public
    - **Description**: Updates a specific comment's details.

  - _delete(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: public
    - **Description**: Deletes a specific comment.

- **Fields and Properties**: None

- **Description**: Manages comment-related operations including creation, retrieval, update, and deletion.

**AlbumController_Server.swift**

- **Methods**:
  - _boot(routes: RoutesBuilder)_
    - **HTTP method**: None
    - **Access**: public
    - **Description**: Registers routes for album-related actions.

  - _create(req: Request)_
    - **HTTP method**: POST
    - **Access**: public
    - **Description**: Creates a new album.

  - _getAll(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches all albums.

  - _get(req: Request)_
    - **HTTP method**: GET
    - **Access**: public
    - **Description**: Fetches a specific album by ID.

  - _update(req: Request)_
    - **HTTP method**: PUT
    - **Access**: public
    - **Description**: Updates a specific album's details.

  - _delete(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: public
    - **Description**: Deletes a specific album.

- **Fields and Properties**: None

- **Description**: Manages album-related operations including creation, retrieval, update, and deletion.

### Migrations (Server)

**CreateUser.swift**

**Class**: _CreateUser_

- **Methods**:
  - _prepare(on: Database)_ - creates the users table.
  - _revert(on: Database)_ - deletes the users table.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the users table.

**CreateAlbum.swift**

**Class**: _CreateAlbum_

- **Methods**:
  - _prepare(on: Database)_ - creates the albums table.
  - _revert(on: Database)_ - deletes the albums table.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the albums table.

**CreateComment.swift**

**Class**: _CreateComment_

- **Methods**:
  - _prepare(on: Database)_ - creates the comments table.
  - _revert(on: Database)_ - deletes the comments table.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the comments table.

**CreatePhoto.swift**

**Class**: _CreatePhoto_
- **Methods**:
  - _prepare(on: Database)_ - creates the photos table.
  - _revert(on: Database)_ - deletes the photos table.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the photos table.

### Services (Server)

**AuthService.swift**

- **Methods**:
  - _register(req: Request)_ - Registers a new user (public).
  - _login(req: Request)_ - Authenticates a user (public).

- **Fields and Properties**: None

- **Description**: Provides authentication services including user registration and login.

**PhotoStorageService.swift**

- **Methods**:
  - _storePhoto(req: Request, photo: ServerPhoto)_ - Stores a photo on the server (public).
  - _fetchPhoto(req: Request, photoID: UUID)_ - _fetches a photo from the server (public).

- **Fields and Properties**: None

- **Description**: Provides photo storage services including storing and fetching photos from the server.

### MainApp_Server.swift

**MainApp_Server.swift**

- **Methods**:
  - _main()_ - Entry point of the server application (private).
  - _configure(_ app: Application)_ - Configures the database and performs migrations (private).
  - _routes(_ app: Application)_ - Registers routes for the application (private).
    - **Routes**:
      - POST _/register_ - Registers a new user.
      - POST _/login_ - Authenticates a user.
      - POST _/storePhoto_ - Stores a photo.
      - GET _/fetchPhoto/:photoID_ - fetches a photo by ID.

- **Properties**: None

- **Description**: Main entry point of the server application, handling configuration, migrations, and routing.

## Testing

### Client Tests

**ClientTests.swift**

- **Methods**:
  - _setUp()_ - Sets up the testing environment (override).
    - Access: public (override)
    - Description: .

  - _tearDown()_ - Tears down the testing environment (override).
    - Access: public (override)
    - Description: .

  - _testExample()_ - Example test method (public).
    - Access: 
    - Description: .

  - _testExample()_ - Example test method (public).
    - Access: 
    - Description: .

**Description**: Contains unit tests for the client module.

### Server Tests

**ServerTests.swift**

- **Methods**:
  - _setUpWithError()_ - Sets up the testing environment (override).
    - Access: 
    - Description: .

  - _tearDownWithError()_ - Tears down the testing environment (override).
    - Access: 
    - Description: .

  - _configure(_ app: Application)_ - Configures the application for testing (private).
    - Access: 
    - Description: .

  - _testUserCreation()_ - Tests user creation functionality (public).
    - Access: 
    - Description: .

  - _testPhotoCreation()_ - Tests photo creation functionality (public).
    - Access: 
    - Description: .

**Description**: Contains unit tests for the server module.

### Shared Tests

**SharedTests.swift**

- **Methods**:
  - _setUp()_ - Sets up the testing environment (override).
    - Access: 
    - Description: .

  - tearDown() - Tears down the testing environment (override).
    - Access: 
    - Description: .

  - testExample() - Example test method (public).
    - Access: 
    - Description: .

**Description**: Contains shared tests that apply to both client and server modules.

### Client UI Tests

**ClientUITests.swift**

- **Methods**:
  - setUp() - Sets up the testing environment (override).
    - Access: 
    - Description: .

  - tearDown() - Tears down the testing environment (override).
    - Access: 
    - Description: .

  - testExample() - Example UI test method (public).
    - Access: 
    - Description: .

**Description**: Contains UI tests for the client module.

**ClientUITestsLaunchTests.swift**

- **Methods**:
  - setUp() - Sets up the testing environment (override).
    - Access: 
    - Description: .

  - testLaunch() - Tests the app launch functionality (public).
    - Access: 
    - Description: .

**Description**: Contains launch tests for the client module.