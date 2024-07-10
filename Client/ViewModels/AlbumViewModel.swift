//
//  AlbumViewModel.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation
import Combine

class AlbumViewModel: ObservableObject {
    @Published var albums: [Album] = []
    @Published var album: Album?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAlbums() {
        guard let url = URL(string: "http://localhost:8080/albums") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Album].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { albums in
                self.albums = albums
            }
            .store(in: &cancellables)
    }
    
    func fetchAlbum(id: UUID) {
        guard let url = URL(string: "http://localhost:8080/albums/\(id.uuidString)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Album.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { album in
                self.album = album
            }
            .store(in: &cancellables)
    }
    
    func createAlbum(_ album: Album) {
        guard let url = URL(string: "http://localhost:8080/albums") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(album)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Album.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { album in
                self.album = album
                self.fetchAlbums() // refresh the list
            }
            .store(in: &cancellables)
    }
    
    func updateAlbum(_ album: Album) {
        guard let url = URL(string: "http://localhost:8080/albums/\(album.id?.uuidString ?? "")") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(album)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Album.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { album in
                self.album = album
                self.fetchAlbums() // refresh the list
            }
            .store(in: &cancellables)
    }
    
    func deleteAlbum(id: UUID) {
        guard let url = URL(string: "http://localhost:8080/albums/\(id.uuidString)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.fetchAlbums() // refresh the list
            }
            .store(in: &cancellables)
    }
}


