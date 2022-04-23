//
//  Helper.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import Foundation


public func print (_ object: Any...){
    #if DEBUG
    for item in object {
        Swift.print(item)
    }
    #endif
}
public func print (_ object: Any){
    #if DEBUG
    Swift.print(object)
    #endif
}
