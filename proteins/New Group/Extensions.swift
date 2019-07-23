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

// StackOverFlow needs refactoring

extension SCNVector3 {
    
    static func lineEulerAngles(vector: SCNVector3) -> SCNVector3 {
        // let height = sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z)
        //let lxz = sqrtf(vector.x * vector.x + vector.z * vector.z)
        
        let pitchB = vector.y < 0 ? Float.pi - asinf(sqrtf(vector.x * vector.x + vector.z * vector.z)/sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z)) : asinf(sqrtf(vector.x * vector.x + vector.z * vector.z)/sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z))
        let pitch = vector.z == 0 ? pitchB : sign(vector.z) * pitchB
        
        var yaw: Float = 0
        if vector.x != 0 || vector.z != 0 {
            let inner = vector.x / (sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z) * sinf(pitch))
            if inner > 1 || inner < -1 {
                yaw = Float.pi / 2
            } else {
                yaw = asinf(inner)
            }
        }
        return SCNVector3(CGFloat(pitch), CGFloat(yaw), 0)
    }
    
    /*
    static func lineEulerAngles(vector: SCNVector3) -> SCNVector3 {
        let height = vector.length()
        let lxz = sqrtf(vector.x * vector.x + vector.z * vector.z)
        let pitchB = vector.y < 0 ? Float.pi - asinf(lxz/height) : asinf(lxz/height)
        let pitch = vector.z == 0 ? pitchB : sign(vector.z) * pitchB
        
        var yaw: Float = 0
        if vector.x != 0 || vector.z != 0 {
            let inner = vector.x / (height * sinf(pitch))
            if inner > 1 || inner < -1 {
                yaw = Float.pi / 2
            } else {
                yaw = asinf(inner)
            }
        }
        return SCNVector3(CGFloat(pitch), CGFloat(yaw), 0)
    }
    
    func length() -> Float {
        return sqrtf(x*x + y*y + z*z)
    }
    */
}

//extension SCNVector3 {
//    static func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
//        return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
//    }
//    
//    func length() -> Float {
//        return sqrtf(x*x + y*y + z*z)
//    }
//
//    
//}

//    func line(startPoint: SCNVector3, endPoint: SCNVector3, color : UIColor) -> SCNNode
//    {
//        let vertices: [SCNVector3] = [startPoint, endPoint]
//        let data = NSData(bytes: vertices, length: MemoryLayout<SCNVector3>.size * vertices.count) as Data
//
//        let vertexSource = SCNGeometrySource(data: data,
//                                             semantic: .vertex,
//                                             vectorCount: vertices.count,
//                                             usesFloatComponents: true,
//                                             componentsPerVector: 3,
//                                             bytesPerComponent: MemoryLayout<Float>.size,
//                                             dataOffset: 0,
//                                             dataStride: MemoryLayout<SCNVector3>.stride)
//
//
//        let indices: [Int32] = [ 0, 1]
//
//        let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count) as Data
//
//        let element = SCNGeometryElement(data: indexData,
//                                         primitiveType: .line,
//                                         primitiveCount: indices.count/2,
//                                         bytesPerIndex: MemoryLayout<Int32>.size)
//
//        let line = SCNGeometry(sources: [vertexSource], elements: [element])
//
//        line.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant
//        line.firstMaterial?.diffuse.contents = color
//
//       let lineNode = SCNNode(geometry: line)
////        let line = SCNCylinder(
//        return lineNode;
//    }
