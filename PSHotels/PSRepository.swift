    //
//  Repository.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/18/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import Alamofire

class PSRepository<PSObject> {
    
    func parseJson<PSObject>(response : DataResponse<Any>, dataType : PSObject.Type) -> Resourse<PSObject> where PSObject: Decodable{
        
        print("\n\nResponse >>>>> \(String(describing: response))")
        print("<<<<")
        var resourse : Resourse<PSObject>
        
        do {
            if(response.response?.statusCode == 404) {
                let apiStatus = try JSONDecoder().decode(ApiStatus.self, from: response.data!)
                print(apiStatus)
                
                resourse = Resourse(status: Status.ERROR, message: apiStatus.message)
                
            }else {
                
                let result = try JSONDecoder().decode(dataType, from: response.data!)
                
                resourse = Resourse(status: Status.SUCCESS, message: "", data: result)
                
            }
        } catch let error {
            
            print(error)
            
            if response.response == nil {
                resourse = Resourse(status: Status.NETWORK_ERROR, message: "Something wrong with internet. Please try again. ")
            }else {
                resourse = Resourse(status: Status.ERROR, message: "Error in parsing data. ")
            }
        }
        
        return resourse
    }
    
}
