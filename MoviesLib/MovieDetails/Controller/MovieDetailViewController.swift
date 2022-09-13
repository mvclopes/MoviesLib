//
//  ViewController.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 30/08/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var textViewSummary: UITextView!
    
    // MARK: - Properties
    var movie: Movie?
    
    // MARK: - Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieFormViewController = segue.destination as? MovieFormViewController {
            movieFormViewController.movie = movie
        }
            
    }
    
    // MARK: - IBActions
    @IBAction func play(_ sender: UIButton) {
        print("Vídeo em reprodução")
    }
    
    // MARK: - Methods
    private func setupUI() {
        if let movie = movie {
            labelTitle.text = movie.title
            labelDuration.text = movie.duration
            labelRating.text = movie.ratingFormatted
            textViewSummary.text = movie.summary
            if let image = movie.image {
                imageViewPoster.image = UIImage(data: image)
            }
            if let categories = movie.categories as? Set<Category> {
                labelCategories.text = categories.compactMap({ $0.name })
                    .sorted()
                    .joined(separator: " | ")
            }
            
        }
    }
    
}

