//
//  MovieDetail.swift
//  SearchMovie
//
//  Created by zunda on 2020/06/28.
//  Copyright © 2020 zunda. All rights reserved.
//

import SwiftUI

import WebKit

class observable: ObservableObject {
    @Published var observation:NSKeyValueObservation?
}

struct WebView: UIViewRepresentable {
    var loadUrl:String
    @ObservedObject var observe = observable()

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        observe.observation = uiView.observe(\WKWebView.url, options: .new) { view, change in
            if let url = uiView.url {
                print("Page loaded: \(url)")
            }
        }
        uiView.load(URLRequest(url: URL(string: loadUrl)!))
    }
}

struct MovieDetail: View {
    var movie: Movie
    var body: some View {
        VStack{
            WebView(loadUrl: movie.url)
            Spacer()
        }
    }
}
