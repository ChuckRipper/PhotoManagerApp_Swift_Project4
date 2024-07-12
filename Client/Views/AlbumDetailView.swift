//
//  AlbumDetailView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/10/24.
//

import SwiftUI

struct AlbumDetailView: View {
    @ObservedObject var albumViewModel = AlbumViewModel()
    var album: Album
    
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
