//
//  ProfileVC.swift
//  TextMaxx Pro
//
//  Created by surender on 11/11/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,BaseBLDelegate,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {

    
    @IBOutlet var profilebackView: UIView!
    @IBOutlet weak var tableview_Information: UITableView!
    var phone = String()
    
    var arr_accountLable = ["Cell Number","Accepts 1-way Msgs", "Accepts 2-way Msgs","Language"]
    var arr_values = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilebackView.isHidden = true
        self.setupMenuBarButtonItems()
        callWbProfile()
        
        // Do any additional setup after loading the view.
    }

    // MARK: - Call Wb
    func callWbProfile()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            arr_values.removeAllObjects()
            let userDetails =  DBFunctions.sharedDBFunctions.fetchProfileData(cell: phone)
            let arrayvalues = NSArray(array: userDetails)
            for i in 0..<userDetails.count
            {
                let dic = NSMutableDictionary()
                
                let accepted_account = userDetails[i].value(forKey: "accepted_account") as? String
                let accepted_market = userDetails[i].value(forKey: "accepted_market") as? String
                let accepts_account = userDetails[i].value(forKey: "accepts_account") as? String
                let accepts_market = userDetails[i].value(forKey: "accepts_market") as? String
                let account_number = userDetails[i].value(forKey: "account_number") as? String
                let account_on_file = userDetails[i].value(forKey: "account_on_file") as? String
                
                let awaiting = userDetails[i].value(forKey: "awaiting") as? String
                let carrier = userDetails[i].value(forKey: "carrier") as? String
                let dob = userDetails[i].value(forKey: "dob") as? String
                let employees = userDetails[i].value(forKey: "employees") as? String
                let error = userDetails[i].value(forKey: "error") as? String
                let ivr = userDetails[i].value(forKey: "ivr") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                let language = userDetails[i].value(forKey: "language") as? String
                let marketed_when = userDetails[i].value(forKey: "marketed_when") as? String
                let pending_account_opt_in = userDetails[i].value(forKey: "pending_account_opt_in") as? String
                let pending_market_opt_in = userDetails[i].value(forKey: "pending_market_opt_in") as? String
                let received = userDetails[i].value(forKey: "received") as? String
                let recently_marketed = userDetails[i].value(forKey: "recently_marketed") as? String
                let sent = userDetails[i].value(forKey: "sent") as? String
                let stopped = userDetails[i].value(forKey: "stopped") as? String
                let tags = userDetails[i].value(forKey: "tags") as? String
                let web = userDetails[i].value(forKey: "web") as? String
                let variables = userDetails[i].value(forKey: "variables") as? NSArray
                let cell = userDetails[i].value(forKey: "cell") as? String

                dic.setValue(accepted_account!, forKey:  "accepted_account")
                dic.setValue(accepted_market!, forKey:  "accepted_market")
                dic.setValue(accepts_account!, forKey:  "accepts_account")
                dic.setValue(accepts_market!, forKey:  "accepts_market")
                dic.setValue(account_number!, forKey:  "account_number")
                dic.setValue(account_on_file!, forKey:  "account_on_file")
                dic.setValue(awaiting!, forKey:  "awaiting")
                dic.setValue(carrier!, forKey:  "carrier")
                dic.setValue(dob!, forKey:  "dob")
                dic.setValue(employees!, forKey:  "employees")
                dic .setValue(error!,  forKey:  "error")
                dic .setValue(ivr!,  forKey:  "ivr")
                dic .setValue(label!, forKey: "label")
                dic .setValue(language!, forKey: "language")
                dic .setValue(marketed_when!, forKey: "marketed_when")
                dic .setValue(pending_account_opt_in!, forKey: "pending_account_opt_in")
                dic .setValue(pending_market_opt_in!, forKey: "pending_market_opt_in")
                dic .setValue(received!, forKey: "received")
                dic .setValue(recently_marketed!, forKey: "recently_marketed")
                dic .setValue(sent!, forKey: "sent")
                dic .setValue(stopped!, forKey: "stopped")
                dic .setValue(tags!, forKey: "tags")
                dic .setValue(web!, forKey: "web")
                dic .setValue(variables!, forKey: "variables")
                dic .setValue(cell!, forKey: "cell")

            //    print(dic)
                arr_values.add(dic)
               
            }
            profilebackView.isHidden = false
            tableview_Information.delegate = self
            tableview_Information.dataSource = self
            tableview_Information.reloadData()
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.profileFetch(_onView: self.view, phonestr: phone)
        }
    }
    
    func callModifyWbProfile(label:String)
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: internetNotAvailableTitle, message: internetNotAvailableMsg)

        default:
        // Hit login WS.
        let loginBL: LoginBL = LoginBL()
        loginBL.delegate = self
        loginBL.modifyProfile(_onView: self.view, phonestr: phone , label : label)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
       // callModifyWbProfile(label: textField.text!)
        
        if (textField.text?.characters.count)! == 0
        {
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message: "Please enter label")
        }
        else
        {
            let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
            let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
            
            let encodeString = "\(str_clientKey):\(str_token_key)"
           // print(encodeString)
            
            let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
            
            CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)
            let headers = [
                "Authorization": "\(data)",
                "accept": "application/json",
                "content-type": "application/json",
                "cache-control": "no-cache",
              //  "postman-token": "c49df1eb-9258-5917-66bc-227777c17c5f"
            ]
            
            let parameters = ["label": textField.text!] as [String : Any]

            let postData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://api.paymaxxpro.com/sms/cell/\(phone)")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "PUT"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
             //       print(error ?? "error")
                } else {
                    do {
                        
                        let json : NSDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        
                   //     print(json)
                        
                        DispatchQueue.main.async(){
                            CommonFunctions.sharedCommonFunctions.activateView(self.view)
                            
                            if (json.value(forKey: "error") as? String)! == ""
                            {
                                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message: "label updated sucessfully")
                            }
                            else{
                                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message: (json.value(forKey: "error") as? String)!)
                            }
                            
                        }
                        self.view.endEditing(true)
                        
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
    
    //MARK: - Menu Items
    func setupMenuBarButtonItems () {
        self.navigationItem.leftBarButtonItem = self.leftMenuBarButtonItem()
    }
    
    func leftMenuBarButtonItem () -> UIBarButtonItem {
        let leftMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "left-icon"), style: .plain, target: self, action: #selector(ChangePasswordVC.btnLeftMenuClicked))
        
        leftMenu.tintColor = UIColor.white
        return leftMenu
    }
    
    //*************** TableView Delegate & Datasource ******************//
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //*************** TableView Delegate & Datasource ******************//
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 0
            {
                return 45
        }
            else{
                return 72
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath as IndexPath) as! profileCell1
            tableCell.txtField_Name.text = (arr_values[0] as? NSDictionary)?.value(forKey: "label") as? String
            return tableCell
        }
        else{
            let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath as IndexPath) as! profileCell2
            
            tableCell.lbl_names.text = arr_accountLable[indexPath.row-1]
            
            if indexPath.row == 1
            {
                tableCell.lbl_values.text = ""
                

           // tableCell.lbl_names.text = (arr_values[0] as? NSDictionary)?.value(forKey: "ivr") as? String
                
                var cellNew = phone
                cellNew.remove(at: cellNew.startIndex)
                
                let decimalCharacters = CharacterSet.decimalDigits
                let decimalRange = cellNew.rangeOfCharacter(from: decimalCharacters)
                
                if decimalRange != nil {
                    tableCell.lbl_names.text = cellNew.tochangePhoneNumber()
                }
                else{
                    tableCell.lbl_names.text = cellNew
                }
              tableCell.img_insideEclipes.image = UIImage(named:"phone")
                
            }
            else if indexPath.row == 2
            {
               if ((arr_values[0] as? NSDictionary)?.value(forKey: "accepts_account") as? String) == "true"
               {
                tableCell.img_insideEclipes.image = UIImage(named:"okay")
               }
               else
               {
                tableCell.img_insideEclipes.image = UIImage(named:"cross")
               }
                tableCell.lbl_values.text = ""
                

            }
            else if indexPath.row == 3
            {
                tableCell.lbl_values.text = ""
                if ((arr_values[0] as? NSDictionary)?.value(forKey: "accepts_market") as? String) == "true"
                {
                    tableCell.img_insideEclipes.image = UIImage(named:"okay")
                }
                else
                {
                    tableCell.img_insideEclipes.image = UIImage(named:"cross")
                }
            }
            else if indexPath.row == 4
            {

                if (arr_values[0] as? NSDictionary)?.value(forKey: "language") as? String == "en"
                {
                    tableCell.lbl_values.text = "English"
                }
                else
                {
                    tableCell.lbl_values.text = "Spanish"
                }
                
                
//                tableCell.lbl_values.text = (arr_values[0] as? NSDictionary)?.value(forKey: "language") as? String
                tableCell.img_insideEclipes.image = UIImage(named:"language")
            }
            
             return tableCell
        }
    }

    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        
        if response is NSDictionary {
            
            if response.value(forKey: "status") as! String == "ProfileData"
            {
                let arr_profileData = NSMutableArray()
                arr_profileData .removeAllObjects()
                arr_profileData.add(response.value(forKey: "data"))
                
                if arr_profileData.count > 0
                {
                    for i in 0..<arr_profileData.count
                    {
                        let dic : NSMutableDictionary = ((arr_profileData.object(at: i) as! NSDictionary) .mutableCopy() as! NSMutableDictionary)
                        dic.setValue(phone, forKey: "cell")
                        arr_values.add(dic)
                    }
                    
                    let userDetails =  DBFunctions.sharedDBFunctions.fetchProfileData(cell: phone)
                    DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                    DBFunctions.sharedDBFunctions.saveProfileData(arr_Profile: arr_values, isUpdate: true)
                    profilebackView.isHidden = false
                    
                    tableview_Information.delegate = self
                    tableview_Information.dataSource = self
                    tableview_Information.reloadData()
                }
            }
            
         
            
        }
    }
    
    func failureResponseReceived (_ response:AnyObject) {
        // Error received in response.
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "", message: "\(response)")
    }
    
    
    func noDataReceived () {
        // No data received in response.
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: noDataAvailableTitle, message:pleaseTryAgainMsg)
    }

    func btnLeftMenuClicked() {
        self.navigationController?.popViewController(animated: true)
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
