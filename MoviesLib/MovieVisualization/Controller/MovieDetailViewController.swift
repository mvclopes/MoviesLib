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
    
    // MARK: - IBActions
    @IBAction func play(_ sender: UIButton) {
        print("Vídeo em reprodução")
    }
    
    // MARK: - Methods
    private func setupUI() {
        if let movie = movie {
            labelTitle.text = movie.title
            labelCategories.text = movie.categories
            labelDuration.text = movie.duration
            labelRating.text = "\(movie.rating)"
            textViewSummary.text = movie.summary
            imageViewPoster.image = UIImage(named: movie.image)
        }
    }
    
}

