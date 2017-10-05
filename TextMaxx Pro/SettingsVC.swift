//
//  SettingsVC.swift
//  TextMaxx Pro
//
//  Created by surender on 04/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire

class SettingsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,BaseBLDelegate,MFMailComposeViewControllerDelegate {

    //MARK:- OutLets
    @IBOutlet var tableView_Settings: UITableView!
   
    //MARK:- Varriables
    var arr_setting = ["My Account","Help Videos","Need Help ?","Change Password","Website Link","Log Out"]
    var dicLoginDetails:NSDictionary = [:]
    var versionNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    //MARK:- Table View delegate & dataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 6
         {
            return 190
        }
         else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_setting.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 6
        {
            let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath as IndexPath) as! SettingCell
            
//            if !(tableCell.lblVersionNumber.text == versionNumber)
//            {
//                let alertController = UIAlertController(title: "TextMaxxPro", message: "Update App Version", preferredStyle: .alert)
//                
//                // Create the actions
//                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
//                    UIAlertAction in
//                }
//                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
//                    UIAlertAction in
//                    NSLog("Cancel Pressed")
//                }
//                // Add the actions
//                alertController.addAction(okAction)
//                alertController.addAction(cancelAction)
//                // Present the controller
//                self.present(alertController, animated: true, completion: nil)
//            }
            
            tableCell.btn_Fb .addTarget(self, action: #selector(SettingsVC.fbAction), for: UIControlEvents.touchUpInside)
            
            tableCell.btn_Twitter .addTarget(self, action: #selector(SettingsVC.twitterAction), for: UIControlEvents.touchUpInside)
            
            tableCell.btn_Instagram .addTarget(self, action: #selector(SettingsVC.instagrameAction), for: UIControlEvents.touchUpInside)
            
            tableCell.btn_Youtube .addTarget(self, action: #selector(SettingsVC.youtubeAction), for: UIControlEvents.touchUpInside)
            
            
            return tableCell
        }
        else{
            let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath as IndexPath) as! SettingCell
            tableCell.lbl_title.text = arr_setting[indexPath.row]
            
            if indexPath.row % 2 == 0
            {
                tableCell.backgroundColor = UIColor.init(colorLiteralRed: 238/255, green: 246/255, blue: 254/255, alpha: 1)
            }
            else{
                tableCell.backgroundColor = UIColor.white
            }
            return tableCell
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0
        {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC")as! MyAccountVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else if indexPath.row == 1
        {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "YoutubeVC")as! YoutubeVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else if indexPath.row == 2
        {
            sendEmail()
        }
        else if indexPath.row == 3
        {
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Please contact your manager to get temporary password.")
            
            
        }
        else if indexPath.row == 4
        {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SocialVC")as! SocialVC
            VC.navigationTitle = "Website"
            VC.webURL = "http://www.textmaxxpro.com"
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
        else if indexPath.row == 5
        {
            UserDefaults.standard.set(true, forKey: "Logout")
            callWbLogout()
        }
    }
    
    //MARK:- Email Actions
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["support@textmaxxpro.com"])
            mail.setMessageBody("<p>Enter queries regarding text..</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    //MARK:- Social Actions
    func fbAction()
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SocialVC")as! SocialVC
        VC.navigationTitle = "Facebook"
        VC.webURL = "https://www.facebook.com/textmaxxpro"
        self.navigationController?.pushViewController(VC, animated: true)

        
    }
    
    func twitterAction()
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SocialVC")as! SocialVC
        VC.navigationTitle = "Twitter"
        VC.webURL = "https://twitter.com/TextmaxxPro"
        self.navigationController?.pushViewController(VC, animated: true)

        
    }
    
    func instagrameAction()
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SocialVC")as! SocialVC
        VC.navigationTitle = "Instagrame"
        VC.webURL = "http://www.textmaxxpro.com"
        self.navigationController?.pushViewController(VC, animated: true)

    }
    
    func youtubeAction()
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SocialVC")as! SocialVC
        VC.navigationTitle = "Youtube"
        VC.webURL = "https://www.youtube.com/channel/UCJVyXztIap_igWjLa8B5-sw"
        self.navigationController?.pushViewController(VC, animated: true)
    }

    //MARK:- CallWB
    func callWbLogout(){
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
            loginBL.login(self.view, userName: "", password: "")
        }
        
    }
    
    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        
        if response is NSDictionary {
            
            dicLoginDetails = response as! NSDictionary
            
//            if dicLoginDetails.value(forKey: "error") as? String == ""
//            {
                UserDefaults.standard.set(false, forKey: "Logout")
                UserDefaults.standard.set(false, forKey: "Login")
                UserDefaults.standard.set(false, forKey: "Chat")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.LoginVC()
//            }
//            else
//            {
//
//            }
        }
    }
    
    func failureResponseReceived (_ response:AnyObject) {
        // Error received in response.
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "", message: "\(response)")
    }

    func noDataReceived () {
        UserDefaults.standard.set(false, forKey: "Login")
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
