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
  private let urlString = "https://www.mozzartbet.com/sr/lotto-animation/26#/"
  
  // MARK: - View
  var body: some View {
    webView
      .onAppear {
        webView.loadURL(urlString: urlString)
      }
      .toolbarColorScheme(.dark, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
  }
}

#Preview {
  WebPage()
}
