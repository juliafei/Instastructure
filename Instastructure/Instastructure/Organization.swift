//
//  Organization.swift
//  Instastructure
//
//  Created by Joel Annenberg on 4/13/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class Organization: NSObject {
    
    var email: NSString?
    var username: NSString?
    //var profileUrl: NSURL?
    var organizationId: NSString?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        email = PFUser.currentUser()?.email
        username = PFUser.currentUser()?.username
        organizationId = PFUser.currentUser()!["organizationId"] as? String
        
        /* let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        } */
    
        
    }

}
