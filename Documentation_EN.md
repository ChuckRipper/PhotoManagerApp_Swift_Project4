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
    - fetchAlbums(),
    - createAlbum(),
    - updateAlbum(),
    - deleteAlbum()
  - **Properties**:
    - albums (Published<[Album]>)
  - **Description**: Manages the state and logic for album-related views.
- **UserViewModel.swift**
  - **Methods**:
    - fetchUsers(),
    - createUser(),
    - updateUser(),
    - deleteUser()
  - **Properties**:
    - users (Published<[User]>)
  - **Description**: Manages the state and logic for user-related views.
- **CommentViewModel.swift**
  - **Methods**:
    - fetchComments(),
    - createComment(),
    - updateComment(),
    - deleteComment()
  - **Properties**:
    - comments (Published<[Comment]>)
  - **Description**: Manages the state and logic for comment-related views.
- **PhotoViewModel.swift**
  - **Methods**:
    - fetchPhotos(),
    - createPhoto(),
    - updatePhoto(),
    - deletePhoto()
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
MainApp_Client.swift
**Description**: Entry point of the client application.
  - **Methods**:struct MainApp_Client conforming to SwiftUI.App, Scene body with WindowGroup displaying ContentView.
Server Module
Models (Server)
UserModel_Server.swift

Properties: id (UUID), username (String), email (String), password (String)
Primary Key: id
No Foreign Keys
Relations: Has many Comments, Has many Albums
AlbumModel_Server.swift

Properties: id (UUID), title (String), userID (UUID)
Primary Key: id
Foreign Key: userID
Relations: Belongs to User, Has many Photos
PhotoModel_Server.swift

Properties: id (UUID), title (String), url (String), albumID (UUID)
Primary Key: id
Foreign Key: albumID
Relations: Belongs to Album, Has many Comments
CommentModel_Server.swift

Properties: id (UUID), text (String), photoID (UUID), userID (UUID)
Primary Key: id
Foreign Keys: photoID, userID
Relations: Belongs to User and Photo
Controllers (Server)
UserController_Server.swift

Methods:
boot(routes: RoutesBuilder) - Registers routes for user-related actions (public).
login(req: Request) - Authenticates a user (public).
register(req: Request) - Registers a new user (public).
getAllUsers(req: Request) - Fetches all users (public).
getUser(req: Request) - Fetches a specific user by ID (public).
updateUser(req: Request) - Updates a specific user's details (public).
deleteUser(req: Request) - Deletes a specific user (public).
HTTP   - **Methods**:POST, GET, PUT, DELETE
**Description**: Manages user-related operations including authentication, registration, and CRUD operations.
PhotoController_Server.swift

Methods:
boot(routes: RoutesBuilder) - Registers routes for photo-related actions (public).
create(req: Request) - Creates a new photo (public).
getAll(req: Request) - Fetches all photos (public).
get(req: Request) - Fetches a specific photo by ID (public).
update(req: Request) - Updates a specific photo's details (public).
delete(req: Request) - Deletes a specific photo (public).
HTTP   - **Methods**:POST, GET, PUT, DELETE
**Description**: Manages photo-related operations including creation, retrieval, update, and deletion.
CommentController_Server.swift

Methods:
boot(routes: RoutesBuilder) - Registers routes for comment-related actions (public).
create(req: Request) - Creates a new comment (public).
getAll(req: Request) - Fetches all comments (public).
get(req: Request) - Fetches a specific comment by ID (public).
update(req: Request) - Updates a specific comment's details (public).
delete(req: Request) - Deletes a specific comment (public).
HTTP   - **Methods**:POST, GET, PUT, DELETE
**Description**: Manages comment-related operations including creation, retrieval, update, and deletion.
AlbumController_Server.swift

Methods:
boot(routes: RoutesBuilder) - Registers routes for album-related actions (public).
create(req: Request) - Creates a new album (public).
getAll(req: Request) - Fetches all albums (public).
get(req: Request) - Fetches a specific album by ID (public).
update(req: Request) - Updates a specific album's details (public).
delete(req: Request) - Deletes a specific album (public).
HTTP   - **Methods**:POST, GET, PUT, DELETE
**Description**: Manages album-related operations including creation, retrieval, update, and deletion.
Migrations (Server)
CreateUser.swift

Class: CreateUser
Methods:
prepare(on: Database) - Creates the users table.
revert(on: Database) - Deletes the users table.
**Description**: Manages the migration for creating and deleting the users table.
CreateAlbum.swift

Class: CreateAlbum
Methods:
prepare(on: Database) - Creates the albums table.
revert(on: Database) - Deletes the albums table.
**Description**: Manages the migration for creating and deleting the albums table.
CreateComment.swift

Class: CreateComment
Methods:
prepare(on: Database) - Creates the comments table.
revert(on: Database) - Deletes the comments table.
**Description**: Manages the migration for creating and deleting the comments table.
CreatePhoto.swift

Class: CreatePhoto
Methods:
prepare(on: Database) - Creates the photos table.
revert(on: Database) - Deletes the photos table.
**Description**: Manages the migration for creating and deleting the photos table.
Services (Server)
AuthService.swift

Methods:
register(req: Request) - Registers a new user (public).
login(req: Request) - Authenticates a user (public).
**Description**: Provides authentication services including user registration and login.
PhotoStorageService.swift

Methods:
storePhoto(req: Request, photo: ServerPhoto) - Stores a photo on the server (public).
fetchPhoto(req: Request, photoID: UUID) - Fetches a photo from the server (public).
**Description**: Provides photo storage services including storing and fetching photos from the server.
MainApp_Server.swift
MainApp_Server.swift
Methods:
main() - Entry point of the server application (private).
configure(_ app: Application) - Configures the database and performs migrations (private).
routes(_ app: Application) - Registers routes for the application (private).
Properties: None
**Description**: Main entry point of the server application, handling configuration, migrations, and routing.
Routes:
POST /register - Registers a new user.
POST /login - Authenticates a user.
POST /storePhoto - Stores a photo.
GET /fetchPhoto/:photoID - Fetches a photo by ID.
Testing
Client Tests
ClientTests.swift
Methods:
setUp() - Sets up the testing environment (override).
tearDown() - Tears down the testing environment (override).
testExample() - Example test method (public).
**Description**: Contains unit tests for the client module.
Server Tests
ServerTests.swift
Methods:
setUpWithError() - Sets up the testing environment (override).
tearDownWithError() - Tears down the testing environment (override).
configure(_ app: Application) - Configures the application for testing (private).
testUserCreation() - Tests user creation functionality (public).
testPhotoCreation() - Tests photo creation functionality (public).
**Description**: Contains unit tests for the server module.
Shared Tests
SharedTests.swift
Methods:
setUp() - Sets up the testing environment (override).
tearDown() - Tears down the testing environment (override).
testExample() - Example test method (public).
**Description**: Contains shared tests that apply to both client and server modules.