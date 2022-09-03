//
//  Movie.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 02/09/22.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let categories: String
    let duration: String
    let rating: Double
    let summary: String
    let image: String
    
    /* Coding para mapear nomes diferentes das propriedades
    enum CodingKeys: String, CodingKey {
        case title
        case categories
        case duration
        case rating
        case summary
        case image
    }
     */
}
