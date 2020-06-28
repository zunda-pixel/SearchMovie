//
//  Movie.swift
//  SearchMovie
//
//  Created by zunda on 2020/06/27.
//  Copyright © 2020 zunda. All rights reserved.
//

import Foundation

class MovieList {
    var countMovie: Int
    var keyword: String
    var fullURL: String
    var html: String
    var imgURL: String
    var name: String
    var movieURL: String
    var movies : [Movie]
    var eachHTML: [String]
    
    init(keyword: String){
        self.countMovie = 0
        self.html = ""
        self.imgURL = ""
        self.name = ""
        self.movieURL = ""
        self.keyword = keyword
        self.fullURL = ""
        self.movies = []
        self.eachHTML = []
    }
    func getURL() -> URL {
        let foreURL:String = "https://www.amazon.co.jp/s?k="
        let backURL:String = "&i=instant-video&__mk_ja_JP=カタカナ&ref=nb_sb_noss_1"
        self.fullURL = String(format: "%@%@%@", foreURL, self.keyword, backURL)
        
        let encodeUrlString: String = self.fullURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url: URL = URL(string: encodeUrlString)!
        return url
    }
    
    func setMovieCount() -> Void {
        self.html = try! String(contentsOf: getURL())
        self.eachHTML = self.html.components(separatedBy: "data-component-type=\"s-product-image\"")
        self.eachHTML.removeFirst()
        self.countMovie = self.eachHTML.count
    }
    
    func getFeatures(count: Int) -> Movie {
        var temp: String = self.eachHTML[count]
        temp = temp.components(separatedBy: "<div class=\"a-section a-spacing-none\">").first!
        self.name = temp.components(separatedBy: "\"")[9]
        self.movieURL = String(format: "%@%@", "https://www.amazon.co.jp/", temp.components(separatedBy: "\"")[31])
        temp = temp.components(separatedBy: "2.5x, ").last!
        self.imgURL = temp.components(separatedBy: " 3x").first!
        let movie:Movie = Movie(name:self.name, imageURL:self.imgURL, url: self.movieURL)
        return movie
    }
    func getMovies() ->  [Movie] {
        movies = []
        for num in 0..<self.countMovie{
            self.movies.append(getFeatures(count: num))
        }
        return self.movies
    }
}

