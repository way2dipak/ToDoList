//
//  DBManager.swift
//  Laas
//
//  Created by admin on 2/19/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class DBManager: NSObject {

    static let shared = DBManager()
    
    private override init() {}
    
    private var database: Connection!
    private var productTable = Table("product")
    private let pId = Expression<Int>("pId")
    private let productName = Expression<String>("productName")
    private let isPending = Expression<Bool>("isPending")
    
    private var categoryTable = Table("category")
    private let cId = Expression<Int>("cId")
    private let categoryName = Expression<String>("categoryName")
    
    
    
    
    
    //MARK: CREATE DB
    func createDB()-> Bool {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("productDB").appendingPathExtension("sqlite3")
            print("DBPath: \(fileUrl.path)")
            let database = try Connection(fileUrl.path)
            self.database = database
            
            return true
        }
        catch {
            print("DBError: \(error)")
            return false
        }
    }
    
    //MARK: CREATE PRODUCT TABLE
    func createProductTable()-> Bool {
        let createTable = self.productTable.create { (table) in
            table.column(self.pId, primaryKey: true)
            table.column(self.cId)
            table.column(self.productName)
            table.column(self.isPending)
        }
        do {
            try self.database.run(createTable)
            print("Table Created 🕺🏼")
            return true
        }
        catch {
            print("error in creat table: \(error) 😩")
            return false
        }
    }
    
    //MARK: SAVE OR INSERT TO TABLE
    func saveToProductTable(productName: String, cid: Int, isPending: Bool)-> Bool {
        let insertRecords = self.productTable.insert(self.productName <- productName, self.cId <- cid, self.isPending <- isPending)
        do {
            try self.database.run(insertRecords)
            print("Insert Successfully")
            return true
        }
        catch {
            print("Error in inserting Record: \(error)")
            return false
        }
    }
    
    
    
    //MARK: UPDATE TABLE
    func updateProductTable(pId: Int, productName: String)-> Bool {
        let product = self.productTable.filter(self.pId == pId)
        let updateProductTable = product.update(self.productName <- productName)
        do {
            try self.database.run(updateProductTable)
            print("Records Updated")
            return true
        }
        catch {
            print("error while updating local table: \(error)")
            return false
        }
    }
    
    //MARK: UPDATE PENDING STATUS FOR PRODUCT TABLE
    func updatePendingStatusInProductTable(pId: Int, isPending: Bool)-> Bool {
        let product = self.productTable.filter(self.pId == pId)
        let updateProductTable = product.update(self.isPending <- isPending)
        do {
            try self.database.run(updateProductTable)
            print("Records Updated")
            return true
        }
        catch {
            print("error while updating local table: \(error)")
            return false
        }
    }
    
    //MARK: FETCH ALL RECORDS FROM PRODUCT DB
    func fetchDetailsFromProductTable() -> [Product] {
        var array: [Product] = []
        do {
            let retriveTableRecords = try self.database.prepare(self.productTable)
            for records in retriveTableRecords {
                let pId = records[self.pId]
                let cId = records[self.cId]
                let productName = records[self.productName]
                let isPending = records[self.isPending]

                let detail = Product(id: pId, cId: cId, itemName: productName, isPending: isPending)
                array.append(detail)
            }
        }
        catch {
            print("Failed on Retrive: \(error)")
        }
        return array
    }
    
    //MARK: FILTER AND FETCH ALL RECORDS FROM LOCAL DB
