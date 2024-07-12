//
//  PhotoViewModel.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation
import Combine

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var photo: Photo?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPhotos() {
        guard let url = URL(string: "http://localhost:8080/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { photos in
                self.photos = photos
            }
            .store(in: &cancellables)
    }
    
    func fetchPhoto(id: UUID) {
        guard let url = URL(string: "http://localhost:8080/photos/\(id.uuidString)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Photo.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { photo in
                self.photo = photo
            }
            .store(in: &cancellables)
    }
    
    func createPhoto(_ photo: Photo) {
        guard let url = URL(string: "http://localhost:8080/photos") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(photo)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Photo.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { photo in
                self.photo = photo
                self.fetchPhotos() // odśwież listę
            }
            .store(in: &cancellables)
    }
    
    func updatePhoto(_ photo: Photo) {
        guard let url = URL(string: "http://localhost:8080/photos/\(photo.id?.uuidString ?? "")") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(photo)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Photo.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { photo in
                self.photo = photo
                self.fetchPhotos() // odśwież listę
            }
            .store(in: &cancellables)
    }
    
    func deletePhoto(id: UUID) {
        guard let url = URL(string: "http://localhost:8080/photos/\(id.uuidString)") else { return }
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
                self.fetchPhotos() // odśwież listę
            }
            .store(in: &cancellables)
    }
}


