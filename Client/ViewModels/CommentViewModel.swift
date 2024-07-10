//
//  CommentViewModel.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation
import Combine

class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var comment: Comment?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchComments() {
        guard let url = URL(string: "http://localhost:8080/comments") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { comments in
                self.comments = comments
            }
            .store(in: &cancellables)
    }
    
    func fetchComment(id: UUID) {
        guard let url = URL(string: "http://localhost:8080/comments/\(id.uuidString)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Comment.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { comment in
                self.comment = comment
            }
            .store(in: &cancellables)
    }
    
    func createComment(_ comment: Comment) {
        guard let url = URL(string: "http://localhost:8080/comments") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(comment)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Comment.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { comment in
                self.comment = comment
                self.fetchComments() // refresh the list
            }
            .store(in: &cancellables)
    }
    
    func updateComment(_ comment: Comment) {
        guard let url = URL(string: "http://localhost:8080/comments/\(comment.id?.uuidString ?? "")") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(comment)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Comment.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { comment in
                self.comment = comment
                self.fetchComments() // refresh the list
            }
            .store(in: &cancellables)
    }
    
    func deleteComment(id: UUID) {
        guard let url = URL(string: "http://localhost:8080/comments/\(id.uuidString)") else { return }
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
                self.fetchComments() // refresh the list
            }
            .store(in: &cancellables)
    }
}


