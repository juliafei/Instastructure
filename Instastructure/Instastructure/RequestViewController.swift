//
//  RequestViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/30/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import IQDropDownTextField

class RequestViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var categoryField: IQDropDownTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.layer.borderWidth = 1
        categoryField.itemList = ["Elevators and Escalators","Plumbing","Lighting", "Outlets","Streets and Sidewalks","Staff","HVAC","Cafeteria","Other"]
        categoryField.isOptionalDropDown = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            if editedImage.imageAsset != nil {
                issueImageView.image = editedImage
            } else {
                issueImageView.image = originalImage
            }
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onImageTap(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        Request.submitRequest(issueImageView.image, withTitle: titleField.text, withDescription: descriptionTextView.text, withCategory: categoryField.selectedItem, withTimestamp: timestamp) { (success: Bool, error: NSError?) -> Void in
            self.titleField.text = nil
            self.descriptionTextView.text = nil
            self.issueImageView.image = nil
            self.tabBarController?.selectedIndex = 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
