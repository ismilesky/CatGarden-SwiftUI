//
//  WebView.swift
//  CatGarden
//
//  Created by edy on 2023/6/19.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = UIColor.clear
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
}
