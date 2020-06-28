//
//  MovieRow.swift
//  SearchMovie
//
//  Created by zunda on 2020/06/28.
//  Copyright © 2020 zunda. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    var movie: Movie

    var body: some View {
        HStack {
            URLImage(url:movie.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width:100)
            Text(movie.name)
        }
    }
}
