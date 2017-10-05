//
//  YoutubeVC.swift
//  TextMaxx Pro
//
//  Created by surender on 18/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit
import YouTubePlayer
import SDWebImage

class YoutubeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableview_Youtube: UITableView!
    @IBOutlet var playerView: YouTubePlayerView!
    
    var channelsDataArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMenuBarButtonItems()
         tableview_Youtube.tableFooterView = UIView()
        getYoutubeVideoList()
       
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Menu Items
    
    func setupMenuBarButtonItems () {
        self.navigationItem.leftBarButtonItem = self.leftMenuBarButtonItem()
    }
    
    func leftMenuBarButtonItem () -> UIBarButtonItem {
        let leftMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "left-icon"), style: .plain, target: self, action: #selector(SocialVC.btnLeftMenuClicked))
        
        leftMenu.tintColor = UIColor.white
        return leftMenu
    }
    
    func btnLeftMenuClicked() {
        self.navigationController?.popViewController(animated: true)
    }

    
    // get channel list
    func getYoutubeVideoList()
    {
       // AIzaSyBmYkJZwxr3_P6vwd6hrCUP6IARyFmqp5E
        
        CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)

        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDYrOevuonrREFWYTWJGLl9qW78p-nqc0M&channelId=UCJVyXztIap_igWjLa8B5-sw&part=snippet&order=date&maxResults=5")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
               // print(error!.localizedDescription)
                
            } else {
                
                if data != nil {
                    do {
                        // Json parsing

                        let json : NSDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        self.channelsDataArray = ((json.value(forKey: "items") as? NSArray)! .mutableCopy() as! NSMutableArray)
                        
                        DispatchQueue.main.async {
                        
                            self.playerView.loadVideoID("fcVrk7nY8j0")
                            self.playerView.play()
                            
                            CommonFunctions.sharedCommonFunctions.activateView(self.view)
                            self.tableview_Youtube.reloadData()
                            self.tableview_Youtube.delegate = self
                            self.tableview_Youtube.dataSource = self

                            }

                                           } catch {//Error in parsing
                        CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                        
//                        DispatchQueue.main.async {
//                        }
                    }
                }

                
                
            }
            
        })
        task.resume()
    }
    
    
    //*************** TableView Delegate & Datasource ******************//
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //*************** TableView Delegate & Datasource ******************//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return channelsDataArray.count-1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath as IndexPath) as! youtubeListCell
        
        
       let url = ((channelsDataArray[indexPath.row] as? NSDictionary)?.value(forKeyPath: "snippet.thumbnails.default.url")  as? String)!
       // print(url)
        
        let imgurl = URL(string: ((channelsDataArray[indexPath.row] as? NSDictionary)?.value(forKeyPath: "snippet.thumbnails.default.url")  as? String)!)
        
          tableCell.img_thumbnail.sd_setImage(with: imgurl as URL!)
        
        
//        tableCell.img_thumbnail.image = UIImage(data: NSData(contentsOf: NSURL(string: ((channelsDataArray[indexPath.row] as? NSDictionary)?.value(forKeyPath: "snippet.thumbnails.default.url")  as? String)!)! as URL)! as Data)
        tableCell.img_thumbnail.layer.cornerRadius =  30
        tableCell.img_thumbnail.clipsToBounds = true

        
        tableCell.lbl_title.text = ((channelsDataArray[indexPath.row] as? NSDictionary)?.value(forKeyPath: "snippet.title")  as? String)!
        
//        tableCell.lbl_Name.text = arr_Home[indexPath.row]
//        
//        
//        tableCell.lbl_Name.text = (arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String
//        
//        tableCell.lbl_Message.text = (arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "message") as? String
//        
//        tableCell.lbl_Count.text = (arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "count") as? String
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        
//        let dateA = dateFormatter.date(from: ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "sent") as? String)!)
//        
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateFormat = "HH:mm"
//        let strA = dateFormatter1.string(from: dateA!)
//        
//        
//        tableCell.lbl_Time.text = strA
//        
//        
//        tableCell.btn_Info.addTarget(self, action: #selector(HomeVC.btnInfoAction(sender:)), for: UIControlEvents.touchUpInside)
//        
//        tableCell.btn_Info.tag = indexPath.row
        
        
        
        if indexPath.row % 2 == 0
        {
            tableCell.backgroundColor = UIColor.init(colorLiteralRed: 238/255, green: 246/255, blue: 254/255, alpha: 1)
        }
        else{
            tableCell.backgroundColor = UIColor.white
        }
        
        //        tableCell.btn_Info.addTarget(self, action: #selector(ContactsVC.acn_Infobtn), for: .touchUpInside)
        //        tableCell.btn_Info.layer .setValue(indexPath.row, forKey: "IndexValue")
        return tableCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let videoID = ((channelsDataArray[indexPath.row] as? NSDictionary)?.value(forKeyPath: "id.videoId")  as? String)!
        
        playerView.loadVideoID(videoID)
        playerView.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
