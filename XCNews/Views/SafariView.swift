//
//  SafariView.swift
//  XCNews
//
//  Created by henry on 2023/2/21.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url:URL
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
