//
//  CommentDetailView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/10/24.
//

import SwiftUI

struct CommentDetailView: View {
    @ObservedObject var commentViewModel = CommentViewModel()
    var comment: Comment
    
//    var body: some View {
//        VStack {
//            TextField("Text", text: $commentViewModel.comment?.text ?? "")
//            
//            Button("Update Comment") {
//                commentViewModel.updateComment(comment)
//            }
//        }
//        .onAppear {
//            commentViewModel.fetchComment(id: comment.id!)
//        }
//    }
    
    var body: some View {
            VStack {
                TextField("Text", text: Binding(
                    get: { commentViewModel.comment?.text ?? "" },
                    set: { commentViewModel.comment?.text = $0 }
                ))
                
                Button("Update Comment") {
                    if let comment = commentViewModel.comment {
                        commentViewModel.updateComment(comment)
                    }
                }
            }
            .onAppear {
                commentViewModel.fetchComment(id: comment.id!)
            }
        }
}
