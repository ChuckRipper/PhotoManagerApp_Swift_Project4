# PhotoManagerApp Documentation

## Authors
Cezary Kalinowski, 136168

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
      - Access: default (public)
      - Description: Fetches all albums from the server and updates the albums property. In case of failure, it sets the errorMessage property with the error description.
    - _fetchAlbum(id: UUID)_
      - Access: default (public)
      - Description: Fetches a single album by its ID from the server and updates the album property. In case of failure, it sets the errorMessage property with the error description.
    - _createAlbum(album: Album)_
      - Access: default (public)
      - Description: Sends a POST request to the server to create a new album. Updates the album property with the created album and refreshes the album list by calling fetchAlbums(). In case of failure, it sets the errorMessage property with the error description.
    - _updateAlbum(album: Album)_
      - Access: default (public)
      - Description: Sends a PUT request to the server to update an existing album. Updates the album property with the updated album and refreshes the album list by calling fetchAlbums(). In case of failure, it sets the errorMessage property with the error description.
    - _deleteAlbum(id: UUID)_
      - Access: default (public)
      - Description: Sends a DELETE request to the server to delete an album by its ID. Refreshes the album list by calling fetchAlbums(). In case of failure, it sets the errorMessage property with the error description.
  - **Properties**:
    - albums
      - Access: @Published
      - Description: Holds the list of albums fetched from the server.
    - album
      - Access: @Published
      - Description: Holds a single album fetched or created.
    - errorMessage
      - Access: @Published
      - Description: Holds the error message if any of the operations fail.
    - cancellables
      - Access: private
      - Description: Holds the cancellable tasks for Combine publishers.
  - **Description**: Manages the state and logic for album-related views.

- **UserViewModel.swift**
  - **Methods**:
    - _fetchUsers()_
      - Access: default (public)
      - Description: Fetches all users from the server and updates the users property. In case of failure, it sets the errorMessage property with the error description.
    - _fetchUser(id: UUID)_
      - Access: default (public)
      - Description: Fetches a single user by its ID from the server and updates the user property. In case of failure, it sets the errorMessage property with the error description.
    - _createUser(user: User)_
      - Access: default (public)
      - Description: Sends a POST request to the server to create a new user. Updates the user property with the created user and refreshes the user list by calling fetchUsers(). In case of failure, it sets the errorMessage property with the error description.
    - _updateUser(user: User)_
      - Access: default (public)
      - Description: Sends a PUT request to the server to update an existing user. Updates the user property with the updated user and refreshes the user list by calling fetchUsers(). In case of failure, it sets the errorMessage property with the error description.
    - _deleteUser(id: UUID)_
      - Access: default (public)
      - Description: Sends a DELETE request to the server to delete a user by its ID. Refreshes the user list by calling fetchUsers(). In case of failure, it sets the errorMessage property with the error description.
  - **Properties**:
    - users
      - Access: @Published
      - Description: Holds the list of users fetched from the server.
    - user
      - Access: @Published
      - Description: Holds a single user fetched or created.
    - errorMessage
      - Access: @Published
      - Description: Holds the error message if any of the operations fail.
    - cancellables
      - Access: private
      - Description: Holds the cancellable tasks for Combine publishers.
  - **Description**: Manages the state and logic for user-related views.

- **CommentViewModel.swift**
  - **Methods**:
    - _fetchComments()_
      - Access: default (public)
      - Description: Fetches all comments from the server and updates the comments property. In case of failure, it sets the errorMessage property with the error description.
    - _fetchComment(id: UUID)_
      - Access: default (public)
      - Description: Fetches a single comment by its ID from the server and updates the comment property. In case of failure, it sets the errorMessage property with the error description.
    - _createComment(comment: Comment)_
      - Access: default (public)
      - Description: Sends a POST request to the server to create a new comment. Updates the comment property with the created comment and refreshes the comment list by calling fetchComments(). In case of failure, it sets the errorMessage property with the error description.
    - _updateComment(comment: Comment)_
      - Access: default (public)
      - Description: Sends a PUT request to the server to update an existing comment. Updates the comment property with the updated comment and refreshes the comment list by calling fetchComments(). In case of failure, it sets the errorMessage property with the error description.
    - _deleteComment(id: UUID)_
      - Access: default (public)
      - Description: Sends a DELETE request to the server to delete a comment by its ID. Refreshes the comment list by calling fetchComments(). In case of failure, it sets the errorMessage property with the error description.
  - **Properties**:
    - comments
      - Access: @Published
      - Description: Holds the list of comments fetched from the server.
    - comment
      - Access: @Published
      - Description: Holds a single comment fetched or created.
    - errorMessage
      - Access: @Published
      - Description: Holds the error message if any of the operations fail.
    - cancellables
      - Access: private
      - Description: Holds the cancellable tasks for Combine publishers.
  - **Description**: Manages the state and logic for comment-related views.

