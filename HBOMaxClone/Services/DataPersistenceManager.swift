//
//  DataPersistenceManager.swift
//  HBOMaxClone
//
//  Created by Mac on 17.10.2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    func downloadContentWith(model: MovieResult, completion: @escaping(Result<Void,Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = ContentItem(context: context)
        
        item.name = model.name
        item.id = Int64(model.id!)
        item.overview = model.overview
        item.vote_average = model.voteAverage!
        item.vote_count = Int64(model.voteCount!)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchingSavedContentsFromDatabase(completion: @escaping(Result<[ContentItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = ContentItem(context: context)
        
        let request: NSFetchRequest<ContentItem>
        
        request = ContentItem.fetchRequest()
        
        do {
           let contents = try context.fetch(request)
            completion(.success(contents))
        } catch {
            print(error.localizedDescription)
        }
    }
}
