//
//  Helper.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import Foundation
import UIKit


public func consolePrint (_ object: Any...){
    #if DEBUG
    for item in object {
        Swift.print(item)
    }
    #endif
}
public func consolePrint (_ object: Any){
    #if DEBUG
    Swift.print(object)
    #endif
}


struct Helper {
    static func showAlert(msg: String?, title: String? = "Alert") {
        let alert = UIAlertController(title: title, message: msg ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        var mwindow: UIWindow?
        mwindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        
        guard let parentVC = mwindow?.visibleViewController() else {return}
        parentVC.present(alert, animated: true, completion: nil)
    }
}
