//
//  HomeViewController.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/28/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var requests: [PFObject]?
    var loadingView: InfiniteScroll?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 320
        tableView.reloadData()
        
        doQuery()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func doQuery() {
        // construct PFQuery
        let query = PFQuery(className: "Request")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.requests = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let requests = requests {
            return requests.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RequestCell", forIndexPath: indexPath) as! RequestCell
        cell.request = requests![indexPath.row]
        
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        doQuery()
        
        // Hide the RefreshControl
        refreshControl.endRefreshing()
    }
    
    //Infinite Scroll
    
    class InfiniteScroll: UIView {
        var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        static let defaultHeight:CGFloat = 50.0
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupActivityIndicator()
        }
        
        override init(frame aRect: CGRect) {
            super.init(frame: aRect)
            setupActivityIndicator()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        }
        
        func setupActivityIndicator() {
            activityIndicatorView.activityIndicatorViewStyle = .Gray
            activityIndicatorView.hidesWhenStopped = true
            self.addSubview(activityIndicatorView)
        }
        
        func stopAnimating() {
            self.activityIndicatorView.stopAnimating()
            self.hidden = true
        }
        
        func startAnimating() {
            self.hidden = false
            self.activityIndicatorView.startAnimating()
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
