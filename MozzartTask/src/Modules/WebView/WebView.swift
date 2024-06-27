//
//  WebView.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 26.6.24..
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  
  // MARK: - Public (Properties)
  let webView: WKWebView
  
  // MARK: - Init
  init() {
    webView = WKWebView()
  }
  
  // MARK: - UIViewRepresentable
  func makeUIView(context: Context) -> WKWebView {
    webView.allowsBackForwardNavigationGestures = true
    webView.allowsLinkPreview = true
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) { }
  
  // MARK: - Public (Interface)
  func loadURL(url: URL) {
    webView.load(URLRequest(url: url))
  }
}