//    func filterDetailsFromDB(customerId: String, applicationType: String) -> [PropertyModel] {
//        var array: [PropertyModel] = []
//        do {
//            let filterData = userTable.filter(self.cid == customerId && self.applicationType == applicationType)
//            let retriveTableRecords = try self.database.prepare(filterData)
//            for records in retriveTableRecords {
//                let uid = records[self.uid]
//                let cid = records[self.cid]
//                let applicantID = records[self.aid]
//                let image = records[self.customerPropertyimage]
//                let timeStamp = records[self.time]
//                let latitude = records[self.latitude]
//                let longitude = records[self.longitude]
//                let isuploadPending = records[self.isUplaodPending]
//                let propertyImage = records[self.propertyImage]
//                let applicationType = records[self.applicationType]
//                let imageDescription = records[self.imageDescription]
//
//                let detail = PropertyModel(uid: uid, cid: cid, applicantId: applicantID, image: image, timeStamp: timeStamp, latitude: latitude, longitude: longitude, isUploadPending: isuploadPending, propertyImage: propertyImage, applicationType: applicationType, description: imageDescription)
//                array.append(detail)
//            }
//        }
//        catch {
//            print("Failed on Retrive: \(error)")
//        }
//        return array
//    }
    
    //MARK: DELETE RECORDS FROM PRODUCT
    func DeleteRecordsFromProductTable(pId: Int)-> Bool {
        let product = self.productTable.filter(self.pId == pId)
        let deleteProduct = product.delete()
        do {
            try self.database.run(deleteProduct)
            return true
        }
        catch {
            print("Failed to Delete Product: \(error)")
            return false
        }
    }
    
    //MARK: DELETE RECORDS FROM PRODUCT TABLE FROM CID
    func DeleteRecordsFromProductTableFrom(cId: Int)-> Bool {
        let product = self.productTable.filter(self.cId == cId)
        let categoryProduct = product.delete()
        do {
            try self.database.run(categoryProduct)
            return true
        }
        catch {
            print("Failed to Delete Product: \(error)")
            return false
        }
    }

    
    ///FOR CATEGORY
    //MARK: CREATE CATEGORY TABLE
    func createCategoryTable()-> Bool {
        let createCategoryTable = self.categoryTable.create { (table) in
            table.column(self.cId, primaryKey: true)
            table.column(self.categoryName)
        }
        do {
            try self.database.run(createCategoryTable)
            print("Table Created 🕺🏼")
            return true
        }
        catch {
            print("error in creat table: \(error) 😩")
            return false
        }
    }
    
    //MARK: SAVE OR INSERT TO CATEGORy TABLE
    func saveToCategoryTable(categoryName: String)-> Bool {
        let insertRecords = self.categoryTable.insert(self.categoryName <- categoryName)
        do {
            try self.database.run(insertRecords)
            print("Insert Successfully")
            return true
        }
        catch {
            print("Error in inserting Record: \(error)")
            return false
        }
    }
    
    
    //MARK: FETCH ALL RECORDS FROM CATEGORY TABLE
    func fetchDetailsFromCategory() -> [Category] {
        var array: [Category] = []
        do {
            let retriveTableRecords = try self.database.prepare(self.categoryTable)
            for records in retriveTableRecords {
                let cId = records[self.cId]
                let categoryName = records[self.categoryName]
                
                let detail = Category(id: cId, itemName: categoryName)
                array.append(detail)
            }
        }
        catch {
            print("Failed on Retrive: \(error)")
        }
        return array
    }
    
    //MARK: FILTER AND FETCH ALL RECORDS FROM LOCAL DB
    //    func filterDetailsFromDB(customerId: String, applicationType: String) -> [PropertyModel] {
    //        var array: [PropertyModel] = []
    //        do {
    //            let filterData = userTable.filter(self.cid == customerId && self.applicationType == applicationType)
    //            let retriveTableRecords = try self.database.prepare(filterData)
    //            for records in retriveTableRecords {
    //                let uid = records[self.uid]
    //                let cid = records[self.cid]
    //                let applicantID = records[self.aid]
    //                let image = records[self.customerPropertyimage]
    //                let timeStamp = records[self.time]
    //                let latitude = records[self.latitude]
    //                let longitude = records[self.longitude]
    //                let isuploadPending = records[self.isUplaodPending]
    //                let propertyImage = records[self.propertyImage]
    //                let applicationType = records[self.applicationType]
    //                let imageDescription = records[self.imageDescription]
    //
    //                let detail = PropertyModel(uid: uid, cid: cid, applicantId: applicantID, image: image, timeStamp: timeStamp, latitude: latitude, longitude: longitude, isUploadPending: isuploadPending, propertyImage: propertyImage, applicationType: applicationType, description: imageDescription)
    //                array.append(detail)
    //            }
    //        }
    //        catch {
    //            print("Failed on Retrive: \(error)")
    //        }
    //        return array
    //    }
    
    //MARK: DELETE RECORDS FROM CATEGORY TABLE
    func DeleteRecordsFromCategoryTable(cId: Int)-> Bool {
        let category = self.categoryTable.filter(self.cId == cId)
        let categoryProduct = category.delete()
        do {
            try self.database.run(categoryProduct)
            return true
        }
        catch {
            print("Failed to Delete Product: \(error)")
            return false
        }
    }
    
    
    
    
    
    
}
