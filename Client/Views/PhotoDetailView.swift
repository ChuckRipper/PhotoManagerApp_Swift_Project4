//
//  PhotoDetailView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import SwiftUI

struct PhotoDetailView: View {
    @ObservedObject var photoViewModel = PhotoViewModel()
    var photo: Photo
    
    var body: some View {
            VStack {
                TextField("Title", text: Binding(
                    get: { photoViewModel.photo?.title ?? "" },
                    set: { photoViewModel.photo?.title = $0 }
                ))
                TextField("URL", text: Binding(
                    get: { photoViewModel.photo?.url ?? "" },
                    set: { photoViewModel.photo?.url = $0 }
                ))
                
                Button("Update Photo") {
                    if let photo = photoViewModel.photo {
                        photoViewModel.updatePhoto(photo)
                    }
                }
            }
            .onAppear {
                photoViewModel.fetchPhoto(id: photo.id!)
            }
        }}
