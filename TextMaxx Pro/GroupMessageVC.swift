//
//  GroupMessageVC.swift
//  TextMaxx Pro
//
//  Created by surender on 15/05/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit
import Alamofire

class GroupMessageVC: UIViewController,BaseBLDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView_Tags: UITableView!

    @IBOutlet var viewBack_BrodCastMessage: UIView!
    
    var arr_Tags = NSMutableArray()
    
    
    @IBOutlet var txtView_message: UITextView!
    var str_tag = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBack_BrodCastMessage.isHidden = true
        callWbGroupList()
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text.characters.count > 0 {
            textView.text = ""
        }
        else
        {
            textView.text = "Type a message..."
        }
    }


    @IBAction func TappedOnAllActions(_ sender: Any) {
        
        if (sender as AnyObject).tag == 2001
        {
            viewBack_BrodCastMessage.isHidden = true
            txtView_message.resignFirstResponder()
        }
        else{
            
            if txtView_message.text == "Type a message..."
            {
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message: "Please enter message")
            }
            else
            {
                let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
                
                let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
                
                let encodeString = "\(str_clientKey):\(str_token_key)"
              //  print(encodeString)
                
                let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
                
                // "authorization": "\(data)",
                
                
                 CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)
                let headers = [
                     "authorization": "\(data)",
                    "accept": "application/json",
                    "content-type": "application/json",
                    "cache-control": "no-cache",
                  //  "postman-token": "747e89ef-caab-ecb1-113b-d20d5ff985a0"
                ]
                let parameters = [
                    "message": txtView_message.text!,
                    "language": "en",
                    "account": "true",
                    "marketing": "false",
                    "notify": "email@example.com",
                    "tags": str_tag
                    ] as [String : Any]
                
                
                let data1 = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)

                let request = NSMutableURLRequest(url: NSURL(string: "https://api.paymaxxpro.com/sms/broadcast")! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                request.httpBody = data1 as Data
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        print(error ?? "error")
                    } else {
                        do {
                            
                            let json : NSDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            
                      //      print(json)
                           
                          self.txtView_message.resignFirstResponder()
                            
                           DispatchQueue.main.async(){
                                CommonFunctions.sharedCommonFunctions.activateView(self.view)
                                if json.value(forKey: "error") as? String == "User id not permitted to perfom this action."
                                {
                                 CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"User id not permitted to perform this action.")
                                    
                                }
                            else
                                {
                                 CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"message successfully sent")
                                    self.txtView_message.text = "Type a message..."
                                    self.txtView_message.resignFirstResponder()
                                    self.viewBack_BrodCastMessage.isHidden = true
                            }
                            }
                        }
                        catch
                        {
                            // Hide Loading Indicator
                            CommonFunctions.sharedCommonFunctions.activateView(self.view)
                            CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                        }
                    }
                })
                
                dataTask.resume()
            }
        }
    }
    
    // MARK: - Call Wb
    func callWbBroadCastMessage(){
        // Check internet availability
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: internetNotAvailableTitle, message: internetNotAvailableMsg)
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            
            loginBL.BrodCastMessage(self.view, message: txtView_message.text!, account: "true", marketing: "false", notify: "email@example.com", Language: "en", tags:str_tag)
        }
    }
    
    func callWbGroupList()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: internetNotAvailableTitle, message: internetNotAvailableMsg)
         
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.groupList(self.view)
        }
    }
    
    //MARK:- TableView Deleage & DataSources
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_Tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath as IndexPath) as! GroupCell
        
        tableCell.lbl_title.text = ((arr_Tags.object(at: indexPath.row)as! NSDictionary).value(forKey: "tag")as! NSString) as String
        
        if indexPath.row % 2 == 0
        {
            tableCell.backgroundColor = UIColor.init(colorLiteralRed: 238/255, green: 246/255, blue: 254/255, alpha: 1)
        }
        else{
            tableCell.backgroundColor = UIColor.white
        }
        
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        txtView_message.text = "Type a message..."
        str_tag = ((arr_Tags.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "tag") as? String)!
        viewBack_BrodCastMessage.isHidden = false
        
    }

    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        
        self.view .endEditing(true)
        arr_Tags.removeAllObjects()
        if response is NSDictionary {
            if response.value(forKey: "status") as! String == "GroupList"
            {
                arr_Tags = (response.value(forKeyPath: "data.tags") as? NSArray)! .mutableCopy() as! NSMutableArray
                if arr_Tags.count > 0
                {
                    tableView_Tags.reloadData()
                }
            }
        }
    }
    
    func failureResponseReceived (_ response:AnyObject) {
        // Error received in response.
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "", message: "\(response)")
    }
    
    func noDataReceived () {
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "Error!!", message: "Service not working")
            txtView_message.text = "Type a message..."
            txtView_message.resignFirstResponder()
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
