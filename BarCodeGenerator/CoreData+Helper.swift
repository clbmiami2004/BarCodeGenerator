//
//  CoreData+Helper.swift
//  BarCodeGenerator
//
//  Created by Christian Lorenzo on 4/20/22.
//

import Foundation
import CoreData
import UIKit


class CoreDataStack {
    
    static let coreDataStack = CoreDataStack()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrQrCodes: [QRCode]?
    
    
    private func creatingContext() {
        
        let qrCodeEntity = NSEntityDescription.insertNewObject(forEntityName: "QRCode", into: context) as! QRCode
    }
    
    func saveImage() {
        creatingContext()
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadQrCodes() {
        let request: NSFetchRequest<QRCode> = QRCode.fetchRequest()
        
        do {
            arrQrCodes = try context.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
