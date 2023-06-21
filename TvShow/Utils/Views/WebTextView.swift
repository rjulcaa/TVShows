//
//  WebTextView.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import SwiftUI
import WebKit

struct HTMLTextView: UIViewRepresentable {
    var text: String
    public let width: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let data = Data(text.utf8)
        let label = UILabel()
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            label.attributedText = attributedString
        }
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.preferredMaxLayoutWidth = width
        label.textAlignment = .left
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) { }
    
}
