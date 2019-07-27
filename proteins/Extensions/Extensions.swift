//
//  Extensions.swift
//  proteins
//
//  Created by Anastasiia ALOKHINA on 7/21/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import SceneKit

extension String {
    func toFloat() -> Float {
        
        return (self as NSString).floatValue
    }
    
    func toSingleSpaceLine () ->String {
       return self.components(separatedBy: " ").filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    func toInt() -> Int {
        return Int((self as NSString).intValue)
    }
    
    func toDouble() -> Double {
        return (self as NSString).doubleValue
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
}
extension ListProteinsVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIViewController {
    func callErrorWithCustomMessage(_ message : String) {
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertController.Style.alert
        );
        let action = UIAlertAction(title: "allright, thank you", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        print("herererererer")
        return .lightContent
    }
}

extension SCNVector3 {
    var length : Float {
        return sqrtf(x*x + y*y + z*z)
    }

}
