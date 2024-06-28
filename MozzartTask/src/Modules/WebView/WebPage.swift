//
//  WebPage.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 26.6.24.
//

import SwiftUI

struct WebPage: View {

  // MARK: - Private (Properties)
  private let webView = WebView()
  private let url = Links.webPage
  
  // MARK: - View
  var body: some View {
    webView
      .onAppear {
        webView.loadURL(url: url)
      }
      .toolbarColorScheme(.dark, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .ignoresSafeArea()
  }
}

#Preview {
  WebPage()
}
