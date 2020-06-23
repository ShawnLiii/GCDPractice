//
//  Service.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/19/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import Foundation

class Service
{
    static var `shared` = Service()
    private init(){}
    
    func fetchData(url: String, handler: @escaping (Data?)->())
    {
        guard let userUrl = URL(string: url) else {return}
        
        do
        {
            let data = try Data(contentsOf: userUrl)
            handler(data)
        }
        catch
        {
            print(error.localizedDescription)
            handler(nil)
        }
       
    }
    
}
