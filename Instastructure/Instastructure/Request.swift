//
//  Request.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/30/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class Request: NSObject {
    
    class func submitRequest (image: UIImage?, withTitle title: String?, withDescription description: String?, withCategory category: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        // Create parse object PFObject
        let request = PFObject(className: "Request")
        
        // Add relevant fields to the object
        request["media"] = getPFFileFromImage(image) // PFFile column type
        request["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        request["title"] = title
        request["description"] = description
        request["category"] = category
        request["voteCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        request.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        
        return nil
    }
}
