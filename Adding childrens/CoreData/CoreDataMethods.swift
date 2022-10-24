//
//  CoreDataMethods.swift
//  Adding childrens
//
//  Created by Антон on 24.10.2022.
//

import Foundation
import UIKit
import CoreData

final class CoreDataMethods {
	internal var coreDataModel: [Child] = []
	static let shared = CoreDataMethods()
	
	func saveChild(name: String, age: Int) {
		guard coreDataModel.count < 6 else { return }
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		guard let entity = NSEntityDescription.entity(forEntityName: "Child", in: context) else {return}
		let model = Child(entity: entity, insertInto: context)
		model.name = name
		model.age = Int16(age)
		do{
			try context.save()
			coreDataModel.append(model)
			NotificationCenter.default.post(name: Notification.Name("TableViewReloadData"), object: .none)
		} catch let error as NSError {
			print(error.localizedDescription)
		}
	}
	
	func fetchRequest() {
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		let fetchRequest: NSFetchRequest<Child> = Child.fetchRequest()
		do {
			coreDataModel = try context.fetch(fetchRequest)
		} catch let error as NSError {
			print(error.localizedDescription)
		}
	}
	
	func deleteCell(tag: Int) {
		let child = coreDataModel[tag]
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		context.delete(child as NSManagedObject)
		let _ : NSError! = nil
		do {
			try context.save()
			NotificationCenter.default.post(name: Notification.Name("TableViewReloadData"), object: .none)
		} catch {
			print("error : \(error)")
		}
	}
	
	func deleteAll() {
		let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
		for i in coreDataModel {
			context.delete(i)
		}
		let _ : NSError! = nil
		do {
			try context.save()
			NotificationCenter.default.post(name: Notification.Name("TableViewReloadData"), object: .none)
		} catch {
			print("error : \(error)")
		}
	}
}
