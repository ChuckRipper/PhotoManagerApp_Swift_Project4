(english version)

# PhotoManagerApp

PhotoManagerApp is a client-server application built with Swift and Vapor. The project is designed to manage photos, albums, users, and comments. It features a comprehensive structure that includes separate modules for client and server functionalities, ensuring a clear separation of concerns and modular development.

## Features

- User registration and authentication
- Photo storage and retrieval
- Album and photo management
- Commenting on photos
- Admin panel for managing users and content

## Technologies Used

- **Swift**: A powerful and intuitive programming language for macOS, iOS, watchOS, and tvOS.
- **SwiftUI**: A modern framework for building user interfaces across all Apple platforms.
- **Vapor**: A web framework for Swift that allows you to create server-side applications and APIs.
- **Fluent**: An ORM (Object-Relational Mapping) framework for Swift that works with Vapor.
- **SQLite**: A lightweight, disk-based database that doesn’t require a separate server process.
- **Combine**: A framework that provides a declarative Swift API for processing values over time.

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
2. Create a new branch:
    ```sh
    git checkout -b feature-branch
    ```
3. Commit your changes:
    ```sh
    git commit -am 'New feature'
    ```
4. Push to the branch:
    ```sh
    git push origin feature-branch
    ```
5. Create a new Pull Request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

(polish version)

# PhotoManagerApp

PhotoManagerApp to aplikacja klient-serwer zbudowana w językach Swift i Vapor. Projekt jest zaprojektowany do zarządzania zdjęciami, albumami, użytkownikami i komentarzami. Zawiera kompleksową strukturę, która obejmuje oddzielne moduły dla funkcjonalności klienta i serwera, zapewniając wyraźny podział obowiązków i modułowy rozwój.

## Funkcje

- Rejestracja i uwierzytelnianie użytkowników
- Przechowywanie i pobieranie zdjęć
- Zarządzanie albumami i zdjęciami
- Komentowanie zdjęć
- Panel administracyjny do zarządzania użytkownikami i treściami

## Użyte technologie

- **Swift**: Potężny i intuicyjny język programowania dla systemów macOS, iOS, watchOS i tvOS.
- **SwiftUI**: Nowoczesny framework do budowania interfejsów użytkownika na wszystkich platformach Apple.
- **Vapor**: Framework webowy dla Swift, który umożliwia tworzenie aplikacji po stronie serwera i interfejsów API.
- **Fluent**: Framework ORM (Object-Relational Mapping) dla Swift, współpracujący z Vapor.
- **SQLite**: Lekka, bazująca na plikach baza danych, która nie wymaga oddzielnego procesu serwera.
- **Combine**: Framework oferujący deklaratywne API Swift do przetwarzania wartości w czasie.

## Struktura projektu

- **Client**: Zawiera cały kod po stronie klienta, w tym modele, modele widoków i widoki.
- **Server**: Zawiera cały kod po stronie serwera, w tym modele, kontrolery, serwisy i migracje.
- **Tests**: Zawiera testy jednostkowe i UI dla modułów klienta i serwera.

## Konfiguracja

1. Sklonuj repozytorium:
   ```sh
   git clone https://github.com/ChuckRipper/PhotoManagerApp_Swift_Project4.git
   cd PhotoManagerApp_Swift_Project4
    ```
2. Zainstaluj zależności:
    ```sh
    cd Server
    swift package update
    ```
3. Uruchom serwer:
    ```sh
    vapor run
    ```
4. Otwórz projekt klienta w Xcode:
    ```sh
    open PhotoManagerApp_Swift_Project4.xcodeproj
    ```
5. Zbuduj i uruchom aplikację klienta w Xcode.

## Współpraca

1. Forknij repozytorium.
2. Utwórz nową gałąź:
    ```sh
    git checkout -b feature-branch
    ```
3. Zatwierdź swoje zmiany:
    ```sh
    git commit -am 'Nowa funkcja'
    ```
4. Wypchnij zmiany na gałąź:
    ```sh
    git push origin feature-branch
    ```
5. Utwórz nowy Pull Request.

## Licencja

Ten projekt jest licencjonowany na warunkach licencji MIT. Zobacz plik LICENSE, aby uzyskać szczegółowe informacje.
