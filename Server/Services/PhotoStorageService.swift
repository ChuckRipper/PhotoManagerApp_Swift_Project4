//
//  PhotoStorageService.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation
import Vapor
import Fluent

final class PhotoStorageService {
    
    // Przechowywanie zdjęcia na serwerze
    func storePhoto(req: Request, photo: ServerPhoto) throws -> EventLoopFuture<ServerPhoto> {
        // Logika przechowywania zdjęcia, np. zapisanie pliku na dysku serwera
        let photoPath = "/path/to/photos/\(photo.id!.uuidString).jpg"
        let data = Data() // Zakładając, że dane zdjęcia są w zmiennej `data`
        
        do {
            try data.write(to: URL(fileURLWithPath: photoPath))
        } catch {
            throw Abort(.internalServerError, reason: "Could not save photo")
        }
        
        // Zapisanie informacji o zdjęciu w bazie danych
        return photo.save(on: req.db).map { photo }
    }
    
    // Pobieranie zdjęcia z serwera
    func fetchPhoto(req: Request, photoID: UUID) throws -> EventLoopFuture<Response> {
        let photoPath = "/path/to/photos/\(photoID.uuidString).jpg"
        
        guard let fileHandle = FileHandle(forReadingAtPath: photoPath) else {
            throw Abort(.notFound, reason: "Photo not found")
        }
        
        let data = fileHandle.readDataToEndOfFile()
        fileHandle.closeFile()
        
        let response = Response(status: .ok, body: .init(data: data))
        response.headers.add(name: .contentType, value: "image/jpeg")
        return req.eventLoop.makeSucceededFuture(response)
    }
}
