//
//  HeroDao.swift
//  SuperHeroApp
//
//  Created by user247205 on 11/9/23.
//

import Foundation
import UIKit
import CoreData

typealias HeroEntities = [HeroEntity]

protocol HeroDaoProtocol {
    func insert(id: String, name: String)
    func delete(id: String)
    func getAll() -> HeroEntities
    func isFavorite(id: String) -> Bool
    
}

class HeroDao: HeroDaoProtocol {
    func insert(id: String, name: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let heroEntity = HeroEntity(context: context)
        heroEntity.id = id
        heroEntity.name = name
        
        do {
            try context.save()
        } catch (let error) {
            print("Error: \(error)")
        }
        
    }
    
    func delete(id: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let request: NSFetchRequest<HeroEntity>
        request = HeroEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        var heroEntities: HeroEntities
        
        do {
            heroEntities = try context.fetch(request)
            for heroEntity in heroEntities {
                context.delete(heroEntity)
            }
            try context.save()
            
        } catch (let error) {
            print("Error: \(error)")
        }
        
    }
    
    func getAll() -> HeroEntities {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest<HeroEntity>
        request = HeroEntity.fetchRequest()
        
        var heroEntities = HeroEntities()
        
        do {
            heroEntities = try context.fetch(request)
            
        } catch (let error) {
            print("Error: \(error)")
        }
        return heroEntities

    }
    
    func isFavorite(id: String) -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let request: NSFetchRequest<HeroEntity>
        request = HeroEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        var heroEntities: HeroEntities
        
        do {
            heroEntities = try context.fetch(request)
        } catch (let error) {
            print("Error: \(error)")
            return false
        }
        
        return !heroEntities.isEmpty
        
    }
    
    
}
