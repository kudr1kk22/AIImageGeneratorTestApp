//
//  ImageCoreDataModel+CoreDataProperties.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 3.05.23.
//
//

import Foundation
import CoreData


extension ImageCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCoreDataModel> {
        return NSFetchRequest<ImageCoreDataModel>(entityName: "ImageCoreDataModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var imagePath: String?

}
