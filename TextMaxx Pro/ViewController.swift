//
//  ViewController.swift
//  TextMaxx Pro
//
//  Created by surender on 04/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ViewController: UIViewController,BaseBLDelegate {

    var dicLoginDetails:NSDictionary = [:]
    @IBOutlet weak var txtField_Email: UITextField!
    @IBOutlet weak var backPop_View: UIView!
    @IBOutlet var txtField_Password: UITextField!
    @IBOutlet var txtField_UserName: UITextField!
    
    @IBOutlet var btnLogin: UIButton!
    var sha_enc = ""
    
    @IBOutlet weak var forgotPassword_View: UIView!
    @IBOutlet var btnPattern: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let md5Data = MD5(string: "26daf5f7cd59c32363cba9ee46ebf6a0ff783a4538594b4094890e7bfade7ba9" + "India1")
//        let md5Hex =  md5Data!.map { String(format: "%02hhx", $0) }.joined()
        
        let shastring = "26daf5f7cd59c32363cba9ee46ebf6a0ff783a4538594b4094890e7bfade7ba9" + "India1"
        IQKeyboardManager.sharedManager().enableAutoToolbar = true

        sha_enc = shastring.sha1()
     //   print(sha_enc)
        
        let view = CommonFunctions.sharedCommonFunctions.setLeftPadding(txtField_UserName, rect: CGRect(x: 0.0, y: 0.0, width: 10, height: 10))
        
        txtField_UserName.leftView = view
        txtField_UserName.leftViewMode = UITextFieldViewMode.always
        
        let view1 = CommonFunctions.sharedCommonFunctions.setLeftPadding(txtField_Password, rect: CGRect(x: 0.0, y: 0.0, width: 10, height: 10))
        txtField_Password.leftView = view1
        txtField_Password.leftViewMode = UITextFieldViewMode.always
        
    }
    
    func MD5(string: String) -> Data? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
    
    // MARK: - BUTTON CANCEL POPOP ACTION METHOD
    
    @IBAction func btnCancelPopOp(_ sender: AnyObject) {
        
        backPop_View.isHidden = true
    }
    
    @IBAction func PopUpActions(_ sender: AnyObject) {
        
        if sender.tag == 111
        {
            
        }
        else if sender.tag == 112
        {
            
        }
        else if sender.tag == 113
        {
            
        }
        else if sender.tag == 114
        {
            backPop_View.isHidden = true
        }
        else if sender.tag == 115
        {
            forgotPassword_View.isHidden = true
        }
        else if sender.tag == 116
        {
        }
    }
    
    @IBAction func patternAction(_ sender: AnyObject) {
        
    }
    
    @IBAction func forgotPassword_Action(_ sender: AnyObject) {
        // forgotPassword_View.isHidden = false
         CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Please contact your supervisor and have them reset your password. if you are the supervisor. Please contact TextmaxxPro at 866-367-6889 to reset your password")
    }
    
    @IBAction func LoginAction(_ sender: AnyObject) {
        if txtField_UserName.text?.characters.count == 0
        {
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: appTitle, message: "Please Enter username")
            
        }
        else if txtField_Password.text?.characters.count == 0
        {
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: appTitle, message: "Please Enter password")
        }
        else
        {
            UserDefaults.standard.set(false, forKey: "Logout")

            callWbLogin()
        }
    }

    
    // MARK: - Call Wb
    func callWbLogin(){
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
            
            UserDefaults.standard.setValue(txtField_UserName.text!, forKey: "userName")
            loginBL.login(self.view, userName: txtField_UserName.text!, password: txtField_Password.text!)
        }
    }

    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        
        if response is NSDictionary {
            
            dicLoginDetails = response as! NSDictionary
            
            if dicLoginDetails.value(forKey: "client") is NSNull {
                
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Wrong username and password. Please contact your manager to reset the account.")
                //    backPop_View.isHidden = false
                UserDefaults.standard.set(false, forKey: "Login")
                
            }
            else
            {
                backPop_View.isHidden = true
                UserDefaults.standard.set(String(describing: (dicLoginDetails.value(forKey: "id"))!), forKey: "userID")
                UserDefaults.standard.set(dicLoginDetails.value(forKey: "client"), forKey: "Client")
                UserDefaults.standard.set(dicLoginDetails.value(forKey: "token"), forKey: "token")
                UserDefaults.standard.set(true, forKey: "Login")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.changeWithTabBarControler()

            }
            
            
            
//            if dicLoginDetails.value(forKey: "client") as? String == ""
//            {
//                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Wrong username and password. Please contact your manager to reset the account.")
//            //    backPop_View.isHidden = false
//                 UserDefaults.standard.set(false, forKey: "Login")
//            }
//            else
//            {
//                backPop_View.isHidden = true
//                UserDefaults.standard.set(String(describing: (dicLoginDetails.value(forKey: "id"))!), forKey: "userID")
//                UserDefaults.standard.set(dicLoginDetails.value(forKey: "client"), forKey: "Client")
//                UserDefaults.standard.set(dicLoginDetails.value(forKey: "token"), forKey: "token")
//                UserDefaults.standard.set(true, forKey: "Login")
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.changeWithTabBarControler()
//            }
        }
    }
    
    func failureResponseReceived (_ response:AnyObject) {
        // Error received in response.
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "", message: "\(response)")
    }
    
//    func navTodashboard(){
//        
//        self.performSegue(withIdentifier: "showDashboardfromLogin", sender: self)
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
//        
//        let navController: UINavigationController = UINavigationController(rootViewController: controller)
//        var image = UIImage(named: "top-bar")! as UIImage
//        navController.navigationBar.setBackgroundImage(image,for: .default)
//        
//        let appDelegate =
//            UIApplication.shared.delegate as! AppDelegate
//        appDelegate.setLeftMenuAsRootWithCenterController(navController)
//        
//    }
    
    func noDataReceived () {
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Wrong username and password. Please contact your manager to reset the account.")

        // No data received in response.
      //  CommonFunctions.sharedCommonFunctions.showAlert(self, title: noDataAvailableTitle, message:pleaseTryAgainMsg)
       // backPop_View.isHidden = false
        UserDefaults.standard.set(false, forKey: "Login")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//extension String {
//    func sha1() -> String {
//        let data = self.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
//        }
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joined()
//    }
//}

