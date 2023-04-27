//
//  EtherscanView.swift
//  voting
//
//  Created by Irfandi Kurniawan Anwar on 04/03/23.
//

import SwiftUI
import WebKit

struct EtherscanView: View {
    
    let url: String
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct EtherscanView_Previews: PreviewProvider {
    static var previews: some View {
        EtherscanView(url: "https://www.google.com")
    }
}

struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WebView.UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
