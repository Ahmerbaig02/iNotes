//
//  Model.swift
//  iNotes
//
//  Created by Mahnoor Fatima on 01/03/2018.
//  Copyright © 2018 Mahnoor Fatima. All rights reserved.
//

import UIKit

class NoteModel {
    
    var Title:String!
    var Description:String!
    
    init(data: [String:Any]) {
        Title = data["Title"] as? String ?? ""
        Description = data["Description"] as? String ?? ""
    }
    
    func getDict() -> [String:Any] {
        var dict:[String:Any] = [:]
        dict["Title"] = Title
        dict["Description"] = Description
        return dict
    }
    
}
