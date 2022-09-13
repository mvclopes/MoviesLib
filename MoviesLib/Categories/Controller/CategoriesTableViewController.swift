//
//  CategoriesTableViewController.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 08/09/22.
//

import UIKit
import CoreData

protocol CategoriesDelegate: AnyObject {
    func setSelectedCategories(_ categories: Set<Category>)
}

class CategoriesTableViewController: UITableViewController {

    var categories: [Category] = []
    var selectedCategories: Set<Category> = [] {
        didSet {
            delegate?.setSelectedCategories(selectedCategories)
        }
    }

    weak var delegate: CategoriesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    private func loadCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            categories = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    private func showCategoryAlert(for category: Category? = nil) {
        let title = category == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Nome da categoria"
            textField.text = category?.name
        }
        
        let okAction = UIAlertAction(title: title, style: .default) { _ in
            let category = category ?? Category(context: self.context)
            category.name = alert.textFields?.first?.text
            try? self.context.save()
            self.loadCategories()
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        showCategoryAlert()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        cell.accessoryType = selectedCategories.contains(category) ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            let category = self.categories[indexPath.row]
            self.showCategoryAlert(for: category)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { action, view, completionHandler in
            let category = self.categories[indexPath.row]
            
            self.context.delete(category)
            try? self.context.save()
            self.categories.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.selectedCategories.remove(category)
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = .checkmark
            selectedCategories.insert(category)
        } else {
            cell?.accessoryType = .none
            selectedCategories.remove(category)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
