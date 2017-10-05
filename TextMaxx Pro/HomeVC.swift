//
//  HomeVC.swift
//  TextMaxx Pro
//
//  Created by surender on 04/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit
import Contacts
import IQKeyboardManagerSwift
import Alamofire


class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource,BaseBLDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //MARK:- Outlets
    @IBOutlet var lbl_cellNumber: UILabel!
    @IBOutlet var txtField_Language: UITextField!
    @IBOutlet var txtField_Name: UITextField!
    @IBOutlet var viewBack_ContactInfo: UIView!
    @IBOutlet var viewback_NewConversation: UIView!
    @IBOutlet var lbl_NoAwaits: UILabel!
    @IBOutlet var btnPromoOutlet: UIButton!
    @IBOutlet var btnAccountOutlet: UIButton!
    @IBOutlet var btnBothOutlet: UIButton!
    @IBOutlet var txt_cellNumber: UITextField!
    @IBOutlet var tableView_Home: UITableView!

    //MARK:- Varriables
    var arr_Home = ["Denial","Roger Smith","John Doe","Jody Jhonson"]
    var contactNumber = String()
    var final_str = ""
    var phoneFormatter = PhoneNumberFormatter()
    var arr_language = ["English","Spanish"]
    var str_Account = String()
    var str_Marketing = String()
    var arr_awaitList = NSMutableArray()
    var indexPathofCell = NSIndexPath()
    var versionNumber = String()
    
    //MARK:- DidLoad & WillAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView_Home.tableFooterView = UIView()
        setupMenuBarButtonItems()
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(HomeVC.callWbMessages),
            name: NSNotification.Name(rawValue: "await"),
            object: nil)
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(HomeVC.getVersion),
//            name: NSNotification.Name(rawValue: "update"),
//            object: nil)
        
    }
    
    func getVersion()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: internetNotAvailableTitle, message: internetNotAvailableMsg)
            
        default:
            
             CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: "Please wait")
            
            Alamofire.request("http://dev614.trigma.us/textMax_client_Imran/webservice.php?sectet_key=3689", method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print(response.result.value ?? "")
                        
                        CommonFunctions.sharedCommonFunctions.activateView(self.view)
                        if let jsonDict = response.result.value as? NSDictionary{
                            //                            self.versionNumber = jsonDict.value(forKeyPath: "data.ios_version") as! String
                            
                            if UserDefaults.standard.bool(forKey: "updateApp") == false
                            {
                                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                                    if !(version == jsonDict.value(forKeyPath: "data.ios_version") as! String)
                                    {
                                        let alertController = UIAlertController(title: "TextMaxx Pro Update", message: "Version \(jsonDict.value(forKeyPath: "data.ios_version") as! String) is available for your iPhone and is ready to install.", preferredStyle: .alert)
                                        
                                        // Create the actions
                                        
                                        let okAction = UIAlertAction(title: "Update Now", style: UIAlertActionStyle.default) {
                                            UIAlertAction in
                                            
                                            
                                            if let url = URL(string: "itms-apps://itunes.apple.com/app/id1218659079"),
                                                UIApplication.shared.canOpenURL(url){
                                                UIApplication.shared.openURL(url)
                                            }
                                        }
                                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                                            UIAlertAction in
                                            UserDefaults.standard.set(true, forKey: "updateApp")
                                            
                                        }
                                        // Add the actions
                                        alertController.addAction(okAction)
                                        alertController.addAction(cancelAction)
                                        // Present the controller
                                        self.present(alertController, animated: true, completion: nil)
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error ?? "")
                    break
                    
                }
            }
            // Hit login WS.
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        UserDefaults.standard.set(true, forKey: "InboxPage")
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cellnumber = ""
        self.btnBothOutlet.isSelected = true
        self.str_Account = "true"
        self.str_Marketing = "false"
        self.txt_cellNumber.text = ""
        self.txtField_Name.text = ""
        self.viewback_NewConversation.isHidden = true
        self.viewBack_ContactInfo.isHidden = true
        self.formatField(self.txt_cellNumber)
        self.callWbMessages()
        
        getVersion()
    }
    
    //MARK: - Menu Items
    func setupMenuBarButtonItems () {
        self.navigationItem.rightBarButtonItem = self.rightMenuBarButtonItem()
    }
    
    func rightMenuBarButtonItem () -> UIBarButtonItem {
        let rightMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(HomeVC.MethodName))
        rightMenu.tintColor = UIColor.white
        return rightMenu
    }
    
    
    func MethodName(){
        viewback_NewConversation.isHidden = false
    }
    
    // MARK:- text field delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pickerView = UIPickerView()
        txtField_Language.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    }
    

    //MARK:- contact number foramtter
    @IBAction func formatField(_ sender: UITextField) {
        if let text = sender.text {
            if sender == txtField_Name {
                sender.text = phoneFormatter.format(text)
            } else {
                //multiple phone numbers being validated at once require an additional unique hash parameter so we can keep them straight
                sender.text = phoneFormatter.format(text, hash: sender.hash)
            }
        }
    }
    
    //MARK:- Call Wb
    func callWbMessages()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchAwaitList()
         //   print(userDetails)
            
            arr_awaitList.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                
                let verified = userDetails[i].value(forKey: "verified") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                let cellNumber = userDetails[i].value(forKey: "cell") as? String
                let accountNumber = userDetails[i].value(forKey: "accountNumber") as? String
                let count = userDetails[i].value(forKey: "count") as? String
                let message = userDetails[i].value(forKey: "message") as? String
                let primary = userDetails[i].value(forKey: "primary") as? String
                let sent = userDetails[i].value(forKey: "sent") as? String

                dic.setValue(verified!, forKey:  "verified")
                dic .setValue(label!, forKey: "label")
                dic .setValue(cellNumber!, forKey: "cell")
                dic .setValue(accountNumber!, forKey: "account_number")
                dic.setValue(count!, forKey:  "count")
                dic .setValue(message!, forKey: "message")
                dic .setValue(primary!, forKey: "primary")
                dic .setValue(sent!, forKey: "sent")
                
                arr_awaitList.add(dic)
            }
            if arr_awaitList.count > 0
            {
                self.tableView_Home.isHidden = false
                self.lbl_NoAwaits.isHidden = true
            }
            else
            {
                self.tableView_Home.isHidden = false
                self.lbl_NoAwaits.isHidden = true
            }
            tableView_Home.reloadData()
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.awaitsMessage(self.view)
        }
    }
    
    func callWbVerify(){
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
            
            loginBL.verify(self.view, cell: final_str, account: str_Account, marketing: str_Marketing, label:txtField_Name.text!, Language: txtField_Language.text!)
        }
    }
    
    func  callWBContactVerified()
    {
        let newString = txt_cellNumber.text!.replacingOccurrences(of: "(", with: "", options: .literal, range: nil)
        let newString2 = newString.replacingOccurrences(of: ")", with: "", options: .literal, range: nil)
        let newString3 = newString2.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
        let newString4 = newString3.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        final_str = "1\(newString4)"
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: internetNotAvailableTitle, message: internetNotAvailableMsg)
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)
            loginBL.contactVerified(self.view, cell: final_str)
        }
    }
    
    func CallWBMessagesList(Index: Int)
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
            
            loginBL.messageList(self.view, phonestr: ((arr_awaitList[Index] as? NSDictionary)?.value(forKey: "cell") as? String)!, messageID: "0", occured: "after")
        }
    }
    
    //MARK: - Call Wb
    func callDeleteAwaitMessages(cellNumber:String)
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: internetNotAvailableTitle, message: internetNotAvailableMsg)
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.DeleteAwaitMessage(self.view, cell: cellNumber)
            
        }
    }
    
    //MARK:- Tableview Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_awaitList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! HomeCell
        
     //   tableCell.lbl_Name.text = arr_Home[indexPath.row]
        
