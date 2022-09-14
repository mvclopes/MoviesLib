//
//  ViewController.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 30/08/22.
//

import UIKit
import AVKit

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
    var trailer: String = ""
    private lazy var moviePlayerController = AVPlayerViewController()
    private var player: AVPlayer?
    
    // MARK: - Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        trailer = ""
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieFormViewController = segue.destination as? MovieFormViewController {
            movieFormViewController.movie = movie
        }
            
    }
    
    // MARK: - IBActions
    @IBAction func play(_ sender: UIButton) {
        if trailer.isEmpty != true {
            present(moviePlayerController, animated: true) {
                self.player?.play()
            }
        }
        
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
            if let title = movie.title {
                loadTrailer(with: title)
            }
            
        }
    }
    
    private func loadTrailer(with title: String) {
        let itunesPath = "https://itunes.apple.com/search?media=movie&entity=movie&term="
        
        guard let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "\(itunesPath)\(encodedTitle)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let apiResult = try! JSONDecoder().decode(ItunesResult.self, from: data)
            self.trailer = apiResult.results.first?.previewUrl ?? ""
            self.prepareVideo()
        }.resume()
    }
    
    private func prepareVideo() {
        guard let url = URL(string: trailer) else { return }
        player = AVPlayer(url: url)
        DispatchQueue.main.async {
            self.moviePlayerController.player = self.player
        }
    }
    
}

