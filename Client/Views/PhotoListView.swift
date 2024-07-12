//
//  PhotoListView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import SwiftUI

struct PhotoListView: View {
    @StateObject private var photoViewModel = PhotoViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(photoViewModel.photos) { photo in
                    NavigationLink(destination: PhotoDetailView(photo: photo)) {
                        Text(photo.title)
                    }
                }
                .onDelete(perform: deletePhoto)
            }
            .navigationBarTitle("Photos")
            .navigationBarItems(trailing: Button(action: {
                photoViewModel.fetchPhotos()
            }) {
                Image(systemName: "arrow.clockwise")
            })
            .onAppear {
                photoViewModel.fetchPhotos()
            }
        }
    }
    
    private func deletePhoto(at offsets: IndexSet) {
        offsets.forEach { index in
            let photo = photoViewModel.photos[index]
            if let id = photo.id {
                photoViewModel.deletePhoto(id: id)
            }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