//        tableCell.lbl_Name.text = (arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String
        
        
        let str_label = ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)?.replacingOccurrences(of: "\n", with: "")
        
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = str_label?.rangeOfCharacter(from: decimalCharacters)
        
        if decimalRange != nil {
            tableCell.lbl_Name.text = str_label?.tochangePhoneNumber()
            
        }
        else{
            tableCell.lbl_Name.text = ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)?.replacingOccurrences(of: "\n", with: "")
        }
        
        tableCell.lbl_Message.text = (arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "message") as? String
        
        tableCell.lbl_Count.text = (arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "count") as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateA = dateFormatter.date(from: ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "sent") as? String)!)
            
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "hh:mm a"
        let strA = dateFormatter1.string(from: dateA!)
        
        tableCell.lbl_Time.text = strA
        
 
        tableCell.btn_Info.addTarget(self, action: #selector(HomeVC.btnInfoAction(sender:)), for: UIControlEvents.touchUpInside)
        
        tableCell.btn_Info.tag = indexPath.row
        
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cellnumber = ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
        
        contactNumber = ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatDetailVC")as! chatDetailVC
        VC.str_NameTitle = ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)!
        VC.contactNumber = contactNumber
        self.navigationController?.pushViewController(VC, animated: true)
    }

    //** tableview delegate for delete row **//
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
        UserDefaults.standard.set(false, forKey: "InboxPage")
        indexPathofCell = indexPath as NSIndexPath
          callDeleteAwaitMessages(cellNumber: ((arr_awaitList[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!)
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    //MARK:- PickerView Delegate & DataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return arr_language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0
        {
            txtField_Language.text = arr_language[0]
        }
        return arr_language[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtField_Language.text = arr_language[row]
    }
    
    //MARK:- New conversation Action
    @IBAction func btnAction_NewConversation(_ sender: Any) {
        
        if (sender as AnyObject).tag == 1501
        {
            viewback_NewConversation.isHidden = true
            txt_cellNumber.text = ""
            txt_cellNumber.resignFirstResponder()
        }
        else
        {
            if !phoneFormatter.isValid(txt_cellNumber.text!)
            {
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Please enter valid phone number")
            }
            else
            {
                callWBContactVerified()
            }
        }
    }
    
    @IBAction func actions_ContactInfo(_ sender: Any) {
        if (sender as AnyObject).tag == 1601
        {
            txtField_Name.text = ""
            txt_cellNumber.text = ""
            viewBack_ContactInfo.isHidden = true
        }
        else if (sender as AnyObject).tag == 1602
        {
            if (txtField_Language.text?.characters.count)! > 0 && (txtField_Name.text?.characters.count)! > 0
            {
                callWbVerify()
            }
            else
            {
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"Please enter both field")
            }
        }
        else if (sender as AnyObject).tag == 1603
        {
            txtField_Name.text = ""
            txt_cellNumber.text = ""
            viewBack_ContactInfo.isHidden = true
        }
    }
    
    //MARK:- BUTTON PROMO ACTION METHOD
    
    @IBAction func btnPromoAction(_ sender: Any) {
        
        btnPromoOutlet.isSelected   = true
        btnAccountOutlet.isSelected = false
        btnBothOutlet.isSelected    = false
        str_Account = "true"
        str_Marketing = "false"
    }
    
    //MARK:- BUTTON ACCOUNT ACTION METHOD
    
    @IBAction func btnAccountAction(_ sender: Any) {
        
        btnPromoOutlet.isSelected   = false
        btnAccountOutlet.isSelected = true
        btnBothOutlet.isSelected    = false
        
        str_Account = "false"
        str_Marketing = "true"
    }
    
    //MARK:- BUTTON BOTH ACTION METHOD
    
    @IBAction func btnBothAction(_ sender: Any) {
        
        btnPromoOutlet.isSelected   = false
        btnAccountOutlet.isSelected = false
        btnBothOutlet.isSelected    = true
        
        str_Account = "true"
        str_Marketing = "true"
    }
    
    //MARK:- Information Action
    func btnInfoAction (sender:AnyObject)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")as! ProfileVC
        VC.phone = ((arr_awaitList[sender.tag] as? NSDictionary)?.value(forKey: "cell") as? String)!
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        if response is NSDictionary {
            if response.value(forKey: "status") as! String == "Await"
            {
                arr_awaitList = (response.value(forKeyPath: "data.awaits") as? NSArray)! .mutableCopy() as! NSMutableArray
                
                if arr_awaitList .count > 0
                {
                    tableView_Home.isHidden = false
                    lbl_NoAwaits.isHidden = true
                    
                    self.tabBarController?.tabBar.items?.first?.badgeValue = String(arr_awaitList.count)
                }
                else
                {
                    self.tabBarController?.tabBar.items?.first?.badgeValue = nil
                    tableView_Home.isHidden = true
                    lbl_NoAwaits.isHidden = false
                }
                tableView_Home.reloadData()
                
                let userDetails =  DBFunctions.sharedDBFunctions.fetchAwaitList()
                DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                DBFunctions.sharedDBFunctions.saveAwaitsList(arr_await: arr_awaitList, isUpdate: true)
            }
            else if response.value(forKey: "status") as! String == "contactVerified"
            {
                if (response.value(forKeyPath: "data.confirmed") as? Bool)! == true && (response.value(forKeyPath: "data.verified") as? Bool)! == true
                {
                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Contact already exist!!")
                    self.txt_cellNumber.resignFirstResponder()
                    self.txt_cellNumber.text = ""
                }
                else if (response.value(forKeyPath: "data.confirmed") as? Bool)! == false && (response.value(forKeyPath: "data.verified") as? Bool)! == false
                {
                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Cell does not exist!!")
                    self.txt_cellNumber.resignFirstResponder()
                    self.txt_cellNumber.text = ""
                }
                else
                {
                    self.txt_cellNumber.resignFirstResponder()
                    lbl_cellNumber.text = txt_cellNumber.text!
                    viewback_NewConversation.isHidden = true
                    viewBack_ContactInfo.isHidden = false
                }
            }
            else if response.value(forKey: "status") as! String == "AwaitDelList"
            {
                
//                if (response.value(forKeyPath: "data.error") as? String)! == ""
//                {
                   arr_awaitList.removeObject(at: indexPathofCell.row)
                    tableView_Home.deleteRows(at: [indexPathofCell as IndexPath], with: .fade)
                    if arr_awaitList.count > 0
                    {
                         self.tabBarController?.tabBar.items?.first?.badgeValue = String(arr_awaitList.count)
                    }
                    else
                    {
                         self.tabBarController?.tabBar.items?.first?.badgeValue = nil
                    }
//                }
//                else
//                {
//                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Somthing went wrong!!")
//                }
            }
            else
            {
                if let val = response.value(forKeyPath: "data.error") {
                                        viewBack_ContactInfo.isHidden = true
                                        viewback_NewConversation.isHidden = true
                                        txtField_Name.text = ""
                                        txt_cellNumber.text = ""
                                        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: (response.value(forKeyPath: "data.error") as? String)!)
                }
                else
                {
                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatDetailVC")as! chatDetailVC
                    VC.str_NameTitle = txtField_Name.text!
                    VC.contactNumber = final_str
                    self.navigationController?.pushViewController(VC, animated: true)

                }
                
                
//                if (response.value(forKeyPath: "data.error") as? String)! == ""
//                {
                                    //}
//                else
//                {
//                    viewBack_ContactInfo.isHidden = true
//                    viewback_NewConversation.isHidden = true
//                    txtField_Name.text = ""
//                    txt_cellNumber.text = ""
//                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: (response.value(forKeyPath: "data.error") as? String)!)
//                }
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
