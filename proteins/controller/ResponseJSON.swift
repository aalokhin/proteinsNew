//
//  ResponseJSON.swift
//  proteins
//
//  Created by Anastasiia ALOKHINA on 7/21/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation

class ResponseJSON : Decodable{
    

    let status_code : Int?
    let date : String?
    
    enum CodingKeys: String, CodingKey {
        case status_code = "Status Code"
        case date = "Date"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.status_code = (try? values.decode(Int.self, forKey: .status_code))
        self.date = (try? values.decode(String.self, forKey: .date))
    }

}

/*    let decoder = JSONDecoder()
 guard let resp = try? decoder.decode(ResponseJSON.self, from: d) else {
 print("error decoding response ")
 self.callErrorWithCustomMessage("Errror decoding response!")
 return
 }
 print(resp.status_code)*/
