//
//  WebView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 14.07.2025.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
