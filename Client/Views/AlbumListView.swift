//
//  AlbumListView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

//import SwiftUI
//
//struct AlbumListView: View {
//    var body: some View {
//        Text("Album List")
//            .navigationBarTitle("Albums")
//    }
//}
//
//struct AlbumListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumListView()
//    }
//}

import SwiftUI

struct AlbumListView: View {
    @StateObject private var albumViewModel = AlbumViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(albumViewModel.albums) { album in
                    NavigationLink(destination: AlbumDetailView(album: album)) {
                        Text(album.title)
                    }
                }
                .onDelete(perform: deleteAlbum)
            }
            .navigationBarTitle("Albums")
            .navigationBarItems(trailing: Button(action: {
                albumViewModel.fetchAlbums()
            }) {
                Image(systemName: "arrow.clockwise")
            })
            .onAppear {
                albumViewModel.fetchAlbums()
            }
        }
    }
    
    private func deleteAlbum(at offsets: IndexSet) {
        offsets.forEach { index in
            let album = albumViewModel.albums[index]
            if let id = album.id {
                albumViewModel.deleteAlbum(id: id)
            }
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
