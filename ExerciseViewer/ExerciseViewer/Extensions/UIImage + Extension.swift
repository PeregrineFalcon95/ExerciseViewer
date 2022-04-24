//
//  UIImage + Extension.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/24/22.
//

import Foundation
import UIKit

extension UIImage {
    var hasAlpha: Bool {
        guard let alphaInfo = self.cgImage?.alphaInfo else {return false}
        return alphaInfo != CGImageAlphaInfo.none &&
            alphaInfo != CGImageAlphaInfo.noneSkipFirst &&
            alphaInfo != CGImageAlphaInfo.noneSkipLast
    }
}
