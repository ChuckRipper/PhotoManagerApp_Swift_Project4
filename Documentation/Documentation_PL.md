# PhotoManagerApp Dokumentacja

## Autorzy
Cezary Kalinowski, 136168

Grupa projektowa nr 14

## Spis treści

1. [Przegląd projektu](#przegląd-projektu)
2. [Specyfikacja](#specyfikacja)
3. [Struktura projektu](#struktura-projektu)
4. [Moduł Klienta](#moduł-klienta)
    - [Modele](#modele-klient)
    - [ViewModele](#viewmodele-klient)
    - [Widoki](#widoki-klient)
    - [MainApp_Client](#mainapp_client)
5. [Moduł Serwera](#moduł-serwera)
    - [Modele](#modele-serwer)
    - [Kontrolery](#kontrolery-serwer)
    - [Migracje](#migracje-serwer)
    - [Serwisy](#usługi-serwer)
    - [MainApp_Server](#mainapp_server)
6. [Testowanie](#testowanie)
    - [Testy Klienta](#testy-aplikacji-klienckiej)
    - [Testy Serwera](#testy-serwera)
    - [Testy Wspólne](#testy-wspólne)
    - [Testy UI Klienta](#testy-ui-aplikacji-klienckiej)

## Przegląd projektu

PhotoManagerApp to aplikacja klient-serwer zbudowana w Swift i Vapor, zaprojektowana do zarządzania zdjęciami, albumami, użytkownikami i komentarzami. Aplikacja zawiera moduł klienta napisany w SwiftUI oraz moduł serwera wykorzystujący Vapor i Fluent.

## Specyfikacja

### Wymagania funkcjonalne
1. Funkcjonalność rejestracji i logowania użytkowników.
2. Przesyłanie i przechowywanie zdjęć.
3. Tworzenie i zarządzanie albumami.
4. System komentowania zdjęć.
5. Panel administracyjny do zarządzania użytkownikami i treściami.

### Wymagania niefunkcjonalne
1. Aplikacja powinna zapewniać integralność i bezpieczeństwo danych.
2. System powinien być skalowalny, aby obsługiwać wielu użytkowników i dużą liczbę zdjęć.

### Opis projektu
PhotoManagerApp został zaprojektowany, aby zapewnić płynne zarządzanie albumami fotograficznymi i interakcjami użytkowników. Aplikacja pozwala użytkownikom rejestrować się, przesyłać zdjęcia, tworzyć albumy i komentować zdjęcia. Użytkownicy administracyjni mają dodatkowe możliwości zarządzania treściami i użytkownikami.

### Potencjalni użytkownicy
1. Fotografowie
2. Entuzjaści mediów społecznościowych
3. Użytkownicy ogólni, którzy chcą zarządzać swoimi kolekcjami zdjęć.

### Korzyści
1. Łatwy i zorganizowany sposób zarządzania zdjęciami i albumami.
2. Przyjazny dla użytkownika interfejs do przesyłania i przeglądania zdjęć.
3. Interaktywne funkcje, takie jak komentowanie, zwiększają zaangażowanie użytkowników.

## Struktura projektu

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
├── Documentation
│   ├── Documentation_EN.md
│   ├── Documentation_PL.md
├── .gitignore
├── .gitattributes
├── LICENSE
└── README.md
```

## Moduł klienta

### Modele (Klient)

#### CommentModel_Client.swift

**Właściwości**:
- id (UUID),
- text (String),
- photoID (UUID),
- userID (UUID)

**Klucz główny**: id

**Klucze obce**:
- photoID,
- userID

**Relacje**: Należy do użytkownika i zdjęcia
- photoID <=> PhotoModel_Client.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- userID <=> UserModel_Client.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

#### UserModel_Client.swift

**Właściwości**:
- id (UUID),
- username (String),
- email (String),
- password (String)

**Klucz główny**: id

**Brak kluczy obcych**

**Relacje**: Ma wiele komentarzy, ma wiele albumów
- id <=> CommentModel_Client.userID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- id <=> AlbumModel_Client.userID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

#### PhotoModel_Client.swift

**Właściwości**:
- id (UUID),
- title (String),
- url (String),
- albumID (UUID)

**Klucz główny**: id

**Klucz obcy**: albumID

**Relacje**: Należy do albumu, ma wiele komentarzy
- albumID <=> AlbumModel_Client.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- id <=> CommentModel_Client.photoID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

#### AlbumModel_Client.swift

**Właściwości**:
- id (UUID),
- title (String),
- userID (UUID)

**Klucz główny**: id

**Klucz obcy**: userID

**Relacje**: Należy do użytkownika, ma wiele zdjęć
- userID <=> UserModel_Client.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- id <=> PhotoModel_Client.albumID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

### ViewModele (Klient)

#### AlbumViewModel.swift

**Metody**:
- _fetchAlbums()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkie albumy z serwera i aktualizuje właściwość albums. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _fetchAlbum(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedynczy album według jego ID z serwera i aktualizuje właściwość albumu. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _createAlbum(album: Album)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie POST do serwera w celu utworzenia nowego albumu. Aktualizuje właściwość albumu o utworzony album i odświeża listę albumów, wywołując fetchAlbums(). W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _updateAlbum(album: Album)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie PUT do serwera w celu zaktualizowania istniejącego albumu. Aktualizuje właściwość albumu zaktualizowanym albumem i odświeża listę albumów, wywołując fetchAlbums(). W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _deleteAlbum(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie DELETE do serwera w celu usunięcia albumu według jego ID. Odświeża listę albumów, wywołując fetchAlbums(). W przypadku niepowodzenia ustawia właściwość errorMessage z opisem błędu.

**Właściwości**:
- albums
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Zawiera listę albumów pobranych z serwera.

- album
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje pojedynczy pobrany lub utworzony album.

- errorMessage
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje komunikat o błędzie w przypadku niepowodzenia dowolnej operacji.

- cancellables
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje zadania, które można anulować dla wydawców Combine.

**Opis**: Zarządza stanem i logiką widoków związanych z albumem.

#### UserViewModel.swift

**Metody**:
- _fetchUsers()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkich użytkowników z serwera i aktualizuje właściwość użytkowników. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _fetchUser(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedynczego użytkownika według jego ID z serwera i aktualizuje właściwość użytkownika. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _createUser(user: User)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie POST do serwera w celu utworzenia nowego użytkownika. Aktualizuje właściwość użytkownika o utworzonego użytkownika i odświeża listę użytkowników, wywołując fetchUsers(). W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _updateUser(user: User)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie PUT do serwera w celu zaktualizowania istniejącego użytkownika. Aktualizuje właściwość użytkownika zaktualizowanym użytkownikiem i odświeża listę użytkowników, wywołując fetchUsers(). W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _deleteUser(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie DELETE do serwera w celu usunięcia użytkownika według jego ID. Odświeża listę użytkowników, wywołując fetchUsers(). W przypadku niepowodzenia ustawia właściwość errorMessage z opisem błędu.

**Właściwości**:
- users
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje listę użytkowników pobraną z serwera.

- user
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje pojedynczego pobranego lub utworzonego użytkownika.

- errorMessage
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje komunikat o błędzie w przypadku niepowodzenia dowolnej operacji.

- cancellables
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje zadania, które można anulować dla wydawców Combine.

**Opis**: Zarządza stanem i logiką widoków związanych z użytkownikiem.

#### CommentViewModel.swift

**Metody**:
- _fetchComments()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkie komentarze z serwera i aktualizuje właściwość comments. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _fetchComment(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedynczy komentarz według jego ID z serwera i aktualizuje właściwość komentarza. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _createComment(comment: Comment)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie POST do serwera w celu utworzenia nowego komentarza. Aktualizuje właściwość komentarza utworzonym komentarzem i odświeża listę komentarzy, wywołując fetchComments(). W przypadku niepowodzenia ustawia właściwość errorMessage z opisem błędu.

- _updateComment(comment: Comment)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie PUT do serwera w celu zaktualizowania istniejącego komentarza. Aktualizuje właściwość komentarza zaktualizowanym komentarzem i odświeża listę komentarzy, wywołując fetchComments(). W przypadku niepowodzenia ustawia właściwość errorMessage z opisem błędu.

- _deleteComment(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie DELETE do serwera w celu usunięcia komentarza według jego ID. Odświeża listę komentarzy, wywołując fetchComments(). W przypadku niepowodzenia ustawia właściwość errorMessage z opisem błędu.

**Właściwości**:
- comments
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje listę komentarzy pobranych z serwera.

- comment
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje pojedynczy pobrany lub utworzony komentarz.

- errorMessage
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje komunikat o błędzie w przypadku niepowodzenia dowolnej operacji.

- cancellables
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje zadania, które można anulować dla wydawców Combine.

**Opis**: Zarządza stanem i logiką widoków związanych z komentarzami.

#### PhotoViewModel.swift

**Metody**:
- _fetchPhotos()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkie zdjęcia z serwera i aktualizuje właściwość photos. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _fetchPhoto(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedyncze zdjęcie według jego ID z serwera i aktualizuje właściwość zdjęcia. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _createPhoto(photo: Photo)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie POST do serwera w celu utworzenia nowego zdjęcia. Aktualizuje właściwość zdjęcia o utworzone zdjęcie i odświeża listę zdjęć, wywołując fetchPhotos(). W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

- _updatePhoto(photo: Photo)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie PUT do serwera w celu zaktualizowania istniejącego zdjęcia. Aktualizuje właściwość zdjęcia zaktualizowanym zdjęciem i odświeża listę zdjęć, wywołując fetchPhotos(). W przypadku niepowodzenia ustawia właściwość errorMessage z opisem błędu.

- _deletePhoto(id: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Wysyła żądanie DELETE do serwera w celu usunięcia zdjęcia według jego ID. Odświeża listę zdjęć, wywołując fetchPhotos(). W przypadku niepowodzenia ustawia właściwość errorMessage z opisem błędu.

**Właściwości**:
- photos
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Zawiera listę zdjęć pobranych z serwera.

- photo
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje pojedyncze pobrane lub utworzone zdjęcie.

- errorMessage
  - **Dostęp (modyfikator dostępu)**: @Published
  - **Opis**: Przechowuje komunikat o błędzie w przypadku niepowodzenia dowolnej operacji.

- cancellables
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje zadania, które można anulować dla wydawców Combine.

**Opis**: Zarządza stanem i logiką widoków związanych ze zdjęciami.

### Widoki (Klient)

#### AlbumDetailView.swift

**Struct (Struktura)**: _AlbumDetailView_

**Metody**: Brak

**Pola i właściwości**:
- _albumViewModel_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Obserwowany obiekt, który zarządza stanem i logiką widoków związanych z albumem. Służy do pobierania i aktualizowania szczegółów albumu.

- _album_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość reprezentująca album, który ma być wyświetlany i edytowany w widoku.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: The body property returns a view that displays the details of the album. It includes a text field for editing the album's title and a button to update the album. When the view appears, it fetches the album details.

**Opis**: Właściwość body zwraca widok, który wyświetla szczegóły albumu. Zawiera pole tekstowe do edycji tytułu albumu i przycisk do aktualizacji albumu. Gdy widok się pojawi, pobiera szczegóły albumu.

#### AdminPanelView.swift

**Struct (Struktura)**: _AdminPanelView_

**Metody**: Brak

**Pola i właściwości**:
- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok, który wyświetla tekst „Panel administracyjny” i ustawia tytuł paska nawigacyjnego na „Panel administracyjny”.

**Opis**: Ten widok przedstawia panel administracyjny w PhotoManagerApp. Zapewnia tekst zastępczy dla interfejsu panelu administracyjnego.

**Struct (Struktura)**: _AdminPanelView\_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość previews zwraca podgląd AdminPanelView dla obszaru roboczego podglądu SwiftUI.

**Opis**: Ta struktura udostępnia podgląd AdminPanelView w podglądzie SwiftUI w środowisku Xcode.

#### LoginView.swift

**Struct (Struktura)**: _LoginView_

**Metody**: Brak

**Pola i właściwości**:
- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok wyświetlający formularz logowania z polami nazwy użytkownika i hasła oraz przyciskiem logowania.

- _username_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje nazwę użytkownika wprowadzoną przez użytkownika.

- _password_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje hasło wprowadzone przez użytkownika.

**Opis**: Ten widok przedstawia interfejs logowania w PhotoManagerApp. Zawiera pola nazwy użytkownika i hasła oraz przycisk logowania.

**Struct (Struktura)**: _LoginView\_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Struktura udostępnia podgląd LoginView w podglądzie SwiftUI w Xcode.

**Opis**: Ta struktura udostępnia podgląd LoginView w podglądzie SwiftUI w Xcode.

#### AlbumListView.swift

**Struct (Struktura)**: _AlbumListView_

**Metody**:
- _deleteAlbum(at offsets: IndexSet)_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Usuwa album o określonym indeksie na liście albumów. Wysyła żądanie DELETE do serwera, aby usunąć album według jego ID.

**Pola i właściwości**:
- _albumViewModel_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Zarządza stanem i logiką widoków związanych z albumem. Służy do pobierania i aktualizowania szczegółów albumu.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok wyświetlający listę albumów pobranych z serwera.

**Opis**: Ten widok wyświetla listę albumów zarządzanych przez AlbumViewModel. Pobiera dane albumu, gdy widok się pojawi.

**Struct (Struktura)**: _AlbumListView\_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość previews zwraca podgląd AlbumListView dla obszaru roboczego podglądu SwiftUI.

**Opis**: Ta struktura udostępnia podgląd AlbumListView w podglądzie SwiftUI w Xcode.

#### UserDetailView.swift

**Struct (Struktura)**: _UserDetailView_

**Metody**: Brak

**Pola i właściwości**:
- _userViewModel_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Obserwowany obiekt, który zarządza stanem i logiką widoków związanych z użytkownikiem. Służy do pobierania i aktualizowania szczegółów użytkownika.

- _user_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość reprezentująca użytkownika, która ma być wyświetlana i edytowana w widoku.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok, który wyświetla szczegóły użytkownika. Zawiera pola tekstowe do edycji nazwy użytkownika i adresu e-mail oraz przycisk do aktualizacji użytkownika.

**Opis**: W tym widoku wyświetlane są szczegóły konkretnego użytkownika, w tym pola tekstowe umożliwiające edycję nazwy użytkownika i adresu e-mail, a także przycisk umożliwiający aktualizację danych użytkownika.

#### RegisterView.swift

**Struct (Struktura)**: _RegisterView_

**Metody**: Brak

**Pola i właściwości**:
- _username_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje nazwę użytkownika wprowadzoną przez użytkownika.

- _email_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje adres e-mail wprowadzony przez użytkownika.

- _password_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Przechowuje hasło wprowadzone przez użytkownika.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok wyświetlający formularz rejestracyjny z polami dla nazwy użytkownika, adresu e-mail i hasła, a także przycisk rejestracji.

**Opis**: Ten widok przedstawia interfejs rejestracji w PhotoManagerApp. Zawiera pola dla nazwy użytkownika, adresu e-mail i hasła oraz przycisk rejestracji.

**Struct (Struktura)**: _RegisterView\_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Struktura udostępnia podgląd RegisterView w podglądzie SwiftUI w Xcode.

**Opis**: Ta struktura udostępnia podgląd RegisterView w podglądzie SwiftUI w Xcode.

#### PhotoListView.swift

**Struct (Struktura)**: _PhotoListView_

**Metody**:
- _deletePhoto(at offsets: IndexSet)_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Usuwa zdjęcie o określonym indeksie na liście zdjęć. Wysyła żądanie DELETE do serwera, aby usunąć zdjęcie według jego ID.

**Pola i właściwości**:
- _photoViewModel_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Zarządza stanem i logiką widoków związanych ze zdjęciami. Służy do pobierania i aktualizowania szczegółów zdjęć.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: The body property returns a view that displays a list of photos fetched from the server.

**Opis**: Ten widok wyświetla listę zdjęć zarządzanych przez PhotoViewModel. Pobiera dane zdjęcia, gdy widok się pojawi.

**Struct (Struktura)**: _PhotoListView_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość previews zwraca podgląd PhotoListView dla obszaru roboczego podglądu SwiftUI.

**Opis**: Ta struktura udostępnia podgląd PhotoListView w podglądzie SwiftUI w Xcode.

#### CommentDetailView.swift

**Struct (Struktura)**: _CommentDetailView_

**Metody**: Brak

**Pola i właściwości**:
- _commentViewModel_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Obserwowany obiekt, który zarządza stanem i logiką dla widoków związanych z komentarzami. Służy do pobierania i aktualizowania szczegółów komentarzy.

- _comment_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość reprezentująca komentarz, który ma być wyświetlany i edytowany w widoku.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok, który wyświetla szczegóły komentarza. Zawiera pole tekstowe do edycji tekstu komentarza i przycisk do aktualizacji komentarza.

**Opis**: W tym widoku wyświetlane są szczegóły konkretnego komentarza, w tym pole tekstowe umożliwiające edycję tekstu komentarza oraz przycisk umożliwiający aktualizację informacji o komentarzu.

#### ContentView.swift

**Struct (Struktura)**: _ContentView_

**Metody**:
- _deleteUser(at offsets: IndexSet)_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Usuwa użytkownika o określonym indeksie na liście użytkowników. Wysyła żądanie DELETE do serwera, aby usunąć użytkownika według jego ID.

**Pola i właściwości**:
- userViewModel
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Zarządza stanem i logiką widoków związanych z użytkownikiem. Służy do pobierania i aktualizowania szczegółów użytkownika.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok z linkami nawigacyjnymi do LoginView i RegisterView.

**Opis**: Ten widok przedstawia główny widok PhotoManagerApp. Zawiera linki nawigacyjne do widoków logowania i rejestracji.

**Struct (Struktura)**: _ContentView_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość previews zwraca podgląd ContentView dla obszaru roboczego podglądu SwiftUI.

**Opis**: Ta struktura udostępnia podgląd ContentView w podglądzie SwiftUI w Xcode.

#### CommentView.swift

**Struct (Struktura)**: _CommentView_

**Metody**:
- _deleteComment(at offsets: IndexSet)_
  - **Dostęp (modyfikator dostępu)**: private
  - **Opis**: Usuwa komentarz o określonym indeksie na liście komentarzy. Wysyła żądanie DELETE do serwera, aby usunąć komentarz według jego ID.

**Pola i właściwości**:
- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok, który wyświetla formularz umożliwiający utworzenie lub edycję komentarza oraz przycisk przesyłania.

**Opis**: Ten widok przedstawia interfejs do tworzenia lub edytowania komentarzy w PhotoManagerApp. Zawiera pole tekstowe dla komentarza i przycisk przesyłania.

**Struct (Struktura)**: _CommentListView\_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość previews zwraca podgląd CommentView dla obszaru roboczego podglądu SwiftUI.

**Opis**: Ta struktura udostępnia podgląd CommentView w podglądzie SwiftUI w Xcode.

#### PhotoDetailView.swift

**Struct (Struktura)**: _PhotoDetailView_

**Metody**: Brak

**Pola i właściwości**:
- _photoViewModel_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Obserwowany obiekt, który zarządza stanem i logiką widoków związanych ze zdjęciami. Służy do pobierania i aktualizowania szczegółów zdjęć.

- _photo_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość reprezentująca zdjęcie, które ma być wyświetlane i edytowane w widoku.

- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca widok, który wyświetla szczegóły zdjęcia. Zawiera pola tekstowe do edycji tytułu i adresu URL zdjęcia oraz przycisk do aktualizacji zdjęcia.

**Opis**: W tym widoku wyświetlane są szczegóły konkretnego zdjęcia, w tym pola tekstowe umożliwiające edycję tytułu i adresu URL zdjęcia oraz przycisk umożliwiający aktualizację informacji o zdjęciu.

### MainApp_Client

#### MainApp_Client.swift

**Struct (Struktura)**: _MainApp_Client_

**Metody**: Brak

**Pola i właściwości**:
- _body_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość body zwraca scenę, która zawiera główną grupę okien dla aplikacji. Inicjuje i wyświetla ContentView.

**Opis**: Ta struktura reprezentuje główny punkt wejścia aplikacji klienckiej. Jest zgodna z protokołem SwiftUI.App i definiuje główną grupę okien, która zaczyna się od ContentView.

**Struct (Struktura)**: _MainApp_Client_Previews_

**Metody**: Brak

**Pola i właściwości**:
- _previews_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Właściwość previews zwraca podgląd MainApp_Client dla obszaru roboczego podglądu SwiftUI.

**Opis**: Ta struktura udostępnia podgląd MainApp_Client w podglądzie SwiftUI w środowisku Xcode.

## Moduł serwera

### Modele (Serwer)

#### UserModel_Server.swift
**Właściwości**:
- id (UUID),
- username (String),
- email (String),
- password (String)

**Klucz główny**: id

**Brak kluczy obcych**

**Relacje**: Ma wiele komentarzy, ma wiele albumów
- id <=> CommentModel_Server.userID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- id <=> AlbumModel_Server.userID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

#### AlbumModel_Server.swift
**Właściwości**:
- id (UUID),
- title (String),
- userID (UUID)

**Klucz główny**: id

**Klucz obcy**: userID

**Relacje**: Należy do użytkownika, ma wiele zdjęć
- userID <=> UserModel_Server.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- id <=> PhotoModel_Server.albumID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

#### PhotoModel_Server.swift
**Właściwości**:
- id (UUID),
- title (String),
- url (String), albumID (UUID)

**Klucz główny**: id

**Klucz obcy**: albumID

**Relacje**: Należy do albumu, ma wiele komentarzy
- albumID <=> AlbumModel_Server.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- id <=> CommentModel_Server.photoID
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

#### CommentModel_Server.swift
**Właściwości**:
- id (UUID),
- text (String),
- photoID (UUID),
- userID (UUID)

**Klucz główny**: id

**Klucze obce**: photoID, userID

**Relacje**: Należy do użytkownika i zdjęcia
- photoID <=> PhotoModel_Server.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*
- userID <=> UserModel_Server.id
  - Typ relacji: jeden do wielu
  - Kardynalność: 1..*

### Kontrolery (Serwer)

#### UserController_Server.swift

**Metody**:
- _boot(routes: RoutesBuilder)_
  - **Metoda HTTP**: Brak
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Konfiguruje trasy dla operacji związanych z użytkownikiem. Grupuje trasy w ścieżce /users i przypisuje odpowiednie metody HTTP i punkty końcowe do metod kontrolera.

- _login(req: Request)_
  - **Metoda HTTP**: POST
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Uwierzytelnia użytkownika, sprawdzając podane poświadczenia względem zapisanych danych użytkownika. Zwraca uwierzytelnionego użytkownika, jeśli operacja się powiedzie.

- _register(req: Request)_
  - **Metoda HTTP**: POST
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Rejestruje nowego użytkownika poprzez hashowanie hasła i zapisanie danych użytkownika w bazie danych. Zwraca utworzonego użytkownika.

- _getAllUsers(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkich użytkowników z bazy danych i ich zwraca.

- _getUser(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedynczego użytkownika według jego ID z bazy danych i zwraca go. Jeśli użytkownik nie zostanie znaleziony, zwraca błąd notFound.

- _updateUser(req: Request)_
  - **Metoda HTTP**: PUT
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Aktualizuje istniejącego użytkownika dostarczonymi danymi. Pobiera użytkownika według ID, aktualizuje odpowiednie pola i zapisuje zmiany. Zwraca zaktualizowanego użytkownika.

- _deleteUser(req: Request)_
  - **Metoda HTTP**: DELETE
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Usuwa użytkownika według jego ID z bazy danych. Jeśli użytkownik zostanie znaleziony i pomyślnie usunięty, zwraca status ok.

**Pola i właściwości**: Brak

**Opis**: Zarządza operacjami związanymi z użytkownikiem, w tym uwierzytelnianiem, rejestracją i operacjami CRUD.

#### PhotoController_Server.swift

**Metody**:
- _boot(routes: RoutesBuilder)_
  - **Metoda HTTP**: Brak
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Konfiguruje trasy dla operacji związanych ze zdjęciami. Grupuje trasy w ścieżce /photos i przypisuje odpowiednie metody HTTP i punkty końcowe do metod kontrolera.

- _getAllHandler(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkie zdjęcia z bazy danych i je zwraca.

- _createHandler(req: Request)_
  - **Metoda HTTP**: POST
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Tworzy nowe zdjęcie z dostarczonymi danymi i zapisuje je w bazie danych. Zwraca utworzone zdjęcie.

- _getHandler(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedyncze zdjęcie według jego ID z bazy danych i zwraca je. Jeśli zdjęcie nie zostanie znalezione, zwraca błąd notFound.

- _updateHandler(req: Request)_
  - **Metoda HTTP**: PUT
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Aktualizuje istniejące zdjęcie dostarczonymi danymi. Pobiera zdjęcie według ID, aktualizuje odpowiednie pola i zapisuje zmiany. Zwraca zaktualizowane zdjęcie.

- _deleteHandler(req: Request)_
  - **Metoda HTTP**: DELETE
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Usuwa zdjęcie według jego ID z bazy danych. Jeśli zdjęcie zostanie znalezione i pomyślnie usunięte, zwraca status ok.

**Pola i właściwości**: Brak

**Opis**: Zarządza operacjami związanymi ze zdjęciami, w tym ich tworzeniem, pobieraniem, aktualizacją i usuwaniem.

#### CommentController_Server.swift

**Metody**:
- _boot(routes: RoutesBuilder)_
  - **Metoda HTTP**: Brak
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Konfiguruje trasy dla operacji związanych z komentarzami. Grupuje trasy w ścieżce /comments i przypisuje odpowiednie metody HTTP i punkty końcowe do metod kontrolera.

- _getAllHandler(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkie komentarze z bazy danych i je zwraca.

- _createHandler(req: Request)_
  - **Metoda HTTP**: POST
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Tworzy nowy komentarz z dostarczonymi danymi i zapisuje go w bazie danych. Zwraca utworzony komentarz.

- _getHandler(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedynczy komentarz według jego ID z bazy danych i zwraca go. Jeśli komentarz nie zostanie znaleziony, zwraca błąd notFound.

- _updateHandler(req: Request)_
  - **Metoda HTTP**: PUT
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Aktualizuje istniejący komentarz dostarczonymi danymi. Pobiera komentarz według ID, aktualizuje odpowiednie pola i zapisuje zmiany. Zwraca zaktualizowany komentarz.

- _deleteHandler(req: Request)_
  - **Metoda HTTP**: DELETE
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Usuwa komentarz według jego ID z bazy danych. Jeśli komentarz zostanie znaleziony i pomyślnie usunięty, zwraca status ok.

**Pola i właściwości**: Brak

**Opis**: Zarządza operacjami związanymi z komentarzami, w tym ich tworzeniem, pobieraniem, aktualizacją i usuwaniem.

#### AlbumController_Server.swift

**Metody**:
- _boot(routes: RoutesBuilder)_
  - **Metoda HTTP**: Brak
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Konfiguruje trasy dla operacji związanych z albumem. Grupuje trasy w ścieżce /albums i przypisuje odpowiednie metody HTTP i punkty końcowe do metod kontrolera.

- _getAllHandler(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera wszystkie albumy z bazy danych i je zwraca.

- _createHandler(req: Request)_
  - **Metoda HTTP**: POST
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Tworzy nowy album z dostarczonymi danymi i zapisuje go w bazie danych. Zwraca utworzony album.

- _getHandler(req: Request)_
  - **Metoda HTTP**: GET
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedynczy album według jego ID z bazy danych i zwraca go. Jeśli album nie zostanie znaleziony, zwraca błąd notFound.

- _updateHandler(req: Request)_
  - **Metoda HTTP**: PUT
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Aktualizuje istniejący album dostarczonymi danymi. Pobiera album według ID, aktualizuje odpowiednie pola i zapisuje zmiany. Zwraca zaktualizowany album.

- _deleteHandler(req: Request)_
  - **Metoda HTTP**: DELETE
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Usuwa album według jego ID z bazy danych. Jeśli album zostanie znaleziony i pomyślnie usunięty, zwraca status ok.

**Pola i właściwości**: Brak

**Opis**: Zarządza operacjami związanymi z albumami, w tym ich tworzeniem, pobieraniem, aktualizacją i usuwaniem.

### Migracje (Serwer)

#### CreateUser.swift

**Klasa**: _CreateUser_

**Metody**:
- _prepare(on: Database)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Kolumny**:
    - _id_: Unikalny identyfikator każdego użytkownika.
    - _username_: Ciąg reprezentujący nazwę użytkownika. To pole jest wymagane.
    - _email_: Ciąg reprezentujący adres e-mail użytkownika. To pole jest wymagane.
    - _password_: Ciąg reprezentujący zahaszowane hasło użytkownika. To pole jest wymagane.
  - **Opis**: Ta metoda konfiguruje schemat dla tabeli użytkowników. Definiuje kolumny i ich typy, w tym identyfikator, nazwę użytkownika, adres e-mail i hasło.

- _revert(on: Database)_ - usuwa tabelę użytkowników.
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Ta metoda usuwa schemat tabeli użytkowników z bazy danych. Służy do wycofania zmian wprowadzonych przez metodę prepare.

**Pola i właściwości**: Brak

**Opis**: Zarządza migracją w celu tworzenia i usuwania tabel użytkowników.

#### CreateAlbum.swift

**Klasa**: _CreateAlbum_

**Metody**:
- _prepare(on: Database)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Kolumny**:
    - _id_: Unikalny identyfikator każdego albumu.
    - _title_: Ciąg reprezentujący tytuł albumu. To pole jest wymagane.
    - _user\_id_: UUID odwołujący się do kolumny id w tabeli users. To pole jest wymagane i ustanawia relację klucza obcego.
  - **Opis**: Ta metoda ustawia schemat dla tabeli albums. Definiuje kolumny i ich typy, w tym ID, tytuł i klucz obcy do tabeli users.

- _revert(on: Database)_ - usuwa tabelę użytkowników.
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Ta metoda usuwa schemat tabeli albums z bazy danych. Służy do wycofania zmian wprowadzonych przez metodę prepare.

**Pola i właściwości**: Brak

**Opis**: Zarządza migracją w celu tworzenia i usuwania tabeli albumów.

#### CreateComment.swift

**Klasa**: _CreateComment_

**Metody**:
- _prepare(on: Database)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Kolumny**:
    - _id_: Unikalny identyfikator dla każdego komentarza.
    - _text_: Ciąg reprezentujący tekst komentarza. To pole jest wymagane.
    - _photo\_id_: UUID odwołujący się do kolumny id w tabeli photos. To pole jest wymagane i ustanawia relację klucza obcego.
    - _user\_id_: UUID odwołujący się do kolumny id w tabeli users. To pole jest wymagane i ustanawia relację klucza obcego.
  - **Opis**: Ta metoda ustawia schemat dla tabeli komentarzy. Definiuje kolumny i ich typy, w tym identyfikator, tekst i klucze obce do tabel zdjęć i użytkowników.

- _revert(on: Database)_ - usuwa tabelę użytkowników.
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Ta metoda usuwa schemat tabeli komentarzy z bazy danych. Służy do wycofania zmian wprowadzonych przez metodę prepare.

**Pola i właściwości**: Brak

**Opis**: Zarządza migracją w celu tworzenia i usuwania tabeli komentarzy.

#### CreatePhoto.swift

**Klasa**: _CreatePhoto_

**Metody**:
- _prepare(on: Database)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Kolumny**:
    - id: Unikalny identyfikator dla każdego zdjęcia.
    - title: Ciąg reprezentujący tytuł zdjęcia. To pole jest wymagane.
    - url: Ciąg reprezentujący adres URL zdjęcia. To pole jest wymagane.
    - album_id: UUID odwołujący się do kolumny id w tabeli albums. To pole jest wymagane i ustanawia relację klucza obcego.
  - **Opis**: Ta metoda konfiguruje schemat dla tabeli photos. Definiuje kolumny i ich typy, w tym ID, tytuł, adres URL i klucz obcy do tabeli albums.

- _revert(on: Database)_ - usuwa tabelę użytkowników.
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Ta metoda usuwa schemat tabeli photos z bazy danych. Służy do wycofania zmian wprowadzonych przez metodę prepare.

**Pola i właściwości**: Brak

**Opis**: Zarządza migracją w celu tworzenia i usuwania tabeli zdjęć.

### Usługi (Serwer)

#### AuthService.swift

**Klasa**: _AuthService_

**Metody**:
- _register(req: Request)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Ta metoda rejestruje nowego użytkownika. Haszuje hasło użytkownika za pomocą Bcrypt i zapisuje użytkownika w bazie danych.

- _login(req: Request)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Pobiera pojedyncze zdjęcie według jego ID z serwera i aktualizuje właściwość zdjęcia. W przypadku awarii ustawia właściwość errorMessage z opisem błędu.

**Pola i właściwości**: Brak

**Opis**: Zapewnia usługi uwierzytelniania dla rejestracji i logowania użytkowników. Obsługuje tworzenie nowych użytkowników z haszowanymi hasłami i uwierzytelnia istniejących użytkowników, weryfikując ich dane uwierzytelniające.

#### PhotoStorageService.swift

**Metody**:
- _storePhoto(req: Request, photo: ServerPhoto)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Ta metoda przechowuje zdjęcie na serwerze. Zapisuje dane zdjęcia na dysku serwera i zapisuje informacje o zdjęciu w bazie danych.

- _fetchPhoto(req: Request, photoID: UUID)_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Ta metoda pobiera zdjęcie z serwera. Odczytuje dane zdjęcia z dysku serwera i zwraca je w odpowiedzi.

**Pola i właściwości**: Brak

**Opis**: Zapewnia usługi przechowywania i pobierania zdjęć na serwerze. Obsługuje logikę zapisywania plików zdjęć na dysku serwera i pobierania ich na żądanie klienta.

### MainApp_Server

#### MainApp_Server.swift

**Metody**:
- _main()_
  - **Dostęp (modyfikator dostępu)**: private static
  - **Opis**: Główny punkt wejścia aplikacji serwera. Wykrywa środowisko, konfiguruje rejestrowanie, inicjuje aplikację, konfiguruje bazę danych, rejestruje trasy i uruchamia aplikację.

- _configure(app: Application)_
  - **Dostęp (modyfikator dostępu)**: private static
  - **Opis**: Konfiguruje połączenie z bazą danych i migracje dla aplikacji.

- _routes(app: Application)_
  - **Dostęp (modyfikator dostępu)**: private static
  - **Opis**: Rejestruje trasy i usługi dla aplikacji.
  - **Trasy (Ścieżki, routing)**:
    - POST _/register_ - Rejestruje nowego użytkownika.
    - POST _/login_ - Uwierzytelnia użytkownika.
    - POST _/storePhoto_ - Przechowuje zdjęcie na serwerze.
    - GET _/fetchPhoto/:photoID_ - Pobiera zdjęcie z serwera.

**Właściwości**: Brak

**Opis**: Główny punkt wejścia do części serwerowej aplikacji PhotoManagerApp_Swift_Project4. Ustawia środowisko aplikacji, konfiguruje bazę danych, rejestruje trasy i uruchamia aplikację.

## Testowanie

### Testy aplikacji klienckiej

#### ClientTests.swift

**Metody**:
- _setUpWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Ustawia środowisko testowe przed wywołaniem każdej metody testowej w klasie. Inicjuje userViewModel i photoViewModel.

- _tearDownWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Czyści środowisko testowe po wywołaniu każdej metody testowej w klasie. Deinicjalizuje userViewModel i photoViewModel.

- _setUp()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowa konfiguracja przed wywołaniem każdej metody testowej w klasie.

- _tearDown()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowe czyszczenie jest wykonywane po wywołaniu każdej metody testowej w klasie.

- _testFetchUsers()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje metodę fetchUsers UserViewModel. Potwierdza, że ​​tablica users nie jest pusta po pobraniu users.

- _testFetchPhotos()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje metodę fetchPhotos modelu PhotoViewModel. Potwierdza, że ​​tablica photos nie jest pusta po pobraniu photos.

- _testUserViewModelInitialization()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje inicjalizację UserViewModel. Potwierdza, że ​​userViewModel nie jest nil.

- _testPhotoViewModelInitialization()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje inicjalizację PhotoViewModel. Potwierdza, że ​​photoViewModel nie jest nil.

**Właściwości**:
- _userViewModel_:
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Instancja UserViewModel użyta do testowania.

- _photoViewModel_:
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Instancja PhotoViewModel użyta do testowania.

**Opis**: Zawiera testy jednostkowe dla modeli widoku po stronie klienta aplikacji PhotoManagerApp_Swift_Project4. Testuje funkcjonalność klas UserViewModel i PhotoViewModel.

### Testy serwera

#### ServerTests.swift

**Metody**:
- _setUpWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Konfiguruje środowisko testowe przed wywołaniem każdej metody testowej w klasie. Inicjuje wystąpienie aplikacji i konfiguruje je.

- _tearDownWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Czyści środowisko testowe po wywołaniu każdej metody testowej w klasie. Zamyka instancję aplikacji.

- _setUp()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowa konfiguracja przed wywołaniem każdej metody testowej w klasie.

- _tearDown()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowe czyszczenie jest wykonywane po wywołaniu każdej metody testowej w klasie.

- _configure(app: Application)_
  - **Dostęp (modyfikator dostępu)**: domyślny (internal)
  - **Opis**: Konfiguruje wystąpienie aplikacji z bazą danych SQLite w pamięci i uruchamia migracje.

- _testUserCreation()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje punkt końcowy tworzenia użytkownika. Potwierdza, że ​​użytkownik może zostać pomyślnie utworzony i zwrócone dane użytkownika są poprawne.

- _testPhotoCreation()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje punkt końcowy tworzenia zdjęcia. Potwierdza, że ​​zdjęcie może zostać pomyślnie utworzone i zwrócone dane zdjęcia są poprawne.

- _testHealthCheck()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje punkt końcowy kontroli kondycji. Potwierdza, że ​​kontrola kondycji zwraca status OK.

**Właściwości**:
- _app_:
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Instancja aplikacji użyta do testowania.

**Opis**: Zawiera testy jednostkowe dla komponentów po stronie serwera aplikacji PhotoManagerApp_Swift_Project4. Testuje funkcjonalność różnych operacji po stronie serwera, takich jak tworzenie użytkownika, tworzenie zdjęcia i kontrole kondycji.

### Testy wspólne

#### SharedTests.swift

**Metody**:
- _setUpWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Konfiguruje środowisko testowe przed wywołaniem każdej metody testowej w klasie. Inicjuje wystąpienie aplikacji i konfiguruje je.

- _tearDownWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Czyści środowisko testowe po wywołaniu każdej metody testowej w klasie. Zamyka instancję aplikacji.

- _setUp()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowa konfiguracja przed wywołaniem każdej metody testowej w klasie.

- _tearDown()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowe czyszczenie jest wykonywane po wywołaniu każdej metody testowej w klasie.

- _testUserFlow()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje przepływ rejestracji i logowania użytkownika. Upewnia się, że użytkownik może się zarejestrować, zalogować i zostać pomyślnie uwierzytelniony.

- _testExample()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Przykładowa metoda testowa weryfikująca, czy prosty warunek jest prawdziwy.

**Właściwości**:
- _app_:
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Instancja aplikacji użyta do testowania.

**Opis**: Zawiera testy jednostkowe do testowania ogólnej funkcjonalności i przepływu aplikacji PhotoManagerApp_Swift_Project4. Obejmuje to testowanie procesu rejestracji i logowania użytkownika.

### Testy UI aplikacji klienckiej

#### ClientUITests.swift

**Metody**:
- _setUpWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Konfiguruje środowisko testowe przed wywołaniem każdej metody testowej w klasie. Uruchamia aplikację XCUIApplication

- _tearDownWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Czyści środowisko testowe po wywołaniu każdej metody testowej w klasie.

- _setUp()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowa konfiguracja przed wywołaniem każdej metody testowej w klasie.

- _tearDown()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowe czyszczenie jest wykonywane po wywołaniu każdej metody testowej w klasie.

- _testExample()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje funkcjonalność przycisków „Login” i „Register”. Sprawdza, czy odpowiednie ekrany są wyświetlane po naciśnięciu przycisków.

- _testLaunchPerformance()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Mierzy wydajność uruchamiania aplikacji.

**Właściwości**:
- _app_:
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Instancja XCUIApplication używana do testowania interfejsu użytkownika.

**Opis**: Zawiera testy UI dla aplikacji PhotoManagerApp_Swift_Project4. Te testy weryfikują funkcjonalność komponentów interfejsu użytkownika, takich jak przyciski i nawigacja.

#### ClientUITestsLaunchTests.swift

**Metody**:
- _runsForEachTargetApplicationUIConfiguration()_ (class var)
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Oznacza, że ​​zestaw testów jest uruchamiany dla każdej konfiguracji interfejsu użytkownika aplikacji docelowej.

- _setUpWithError()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Konfiguruje środowisko testowe przed wywołaniem każdej metody testowej w klasie. Kontynuuje wykonywanie testu nawet w przypadku wystąpienia błędu.

- _setUp()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowa konfiguracja przed wywołaniem każdej metody testowej w klasie.

- _tearDown()_
  - **Dostęp (modyfikator dostępu)**: public (override)
  - **Opis**: Dodatkowe czyszczenie jest wykonywane po wywołaniu każdej metody testowej w klasie.

- _testLaunch()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Testuje uruchomienie aplikacji i przechwytuje zrzut ekranu stanu początkowego. Zrzut ekranu jest następnie dołączany do wyników testu z określoną nazwą i czasem życia.

- _testExample()_
  - **Dostęp (modyfikator dostępu)**: domyślny (public)
  - **Opis**: Przykładowa metoda testowa weryfikująca, czy prosty warunek jest prawdziwy.

**Właściwości**: Brak

**Opis**: Zawiera testy weryfikujące wydajność uruchamiania i początkowy ekran aplikacji PhotoManagerApp_Swift_Project4. Te testy zapewniają, że aplikacja uruchamia się poprawnie i przechwytuje początkowy stan interfejsu użytkownika.