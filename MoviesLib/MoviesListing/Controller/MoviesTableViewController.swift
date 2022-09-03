//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 02/09/22.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let movieViewController = segue.destination as? MovieDetailViewController,
              let row = tableView.indexPathForSelectedRow?.row else { return }
        
        movieViewController.movie = movies[row]
    }
    
    private func loadMovies() {
        guard let jsonUrl = Bundle.main.url(forResource: "movies", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: jsonUrl)
            let jsonDecoder = JSONDecoder()
            // Definindo estratégia de decoding: converter snake case para camel case
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            movies = try jsonDecoder.decode([Movie].self, from: data)
            movies.forEach { print($0.title) }
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

//    Sempre que o número de seções da tableView seja 1, podemos remover este método override
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    // Número de células dentro de uma seção da tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let movie = movies[indexPath.row]
        
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.duration

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
