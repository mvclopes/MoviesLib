//
//  MovieTableViewCell.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 02/09/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    func configure(with movie: Movie) {
        labelTitle.text = movie.title
        labelSummary.text = movie.summary
        labelRating.text = movie.ratingFormatted
        if let image = movie.image {
            imageViewPoster.image = UIImage(data: image)
        }
        imageViewPoster.layer.cornerRadius = 8
    }
}
