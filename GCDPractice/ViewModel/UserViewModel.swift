//
//  UserViewModel.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/19/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit

class UserViewModel
{
    
     var profiles = [Profile]()
    
//    var profilesContainer: [Profile]
//    {
//        get
//        {
//            DispatchQueue.global().sync {
//                return profiles
//            }
//        }
//        set
//        {
//            DispatchQueue.global().async(flags: .barrier) {
//                self.profiles = newValue
//            }
//        }
//    }
    
    let dispatchGroup = DispatchGroup()
    
    let url1 = "https://reqres.in/api/users?page=1"
    let url2 = "https://reqres.in/api/users?page=2"
    let url3 = "https://reqres.in/api/users?page=3"
    
    var updateClosure: ()->() = {}
    
    init()
    {
        excuteGroupQueueToFetchData()
    }
    
    func getProfileData(url: String)
    {
        DispatchQueue.global().async
            {
                Service.shared.fetchData(url: url)
                { (data) in
                    guard let userData = data else {return}
                    
                    do
                    {
                        self.profiles.append(contentsOf: try JSONDecoder().decode(ProfileData.self, from: userData).data)
                        self.dispatchGroup.leave()
                    }
                    catch
                    {
                        print(error)
                    }
                }
        }
    }
   
    func excuteGroupQueueToFetchData()
    {
        dispatchGroup.enter()
        getProfileData(url: url1)
        
        dispatchGroup.enter()
        getProfileData(url: url2)
        
        dispatchGroup.enter()
        getProfileData(url: url3)
        
//        dispatchGroup.wait()
//        self.updateClosure()
        dispatchGroup.notify(queue: DispatchQueue.main)
        {
            self.updateClosure()
            print("Group excuted")
        }
    }
    
    
    func getImage(url: String, handler: @escaping (UIImage?) -> ())
    {
        DispatchQueue.global().async
            {
                Service.shared.fetchData(url: url)
                { (data) in
                    guard let imageData = data else {return}
                    
                    if let image = UIImage(data: imageData)
                    {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3)
                        {
                            handler(image)
                        }
                    }
                    else
                    {
                        handler(nil)
                    }
                }
        }
    }
    
}