- **PhotoViewModel.swift**
  - **Methods**:
    - _fetchPhotos()_
      - Access: default (public)
      - Description: Fetches all photos from the server and updates the photos property. In case of failure, it sets the errorMessage property with the error description.
    - _fetchPhoto(id: UUID)_
      - Access: default (public)
      - Description: Fetches a single photo by its ID from the server and updates the photo property. In case of failure, it sets the errorMessage property with the error description.
    - _createPhoto(photo: Photo)_
      - Access: default (public)
      - Description: Sends a POST request to the server to create a new photo. Updates the photo property with the created photo and refreshes the photo list by calling fetchPhotos(). In case of failure, it sets the errorMessage property with the error description.
    - _updatePhoto(photo: Photo)_
      - Access: default (public)
      - Description: Sends a PUT request to the server to update an existing photo. Updates the photo property with the updated photo and refreshes the photo list by calling fetchPhotos(). In case of failure, it sets the errorMessage property with the error description.
    - _deletePhoto(id: UUID)_
      - Access: default (public)
      - Description: Sends a DELETE request to the server to delete a photo by its ID. Refreshes the photo list by calling fetchPhotos(). In case of failure, it sets the errorMessage property with the error description.

  - **Properties**:
    - photos
      - Access: @Published
      - Description: Holds the list of photos fetched from the server.
    - photo
      - Access: @Published
      - Description: Holds a single photo fetched or created.
    - errorMessage
      - Access: @Published
      - Description: Holds the error message if any of the operations fail.
    - cancellables
      - Access: private
      - Description: Holds the cancellable tasks for Combine publishers.
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
    - **Access**: default (public)
    - **Description**: Sets up the routes for user-related operations. It groups the routes under the /users path and assigns appropriate HTTP methods and endpoints to the controller methods.

  - _login(req: Request)_
    - **HTTP method**: POST
    - **Access**: default (public)
    - **Description**: Authenticates the user by checking the provided credentials against the stored user data. Returns the authenticated user if successful.

  - _register(req: Request)_
    - **HTTP method**: POST
    - **Access**: default (public)
    - **Description**: Registers a new user by hashing the password and saving the user data to the database. Returns the created user.

  - _getAllUsers(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**: Fetches all users from the database and returns them.

  - _getUser(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**: Fetches a single user by its ID from the database and returns it. If the user is not found, it returns a notFound error.

  - _updateUser(req: Request)_
    - **HTTP method**: PUT
    - **Access**: default (public)
    - **Description**: Updates an existing user with the provided data. It fetches the user by ID, updates the relevant fields, and saves the changes. Returns the updated user.

  - _deleteUser(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: default (public)
    - **Description**: Deletes a user by its ID from the database. If the user is found and successfully deleted, it returns an ok status.

- **Fields and Properties**: None

- **Description**: Manages user-related operations including authentication, registration, and CRUD operations.

**PhotoController_Server.swift**

- **Methods**:
  - _boot(routes: RoutesBuilder)_
    - **HTTP method**: None
    - **Access**: default (public)
    - **Description**: Sets up the routes for photo-related operations. It groups the routes under the /photos path and assigns appropriate HTTP methods and endpoints to the controller methods.

  - _getAllHandler(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**: Fetches all photos from the database and returns them.

  - _createHandler(req: Request)_
    - **HTTP method**: POST
    - **Access**: default (public)
    - **Description**: Creates a new photo with the provided data and saves it to the database. Returns the created photo.

  - _getHandler(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**:  Fetches a single photo by its ID from the database and returns it. If the photo is not found, it returns a notFound error.

  - _updateHandler(req: Request)_
    - **HTTP method**: PUT
    - **Access**: default (public)
    - **Description**: Updates an existing photo with the provided data. It fetches the photo by ID, updates the relevant fields, and saves the changes. Returns the updated photo.

  - _deleteHandler(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: default (public)
    - **Description**: Deletes a photo by its ID from the database. If the photo is found and successfully deleted, it returns an ok status.

- **Fields and Properties**: None

- **Description**: Manages photo-related operations including creation, retrieval, update, and deletion.

**CommentController_Server.swift**

- **Methods**:
  - _boot(routes: RoutesBuilder)_ - Registers routes for comment-related actions (public).
    - **HTTP method**: None
    - **Access**: default (public)
    - **Description**: Sets up the routes for comment-related operations. It groups the routes under the /comments path and assigns appropriate HTTP methods and endpoints to the controller methods.

  - _getAllHandler(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**: Fetches all comments from the database and returns them.

  - _createHandler(req: Request)_
    - **HTTP method**: POST
    - **Access**: default (public)
    - **Description**: Creates a new comment with the provided data and saves it to the database. Returns the created comment.

  - _getHandler(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**: Fetches a single comment by its ID from the database and returns it. If the comment is not found, it returns a notFound error.

  - _updateHandler(req: Request)_
    - **HTTP method**: PUT
    - **Access**: default (public)
    - **Description**: Updates an existing comment with the provided data. It fetches the comment by ID, updates the relevant fields, and saves the changes. Returns the updated comment.

  - _deleteHandler(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: default (public)
    - **Description**: Deletes a comment by its ID from the database. If the comment is found and successfully deleted, it returns an ok status.

- **Fields and Properties**: None

- **Description**: Manages comment-related operations including creation, retrieval, update, and deletion.

**AlbumController_Server.swift**

- **Methods**:
  - _boot(routes: RoutesBuilder)_ - Registers routes for comment-related actions (public).
    - **HTTP method**: None
    - **Access**: default (public)
    - **Description**: Sets up the routes for album-related operations. It groups the routes under the /albums path and assigns appropriate HTTP methods and endpoints to the controller methods.

  - _getAllHandler(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**: Fetches all albums from the database and returns them.

  - _createHandler(req: Request)_
    - **HTTP method**: POST
    - **Access**: default (public)
    - **Description**: Creates a new album with the provided data and saves it to the database. Returns the created album.

  - _getHandler(req: Request)_
    - **HTTP method**: GET
    - **Access**: default (public)
    - **Description**: Fetches a single album by its ID from the database and returns it. If the album is not found, it returns a notFound error.

  - _updateHandler(req: Request)_
    - **HTTP method**: PUT
    - **Access**: default (public)
    - **Description**: Updates an existing album with the provided data. It fetches the album by ID, updates the relevant fields, and saves the changes. Returns the updated album.

  - _deleteHandler(req: Request)_
    - **HTTP method**: DELETE
    - **Access**: default (public)
    - **Description**: Deletes an album by its ID from the database. If the album is found and successfully deleted, it returns an ok status.

- **Fields and Properties**: None

- **Description**: Manages album-related operations including creation, retrieval, update, and deletion.

### Migrations (Server)

**CreateUser.swift**

**Class**: _CreateUser_

- **Methods**:
  - _prepare(on: Database)_
    - Access: default (public)
    - Columns:
      - id: A unique identifier for each user.
      - username: A string representing the username of the user. This field is required.
      - email: A string representing the email of the user. This field is required.
      - password: A string representing the hashed password of the user. This field is required.
    - Description: This method sets up the schema for the users table. It defines the columns and their types, including an ID, username, email, and password.

  - _revert(on: Database)_ - deletes the users table.
    - Access: default (public)
    - Description: This method deletes the users table schema from the database. It is used to rollback the changes made by the prepare method.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the users table.

**CreateAlbum.swift**

**Class**: _CreateAlbum_

- **Methods**:
  - _prepare(on: Database)_
    - Access: default (public)
    - Columns:
      - id: A unique identifier for each album.
      - title: A string representing the title of the album. This field is required.
      - user_id: A UUID that references the id column in the users table. This field is required and establishes a foreign key relationship.
    - Description: This method sets up the schema for the albums table. It defines the columns and their types, including an ID, title, and a foreign key to the users table.

  - _revert(on: Database)_ - deletes the users table.
    - Access: default (public)
    - Description: This method deletes the albums table schema from the database. It is used to rollback the changes made by the prepare method.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the albums table.

**CreateComment.swift**

**Class**: _CreateComment_

- **Methods**:
  - _prepare(on: Database)_
    - Access: default (public)
    - Columns:
      - id: A unique identifier for each comment.
      - text: A string representing the text of the comment. This field is required.
      - photo_id: A UUID that references the id column in the photos table. This field is required and establishes a foreign key relationship.
      - user_id: A UUID that references the id column in the users table. This field is required and establishes a foreign key relationship.
    - Description: This method sets up the schema for the comments table. It defines the columns and their types, including an ID, text, and foreign keys to the photos and users tables.

  - _revert(on: Database)_ - deletes the users table.
    - Access: default (public)
    - Description: This method deletes the comments table schema from the database. It is used to rollback the changes made by the prepare method.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the comments table.

**CreatePhoto.swift**

**Class**: _CreatePhoto_

- **Methods**:
  - _prepare(on: Database)_
    - Access: default (public)
    - Columns:
      - id: A unique identifier for each photo.
      - title: A string representing the title of the photo. This field is required.
      - url: A string representing the URL of the photo. This field is required.
      - album_id: A UUID that references the id column in the albums table. This field is required and establishes a foreign key relationship.
    - Description: This method sets up the schema for the photos table. It defines the columns and their types, including an ID, title, URL, and a foreign key to the albums table.

  - _revert(on: Database)_ - deletes the users table.
    - Access: default (public)
    - Description: This method deletes the photos table schema from the database. It is used to rollback the changes made by the prepare method.

- **Fields and Properties**: None

- **Description**: Manages the migration for creating and deleting the photos table.

### Services (Server)

**AuthService.swift**

**Class**: _AuthService_

- **Methods**:
  - _register(req: Request)_
    - Access: default (public)
    - Description: This method registers a new user. It hashes the user's password using Bcrypt and saves the user in the database.

  - _login(req: Request)_
    - Access: default (public)
    - Description: Fetches a single photo by its ID from the server and updates the photo property. In case of failure, it sets the errorMessage property with the error description.

- **Fields and Properties**: None

- **Description**: Provides authentication services for user registration and login. It handles the creation of new users with hashed passwords and authenticates existing users by verifying their credentials.

**PhotoStorageService.swift**

- **Methods**:
  - _storePhoto(req: Request, photo: ServerPhoto)_
    - Access: default (public)
    - Description: This method stores a photo on the server. It writes the photo data to the server's disk and saves the photo information in the database.

  - _fetchPhoto(req: Request, photoID: UUID)_
    - Access: default (public)
    - Description: This method retrieves a photo from the server. It reads the photo data from the server's disk and returns it in the response.

- **Fields and Properties**: None

- **Description**: Provides services for storing and retrieving photos on the server. It handles the logic for saving photo files to the server's disk and retrieving them for client requests.

### MainApp_Server.swift

**MainApp_Server.swift**

- **Methods**:
  - _main()_
    - Access: private static
    - Description: Main entry point of the server application. It detects the environment, sets up logging, initializes the application, configures the database, registers routes, and runs the application.

  - _configure(app: Application)_
    - Access: private static
    - Description: Configures the database connection and migrations for the application.

  - _routes(app: Application)_
    - Access: private static
    - Description: Registers the routes and services for the application.
    - **Routes**:
      - POST _/register_ - Registers a new user.
      - POST _/login_ - Authenticates a user.
      - POST _/storePhoto_ - Stores a photo on the server.
      - GET _/fetchPhoto/:photoID_ - Retrieves a photo from the server.

- **Properties**: None

- **Description**: Main entry point of the server-side part of the PhotoManagerApp_Swift_Project4 application. It sets up the application environment, configures the database, registers routes, and runs the application.

## Testing

### Client Tests

**ClientTests.swift**

- **Methods**:
  - _setUpWithError()_
    - Access: public (override)
    - Description: Sets up the test environment before each test method in the class is called. Initializes userViewModel and photoViewModel.

  - _tearDownWithError()_
    - Access: public (override)
    - Description: Cleans up the test environment after each test method in the class is called. Deinitializes userViewModel and photoViewModel.

  - _setUp()_
    - Access: public (override)
    - Description: Additional setup before each test method in the class is called.

  - _tearDown()_
    - Access: public (override)
    - Description: Additional cleanup after each test method in the class is called.

  - _testFetchUsers()_
    - Access: default (public)
    - Description: Tests the fetchUsers method of UserViewModel. Asserts that the users array is not empty after fetching users.

  - _testFetchPhotos()_
    - Access: default (public)
    - Description: Tests the fetchPhotos method of PhotoViewModel. Asserts that the photos array is not empty after fetching photos.

  - _testUserViewModelInitialization()_
    - Access: default (public)
    - Description: Tests the initialization of UserViewModel. Asserts that userViewModel is not nil.

  - _testPhotoViewModelInitialization()_
    - Access: default (public)
    - Description: Tests the initialization of PhotoViewModel. Asserts that photoViewModel is not nil.

- **Properties**:
  - _userViewModel_:
    - Access: default (public)
    - Description: Instance of UserViewModel used for testing.

  - _photoViewModel_:
    - Access: default (public)
    - Description: Instance of PhotoViewModel used for testing.

- **Description**: Contains unit tests for the client-side view models of the PhotoManagerApp_Swift_Project4 application. It tests the functionality of UserViewModel and PhotoViewModel classes.

### Server Tests

**ServerTests.swift**

- **Methods**:
  - _setUpWithError()_
    - Access: public (override)
    - Description: Sets up the test environment before each test method in the class is called. Initializes the Application instance and configures it.

  - _tearDownWithError()_
    - Access: public (override)
    - Description: Cleans up the test environment after each test method in the class is called. Shuts down the Application instance.

  - _setUp()_
    - Access: public (override)
    - Description: Additional setup before each test method in the class is called.

  - _tearDown()_
    - Access: public (override)
    - Description: Additional cleanup after each test method in the class is called.

  - _configure(app: Application)_
    - Access: default (internal)
    - Description: Configures the Application instance with an in-memory SQLite database and runs migrations.

  - _testUserCreation()_
    - Access: default (public)
    - Description: Tests the user creation endpoint. Asserts that a user can be created successfully and the returned user data is correct.

  - _testPhotoCreation()_
    - Access: default (public)
    - Description: Tests the photo creation endpoint. Asserts that a photo can be created successfully and the returned photo data is correct.

  - _testHealthCheck()_
    - Access: default (public)
    - Description: Tests the health check endpoint. Asserts that the health check returns an OK status.

- **Properties**:
  - _app_:
    - Access: default (public)
    - Description: The Application instance used for testing.

- **Description**: Contains unit tests for the server-side components of the PhotoManagerApp_Swift_Project4 application. It tests the functionality of various server-side operations such as user creation, photo creation, and health checks.

### Shared Tests

**SharedTests.swift**

- **Methods**:
  - _setUpWithError()_
    - Access: public (override)
    - Description: Sets up the test environment before each test method in the class is called. Initializes the Application instance and configures it.

  - _tearDownWithError()_
    - Access: public (override)
    - Description: Cleans up the test environment after each test method in the class is called. Shuts down the Application instance.

  - _setUp()_
    - Access: public (override)
    - Description: Additional setup before each test method in the class is called.

  - _tearDown()_
    - Access: public (override)
    - Description: Additional cleanup after each test method in the class is called.

  - _testUserFlow()_
    - Access: default (public)
    - Description: Tests the user registration and login flow. Ensures that a user can register, login, and be successfully authenticated.

  - _testExample()_
    - Access: default (public)
    - Description: An example test method that verifies a simple true condition.

- **Properties**:
  - _app_:
    - Access: default (public)
    - Description: The Application instance used for testing.

- **Description**: Contains unit tests for testing the overall functionality and flow of the PhotoManagerApp_Swift_Project4 application. This includes testing the user registration and login process.

### Client UI Tests

**ClientUITests.swift**

- **Methods**:
  - _setUpWithError()_
    - Access: public (override)
    - Description: Sets up the test environment before each test method in the class is called. It launches the XCUIApplication

  - _tearDownWithError()_
    - Access: public (override)
    - Description: Cleans up the test environment after each test method in the class is called.

  - _setUp()_
    - Access: public (override)
    - Description: Additional setup before each test method in the class is called.

  - _tearDown()_
    - Access: public (override)
    - Description: Additional cleanup after each test method in the class is called.

  - _testExample()_
    - Access: default (public)
    - Description: Tests the functionality of the "Login" and "Register" buttons. It verifies that the corresponding screens are displayed when the buttons are tapped.

  - _testLaunchPerformance()_
    - Access: default (public)
    - Description: Measures the application launch performance.

- **Properties**:
  - _app_:
    - Access: default (public)
    - Description: The XCUIApplication instance used for UI testing.

- **Description**: Contains UI tests for the PhotoManagerApp_Swift_Project4 application. These tests verify the functionality of the user interface components, such as buttons and navigation.

**ClientUITestsLaunchTests.swift**

- **Methods**:
  - _runsForEachTargetApplicationUIConfiguration()_ (class var)
    - Access: public (override)
    - Description: Indicates that the test suite runs for each target application UI configuration.

  - _setUpWithError()_
    - Access: public (override)
    - Description: Sets up the test environment before each test method in the class is called. It continues the test execution even if a failure occurs.

  - _setUp()_
    - Access: public (override)
    - Description: Additional setup before each test method in the class is called.

  - _tearDown()_
    - Access: public (override)
    - Description: Additional cleanup after each test method in the class is called.

  - _testLaunch()_
    - Access: default (public)
    - Description: Tests the application launch and captures a screenshot of the initial state. The screenshot is then attached to the test results with a specified name and lifetime.

  - _testExample()_
    - Access: default (public)
    - Description: An example test method that verifies a simple true condition.

- **Properties**: None

- **Description**: Contains tests that verify the launch performance and initial screen of the PhotoManagerApp_Swift_Project4 application. These tests ensure that the application launches correctly and captures the initial state of the UI.