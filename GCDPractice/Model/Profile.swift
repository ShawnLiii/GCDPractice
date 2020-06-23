//
//  Profile.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/19/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import Foundation

// Coding Key - firstName, lastName
struct Profile: Decodable
{
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String
}

struct ProfileData: Decodable
{
    var data: [Profile]
}
