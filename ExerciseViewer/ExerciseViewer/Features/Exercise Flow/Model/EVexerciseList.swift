//
//  EVexerciseList.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import Foundation
import UIKit

struct EVexerciseList: Decodable{
    let results : [Results]
}

struct Results : Decodable{
    let name : String?
    let exercise_base : Int?
}

