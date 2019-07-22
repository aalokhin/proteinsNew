//
//  Extensions.swift
//  proteins
//
//  Created by Anastasiia ALOKHINA on 7/21/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation

extension String {
    func toFloat() -> Float {
        
        return (self as NSString).floatValue
    }
    
    func toSingleSpaceLine () ->String {
       return self.components(separatedBy: " ").filter { !$0.isEmpty }.joined(separator: " ")
    }
}
