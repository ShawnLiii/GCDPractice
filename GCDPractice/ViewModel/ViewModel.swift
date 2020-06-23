//
//  ViewModel.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/22/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit

class ViewModel
{
    
    func getImage(url: String, handler: @escaping (UIImage?) -> ())
    {
        
        Service.shared.fetchData(url: url)
        { (data) in
            guard let imageData = data else {return}
            
            if let image = UIImage(data: imageData)
            {
                
                handler(image)
                
            }
            else
            {
                handler(nil)
            }
        }
        
    }
}
