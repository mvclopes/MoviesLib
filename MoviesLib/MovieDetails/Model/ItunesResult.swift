//
//  ItunesResult.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 13/09/22.
//

import Foundation

struct ItunesResult: Decodable {
    let results: [MovieInfo]
}

struct MovieInfo: Decodable {
    let previewUrl: String
}
