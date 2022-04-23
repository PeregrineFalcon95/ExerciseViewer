//
//  Window.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import UIKit

extension UIWindow {
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController  = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
        }
        return nil
    }
    class func getVisibleViewControllerFrom(_ vc:UIViewController) -> UIViewController {
        
        var nextOnStackViewController: UIViewController? = nil
        if let presented = vc.presentedViewController {
            nextOnStackViewController = presented
        } else if let navigationController = vc as? UINavigationController,
            let visible = navigationController.visibleViewController {
            nextOnStackViewController = visible
        } else if let tabBarController = vc as? UITabBarController,
            let visible = (tabBarController.selectedViewController ??
                tabBarController.presentedViewController) {
            nextOnStackViewController = visible
        }
        
        if let nextOnStackViewController = nextOnStackViewController {
            return getVisibleViewControllerFrom(nextOnStackViewController)
        } else {
            return vc
        }
    }
}
