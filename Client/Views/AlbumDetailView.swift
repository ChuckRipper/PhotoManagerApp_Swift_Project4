//
//  AlbumDetailView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/10/24.
//

//import SwiftUI
//
//struct AlbumDetailView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    AlbumDetailView()
//}

import SwiftUI

struct AlbumDetailView: View {
    @ObservedObject var albumViewModel = AlbumViewModel()
    var album: Album
    
//    var body: some View {
//        VStack {
//            TextField("Title", text: $albumViewModel.album?.title ?? "")
//            
//            Button("Update Album") {
//                albumViewModel.updateAlbum(album)
//            }
//        }
//        .onAppear {
//            albumViewModel.fetchAlbum(id: album.id!)
//        }
//    }
    
    var body: some View {
            VStack {
                TextField("Title", text: Binding(
                    get: { albumViewModel.album?.title ?? "" },
                    set: { albumViewModel.album?.title = $0 }
                ))
                
                Button("Update Album") {
                    if let album = albumViewModel.album {
                        albumViewModel.updateAlbum(album)
                    }
                }
            }
            .onAppear {
                albumViewModel.fetchAlbum(id: album.id!)
            }
        }
}
