//
//  CaptureViewController.swift
//  Insta
//
//  Created by Langtian Qin on 2/27/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var instaTable: UITableView!
    var instas=[Post]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(instas.count)
        return instas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("6")
        let thisInsta=instas[indexPath.row]
        
        let cell=instaTable.dequeueReusableCell(withIdentifier: "InstaCell") as? SomeCell
        cell?.captionLabel.text=thisInsta.caption
        cell?.captionLabel.isHidden=true;
        cell?.authorLabel.text=thisInsta.author.username
        cell?.authorLabel.isHidden=true;
        thisInsta.media.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
            let image = UIImage(data: imageData!)
            if image != nil {
                let newImage=self.resizeImage(image: image!, targetSize: CGSize(width:375.0, height:128.0))
                cell?.weView.image=newImage
            }
        })
        //cell?.imageImageView.image=thisInsta.media
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=instaTable.cellForRow(at: indexPath)as?SomeCell
        cell?.authorLabel.isHidden=false;
        cell?.captionLabel.isHidden=false;
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell=instaTable.cellForRow(at: indexPath)as?SomeCell
        cell?.authorLabel.isHidden=true;
        cell?.captionLabel.isHidden=true;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        instaTable.dataSource=self
        instaTable.delegate=self
        start()
        instaTable.reloadData()
        instaTable.rowHeight=UITableViewAutomaticDimension
        let refreshController=UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        instaTable.insertSubview(refreshController, at: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start(){
        print("1")
        let query=Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            print("2")
            if let posts = posts {
                var i=0
                print("3")
                for post in posts{
                    print("4")
                    let postr=post as! Post
                    if self.instas.count<=i{
                        self.instas.append(postr)
                        print(self.instas.count)
                    }
                    self.instas.insert(postr,at:i)
                    i=i+1
                    self.instaTable.reloadData()
                }
            } else {
                print("Some error happened")
            }
        }
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        start()
        refreshControl.endRefreshing()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
