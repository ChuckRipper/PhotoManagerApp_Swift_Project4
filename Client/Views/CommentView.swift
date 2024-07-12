//
//  CommentView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import SwiftUI

struct CommentListView: View {
    @StateObject private var commentViewModel = CommentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(commentViewModel.comments) { comment in
                    NavigationLink(destination: CommentDetailView(comment: comment)) {
                        Text(comment.text)
                    }
                }
                .onDelete(perform: deleteComment)
            }
            .navigationBarTitle("Comments")
            .navigationBarItems(trailing: Button(action: {
                commentViewModel.fetchComments()
            }) {
                Image(systemName: "arrow.clockwise")
            })
            .onAppear {
                commentViewModel.fetchComments()
            }
        }
    }
    
    private func deleteComment(at offsets: IndexSet) {
        offsets.forEach { index in
            let comment = commentViewModel.comments[index]
            if let id = comment.id {
                commentViewModel.deleteComment(id: id)
            }
        }
    }
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentListView()
    }
}
