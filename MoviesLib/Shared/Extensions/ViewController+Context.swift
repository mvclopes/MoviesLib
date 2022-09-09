//
//  ViewController+Context.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 08/09/22.
//

import Foundation
import CoreData
import UIKit

extension UIViewController {
    // Contexto da Aplicação
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
