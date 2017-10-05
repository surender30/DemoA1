//
//  MyAccountVC.swift
//  TextMaxx Pro
//
//  Created by Nitin Suri on 05/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire


class MyAccountVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BaseBLDelegate {
    
    
    @IBOutlet var tableview_MyAccount: UITableView!
    
    var arr_accountLable = ["First name","Last name", "User name", "Email address", "Cell number"]
    var txtField_Final = UITextField()
    var arr_MyValues = NSMutableArray()
    var dic_myAccount = NSMutableDictionary()


    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        self.setupMenuBarButtonItems()
         callWbMyAccount()
        // Do any additional setup after loading the view.
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
    
    func btnLeftMenuClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    // MARK: - Call Wb
    func callWbMyAccount(){
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
            loginBL.myAccount(self.view)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
      //  print(textField.tag)
        
        if textField.tag == 0
        {
            dic_myAccount.setValue(textField.text, forKey: "first_name")
        }
        else if textField.tag == 1
        {
            dic_myAccount.setValue(textField.text, forKey: "last_name")
        }
        else if textField.tag == 2
        {
            dic_myAccount.setValue(textField.text, forKey: "login")

        }
        else if textField.tag == 3
        {
            dic_myAccount.setValue(textField.text, forKey: "email_address")

        }
        else if textField.tag == 4
        {
            dic_myAccount.setValue(textField.text, forKey: "cell")
        }
    }
    
    //*************** TableView Delegate & Datasource ******************//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "myAccountCell", for: indexPath as IndexPath) as! myAccountCell
        
        tableCell.lbl_Staic.text = arr_accountLable[indexPath.row]
        tableCell.txtField_SetValue.placeholder = arr_accountLable[indexPath.row]
        tableCell.txtField_SetValue.tag = indexPath.row
        
        if indexPath.row == 0 {
            
            tableCell.txtField_SetValue.text = (arr_MyValues[0] as AnyObject) .value(forKey: "first_name") as? String
        }
        
       if indexPath.row == 1 {
        
            tableCell.txtField_SetValue.text = (arr_MyValues[0] as AnyObject) .value(forKey: "last_name") as? String
        }
        
        if indexPath.row == 2 {
            tableCell.txtField_SetValue.text = ((arr_MyValues[0] as AnyObject) .value(forKey: "login") as? String)!
        }
        
        if indexPath.row == 3 {
            tableCell.txtField_SetValue.text = (arr_MyValues[0] as AnyObject) .value(forKey: "email_address") as? String
        }
        
        if indexPath.row == 4 {
            tableCell.txtField_SetValue.text = (arr_MyValues[0] as AnyObject) .value(forKey: "cell") as? String
        }
        
//        if indexPath.row == 0 {
//            tableCell.txtField_SetValue.text = arr_MyValues .value(forKey: "first_name") as? String
//        }
        
        
        
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
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
        footerView.backgroundColor = UIColor.clear
        
        // ** UIBUTTON UPDATE **
        
      let btnCancelPayment = UIButton(frame: CGRect(x:10, y: footerView.frame.minY + 20, width: tableView.frame.size.width-20, height: 40))
        btnCancelPayment.addTarget(self, action: #selector(MyAccountVC.btnUpdateMethod), for: .touchUpInside)
        btnCancelPayment.setTitle("Update", for: UIControlState.normal)
        btnCancelPayment.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnCancelPayment.backgroundColor = UIColor(red: 34/255, green: 111/255, blue: 203/255, alpha: 1.0)
        btnCancelPayment.layer.cornerRadius = 5
        btnCancelPayment.titleLabel?.font = btnCancelPayment.titleLabel?.font?.withSize(14)
        footerView.addSubview(btnCancelPayment)
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80.0
    }
        
        // MARK: - Response Received
        func successResponseReceived (_ response:AnyObject) {
            
            if response is NSDictionary {
                
                if response.value(forKey: "status") as! String == "MyAccount"
                {
                    arr_MyValues.add(response.value(forKey: "data"))
                    dic_myAccount = (response.value(forKey: "data") as? NSDictionary)?.mutableCopy() as! NSMutableDictionary
                    
                 //   print(arr_MyValues)
                    
                    if arr_MyValues.count > 0
                    {
                        tableview_MyAccount.delegate = self
                        tableview_MyAccount.dataSource = self
                        tableview_MyAccount .reloadData()
                    }
                }
                else
                {
//                    if (response.value(forKeyPath: "data.error") as? String)! == ""
//                    {
                        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message: "Profile sucessfully updated.")
                    //}
                }
            }
        }
        
        func failureResponseReceived (_ response:AnyObject) {
            // Error received in response.
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: "", message: "\(response)")
        }
        
      
        
        func noDataReceived () {
             CommonFunctions.sharedCommonFunctions.showAlert(self, title: "Error!!", message: "Service not working")
        }
        
    

    // MARK:- BUTTON UPDATE ACCOUNT
    
    func btnUpdateMethod() {
        
        UserDefaults.standard.setValue(dic_myAccount, forKey: "profileData")
        callWbEditMyAccount()
        
        
        /*
        let dic_Profile = UserDefaults.standard.value(forKey: "profileData") as! NSDictionary
        
        let first_name = dic_Profile.value(forKey: "first_name") as? String
        let last_name = dic_Profile.value(forKey: "last_name") as? String
        let email_address = dic_Profile.value(forKey: "email_address") as? String
        let cell_number = dic_Profile.value(forKey: "cell") as? String
        let login = dic_Profile.value(forKey: "login") as? String
        
    
        let urlComplement = userApi
        var urlCompleteLogin = String()
        
        let userId = UserDefaults.standard.value(forKey:"userID") as? String
        urlCompleteLogin =  "\(urlComplement)/\(userId!)"
        
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        
        CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)
        
        let headers = [
            "host": "sanbox.paymaxxpro.com",
            "user-agent": "Fiddler",
            "accept": "application/json",
            "content-length": "99",
            "content-type": "application/json",
            "authorization": "\(data)",
            "cache-control": "no-cache",
        ]
        
        let parameters = [
            "first_name": first_name!,
            "last_name": last_name!,
            "email_address": email_address!,
            "cell": cell_number!,
            "login": login!
            ] as [String : Any]
    
        
        let data1 = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://sandbox.paymaxxpro.com/sms/\(urlCompleteLogin)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = headers
        request.httpBody = data1 as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "error")
            } else {
                do {
                    
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse ?? "")
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    print(json)
                    
                    DispatchQueue.main.async(){
                        CommonFunctions.sharedCommonFunctions.activateView(self.view)
                        //                                if json.value(forKey: "error") as? String == ""
                        //                                {
                        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"message successfully sent")
                        
                        // }
                    }
                    self.view.endEditing(true)
                }
                catch
                {
                    
                      DispatchQueue.main.async(){
                        CommonFunctions.sharedCommonFunctions.activateView(self.view)
                        CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    }
                    // Hide Loading Indicator
                   
                }
            }
        })
        
        dataTask.resume()
        
        
        */
       }
    
    
    // MARK: - Call Wb
    func callWbEditMyAccount(){
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
            
            loginBL.editMyAccount(self.view)
        }
        
    }
    
}

