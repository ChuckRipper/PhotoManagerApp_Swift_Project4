# PhotoManagerApp

PhotoManagerApp is a client-server application built with Swift and Vapor. The project is designed to manage photos, albums, users, and comments. It features a comprehensive structure that includes separate modules for client and server functionalities, ensuring a clear separation of concerns and modular development.

## Features

- User registration and authentication
- Photo storage and retrieval
- Album and photo management
- Commenting on photos
- Admin panel for managing users and content

## Technologies Used

- Swift
- SwiftUI
- Vapor
- Fluent
- SQLite

## Project Structure

- **Client**: Contains all the client-side code including models, view models, and views.
- **Server**: Contains all the server-side code including models, controllers, services, and migrations.
- **Tests**: Contains unit and UI tests for both client and server modules.

## Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/ChuckRipper/PhotoManagerApp_Swift_Project4.git
   cd PhotoManagerApp_Swift_Project4
    ```
2. Install dependencies:
    ```sh
    cd Server
    swift package update
    ```
3. Run the server:
    ```sh
    vapor run
    ```
4. Open the client project in Xcode:
    ```sh
    open PhotoManagerApp_Swift_Project4.xcodeproj
    ```
5. Build and run the client app in Xcode.

## Contributing

1. Fork the repository.
2. Create a new branch (git checkout -b feature-branch).
3. Commit your changes (git commit -am 'Add new feature').
4. Push to the branch (git push origin feature-branch).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
