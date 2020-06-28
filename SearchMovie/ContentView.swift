//
//  ContentView.swift
//  SearchMovie
//
//  Created by zunda on 2020/06/27.
//  Copyright © 2020 zunda. All rights reserved.
//

import SwiftUI

var keyword: String = "魚"
var movies: [Movie] = []
var movieList:MovieList = MovieList(keyword: keyword)
var checkedMovies: [Movie] = []


struct ContentView: View {
    
    init(){
        movieList.setMovieCount()
        movies = movieList.getMovies()
    }
    
    @State var textField = ""
    var body: some View {
        
        
        VStack{
            TextField("映画名", text: $textField, onCommit: {
                                keyword = self.textField
                                movieList = MovieList(keyword: keyword)
                           })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
            NavigationView{
                List(0 ..< movies.count) { item in
                    NavigationLink(destination: MovieDetail(movie: movies[item])) {
                        MovieRow(movie: movies[item])
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

