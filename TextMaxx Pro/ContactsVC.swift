//
//  ContactsVC.swift
//  TextMaxx Pro
//
//  Created by surender on 04/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift


class ContactsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,BaseBLDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var btn_Search: UIButton!
    @IBOutlet weak var view_Search: UIView!
    //MARK:- Outlets
    
    @IBOutlet var lbl_cellNumber: UILabel!
    @IBOutlet var txtField_Label: UITextField!
    @IBOutlet var txtFiled_Language: UITextField!
    @IBOutlet var viewBack_Verification: UIView!
    @IBOutlet var txtField_Cell: UITextField!
    @IBOutlet var view_backAddNewConver: UIView!
    @IBOutlet var btnPromoOutlet: UIButton!
    @IBOutlet var btnAccountOutlet: UIButton!
    @IBOutlet var btnBothOutlet: UIButton!
    @IBOutlet var tableView_Contacts: UITableView!
    @IBOutlet var lbl_NoAwaits: UILabel!
    
    @IBOutlet var txtField_Search: UITextField!
    @IBOutlet weak var tableViewSearch: UITableView!

    //MARK:- Varriables
    var final_str = ""
    var arr_recentList = NSMutableArray()
    var arr_searchList = NSMutableArray()
    var arr_searchListTemp = NSMutableArray()

    
    var contactNumber = String()
    var arr_language = ["English","Spanish"]
    var msgSendBool : Bool = false
    var str_Account = String()
    var str_Marketing = String()
    var phoneFormatter = PhoneNumberFormatter()
    var contactBoolSearch : Bool = false
    
    var cellContact = String()
    var labelContact = String()


    
    
    //MARK:- did load & will appear
    override func viewDidLoad() {
        super.viewDidLoad()
              //  self.setupMenuBarButtonItems()
        
        txtField_Search.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    @IBAction func SearchAction(_ sender: Any) {
        
        
       // btn_Search.isHidden = true
        txtField_Search.text = ""
//        txtField_Search.isHidden = false
//        view_Search.isHidden = false
        contactBoolSearch = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        CallWBContactList()
        txtField_Search.text = ""
       // btn_Search.isHidden = false
//        txtField_Search.isHidden = true
//        view_Search.isHidden = true
        
        
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cellnumber = ""
        // callWbRecentMessages()
        
        
        btnBothOutlet.isSelected = true
        str_Account = "true"
        str_Marketing = "true"
        txtField_Cell.text = ""
        txtField_Label.text = ""
        viewBack_Verification.isHidden = true
        view_backAddNewConver.isHidden = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        msgSendBool = false
        formatField(txtField_Cell)
    }

    func CallWBContactList()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchContactfromDB()
           // print(userDetails)
            
            arr_searchList.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                
                let verified = userDetails[i].value(forKey: "verified") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                let cellNumber = userDetails[i].value(forKey: "cell") as? String
                let accountNumber = userDetails[i].value(forKey: "accountNumber") as? String
                dic.setValue(verified!, forKey:  "verified")
                dic .setValue(label!, forKey: "label")
                dic .setValue(cellNumber!, forKey: "cell")
                dic .setValue(accountNumber!, forKey: "accountNumber")
               // print(dic)
                if verified! == "false"
                {
                    arr_searchList.add(dic)
                }
            }
            tableView_Contacts.reloadData()
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.contactList(self.view)
        }
    }
    
    
    func textFieldDidChange()
    {
//        if (txtField_Search.text?.characters.count)! >= 4
//        {
//            contactBoolSearch = true
//            self.callWBSearch(strSearch: txtField_Search.text!)
//        }
//        else
        if txtField_Search.text?.characters.count == 0 {
            txtField_Search.resignFirstResponder()
            // contactBoolSearch = false
             CallWBContactList()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (txtField_Search.text?.characters.count)! >= 2
        {
            contactBoolSearch = true
            self.callWBSearch(strSearch: txtField_Search.text!)
        }
        else
        {
              CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"Please enter min 2 characters!!")
        }
        return true
    }
    
    @IBAction func AddUser_Action(_ sender: Any) {
        view_backAddNewConver.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        txtField_Cell.resignFirstResponder()
        txtField_Label.resignFirstResponder()
        txtFiled_Language.resignFirstResponder()
        self.navigationController?.navigationBar.isHidden = false
    }
  

    //MARK:- TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pickerView = UIPickerView()
        txtFiled_Language.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    }
    
    //MARK: - Menu Items
    
    func setupMenuBarButtonItems () {
        self.navigationItem.leftBarButtonItem = self.leftMenuBarButtonItem()
        self.navigationItem.rightBarButtonItem = self.rightMenuBarButtonItem()
    }
    
    func leftMenuBarButtonItem () -> UIBarButtonItem {
        let leftMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(ChangePasswordVC.btnLeftMenuClicked))
        leftMenu.tintColor = UIColor.white
        return leftMenu
    }
    
    func btnLeftMenuClicked() {
        // self.navigationController?.popViewController(animated: true)
        view_backAddNewConver.isHidden = false
        
    }
    
    func rightMenuBarButtonItem () -> UIBarButtonItem {
        let rightMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(ChangePasswordVC.btnRightMenuClicked))
        rightMenu.tintColor = UIColor.white
        return rightMenu
    }
    
    func btnRightMenuClicked() {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "FindUserVC")as! FindUserVC
        self.navigationController?.pushViewController(VC, animated: false)
    }

    
    //MARK: - Handle phone number format
    @IBAction func formatField(_ sender: UITextField) {
        if let text = sender.text {
            if sender == txtField_Cell {
                sender.text = phoneFormatter.format(text)
            } else {
                //multiple phone numbers being validated at once require an additional unique hash parameter so we can keep them straight
                sender.text = phoneFormatter.format(text, hash: sender.hash)
            }
        }
    }
    
    // MARK: - Call Wb
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
            
//            loginBL.verify(self.view, cell: lbl_cellNumber.text!, account: str_Account, marketing: str_Marketing, label:txtField_Label.text!, Language: txtFiled_Language.text!)
            
            
               loginBL.verify(self.view, cell: cellContact, account: str_Account, marketing: str_Marketing, label:labelContact, Language: txtFiled_Language.text!)
        }
    }
    
    func  callWBContactVerified()
    {
        let newString = txtField_Cell.text!.replacingOccurrences(of: "(", with: "", options: .literal, range: nil)
        let newString2 = newString.replacingOccurrences(of: ")", with: "", options: .literal, range: nil)
        let newString3 = newString2.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
        let newString4 = newString3.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)

        final_str = "1\(newString4)"
       // print(newString4)
        
        cellContact = final_str
        
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            CommonFunctions.sharedCommonFunctions.showAlert(self, title: internetNotAvailableTitle, message: internetNotAvailableMsg)
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)
            loginBL.contactVerified(self.view, cell: final_str)
        }
    }
    
    func callWbRecentMessages()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            let userDetails =  DBFunctions.sharedDBFunctions.fetchRecentfromDB()
         //   print(userDetails)
            
            arr_recentList.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                
                let account_number = userDetails[i].value(forKey: "account_number") as? String
                let cell = userDetails[i].value(forKey: "cell") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                
                dic.setValue(account_number!, forKey:  "account_number")
                dic.setValue(cell!, forKey:  "cell")
                dic.setValue(label!, forKey:  "label")
                
                arr_recentList.add(dic)
            }
            
            if arr_recentList .count > 0
            {
                tableView_Contacts.isHidden = false
                lbl_NoAwaits.isHidden = true
            }
            else
            {
                tableView_Contacts.isHidden = true
                lbl_NoAwaits.isHidden = false
            }
            tableView_Contacts.reloadData()
            
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            UserDefaults.standard.set(true, forKey: "InboxPage")
            // Show Loading Indicator
            CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)
            loginBL.inboxMessage(self.view, cell: "")
        }
    }

    func callWBSearch(strSearch:String)
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
            loginBL.contactListSearch(self.view, phonestr: strSearch as String)
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
//        if contactBoolSearch == true{
//            return arr_searchList.count
//        }
//        else
//        {
//            return arr_recentList.count
//        }
        
        return  arr_searchList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath as IndexPath) as! ContactCell
        
      //  if contactBoolSearch == true{
        
        let str_label = ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "label")as! NSString) as String
        
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = str_label.rangeOfCharacter(from: decimalCharacters)
        
        if decimalRange != nil {
            tableCell.lbl_Name.text = str_label.tochangePhoneNumber()
        }
        else{
            tableCell.lbl_Name.text = str_label
        }
        
            if indexPath.row % 2 == 0
            {
                tableCell.backgroundColor = UIColor.init(colorLiteralRed: 238/255, green: 246/255, blue: 254/255, alpha: 1)
            }
            else{
                tableCell.backgroundColor = UIColor.white
            }
        
        
            if ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "verified")as! Bool) as Bool == false
            {
                tableCell.btn_Info .setBackgroundImage(UIImage(named:"addition"), for: UIControlState.normal)
                tableCell.btn_Info.isUserInteractionEnabled = false
               // tableCell.btn_Info.addTarget(self, action: #selector(ContactsVC.adduserAction(sender:)), for: .touchUpInside)
            }
            else
            {
                tableCell.btn_Info .setBackgroundImage(UIImage(named:"info-1"), for: UIControlState.normal)
                tableCell.btn_Info.addTarget(self, action: #selector(ContactsVC.btnInfoAction(sender:)), for: UIControlEvents.touchUpInside)
                tableCell.btn_Info.tag = indexPath.row
                tableCell.btn_Info.isUserInteractionEnabled = true
            }
       // }
//        else
//        {
//            tableCell.lbl_Name.text = ((arr_recentList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)?.replacingOccurrences(of: "\n", with: "")
//            
//            if indexPath.row % 2 == 0
//            {
//                tableCell.backgroundColor = UIColor.init(colorLiteralRed: 238/255, green: 246/255, blue: 254/255, alpha: 1)
//            }
//            else{
//                tableCell.backgroundColor = UIColor.white
//            }
//            tableCell.btn_Info .setBackgroundImage(UIImage(named:"info-1"), for: UIControlState.normal)
//            tableCell.btn_Info.addTarget(self, action: #selector(ContactsVC.btnInfoAction(sender:)), for: UIControlEvents.touchUpInside)
//            tableCell.btn_Info.tag = indexPath.row
//        }
        return tableCell
    }
    
    //MARK:- Add new user Action
    func adduserAction (sender:AnyObject)
    {
        view_backAddNewConver.isHidden = false

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if contactBoolSearch == true
//        {
            txtField_Search .resignFirstResponder()
            
            if ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "verified")as! Bool) as Bool == false
            {
                cellContact = ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "cell")as! NSString) as String
                
                labelContact = ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "label")as! NSString) as String
                
                txtField_Label.text = labelContact
              
                var cellNew = ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "cell")as! NSString) as String
                cellNew.remove(at: cellNew.startIndex)
                lbl_cellNumber.text = cellNew.tochangePhoneNumber()

                
//                let str_label = ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "label")as! NSString) as String
//
//                let decimalCharacters = CharacterSet.decimalDigits
//                let decimalRange = str_label.rangeOfCharacter(from: decimalCharacters)
//                
//                if decimalRange != nil {
//                    print("Numbers found")
//                    //             tableCell.lbl_Name.text = phoneFormatter.format(str_label!)
//                    txtField_Label.text = str_label.tochangePhoneNumber()
//                }
//                else{
//                    print("Numbers not found")
//                    txtField_Label.text = str_label
//                }
                
//                txtField_Label.text = ((arr_searchList.object(at: indexPath.row)as! NSDictionary).value(forKey: "label")as! NSString) as String
                
                viewBack_Verification.isHidden = false
            }
            else
            {
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatDetailVC")as! chatDetailVC
                VC.str_NameTitle = ((arr_searchList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)!
                VC.contactNumber = ((arr_searchList[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
                self.navigationController?.pushViewController(VC, animated: true)
            }
       // }
//        else
//        {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.cellnumber = ((arr_recentList[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
//            
//            let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatDetailVC")as! chatDetailVC
//            VC.str_NameTitle = ((arr_recentList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)!
//            VC.contactNumber = ((arr_recentList[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
//            self.navigationController?.pushViewController(VC, animated: true)
//        }
    }

    
    
    //MARK:- PickerView deleage
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return arr_language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0
        {
            txtFiled_Language.text = arr_language[0]
        }
        return arr_language[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFiled_Language.text = arr_language[row]
    }
    
    
    //MARK:- Information Action
    func btnInfoAction (sender:AnyObject)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")as! ProfileVC
        VC.phone = ((arr_searchList[sender.tag] as? NSDictionary)?.value(forKey: "cell") as? String)!
        self.navigationController?.pushViewController(VC, animated: true)
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
    
    //MARK:- New conversations Actions
    @IBAction func btn_AllActions(_ sender: AnyObject)
    {
        if sender.tag == 2001
        {
            txtField_Label.text = ""
            txtField_Cell.text = ""
            txtField_Cell.resignFirstResponder()
            viewBack_Verification.isHidden = true
        }
        else if sender.tag == 2002
        {
            if (txtFiled_Language.text?.characters.count)! > 0 && (txtField_Label.text?.characters.count)! > 0
            {
                labelContact = txtField_Label.text!
                callWbVerify()
            }
            else
            {
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"Please enter both field")
            }
        }
        else if sender.tag == 2003
        {
            txtField_Label.text = ""
            txtField_Cell.text = ""
            viewBack_Verification.isHidden = true
        }
        
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        
//        imgUserPic.image = image
//        
//        if (self.imgUserPic.image != nil){
//            imageData = UIImageJPEGRepresentation(imgUserPic.image!,0.2)! as NSData?
//            imageDataArr.append(imageData as! Data)
//        }
//        
//        var urlParameters = [String:AnyObject]()
//        var tempJson : NSString = ""
//        
//        let params = ["result":true,"user_id":UserDefaults.standard.value(forKey: loggedInUserId) as! String,"access_token":(UserDefaults.standard.value(forKey: loggedInUserAccesstokenKey) as! NSString) as String] as [String : Any]
//        
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
//            tempJson = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
//        }catch let error as NSError{
//            print(error.description)
//        }
//        
//        urlParameters = ["user_details":tempJson as AnyObject]
//        
//        //print(urlParameters)
//        
//        callWbEditProfile(view: self.view,parameters:urlParameters as NSDictionary, imageData: imageDataArr as NSArray, fileNameStr: "profile_image")
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func action_NewConversations(_ sender: Any) {
        
        if (sender as AnyObject).tag == 1301
        {
            view_backAddNewConver.isHidden = true
            txtField_Search.text = ""
            self.view.endEditing(false)
            CallWBContactList()
        }
        else
        {
            if !phoneFormatter.isValid(txtField_Cell.text!)
            {
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Please enter valid phone number")
            }
            else
            {
                callWBContactVerified()
            }
        }
    }
    
    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject)
    {
        if response is NSDictionary {
          
            if response.value(forKey: "status") as! String == "contactVerified"
            {
                if (response.value(forKeyPath: "data.confirmed") as? Bool)! == true && (response.value(forKeyPath: "data.verified") as? Bool)! == true
                {
                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Contact already exist!!")
                    self.txtField_Cell.resignFirstResponder()
                    self.txtField_Cell.text = ""
                }
                    
                else if (response.value(forKeyPath: "data.confirmed") as? Bool)! == false && (response.value(forKeyPath: "data.verified") as? Bool)! == false
                {
                    
                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Cell does not exist!!")
                    self.txtField_Cell.resignFirstResponder()
                    self.txtField_Cell.text = ""
                }
                else
                {   self.txtField_Cell.resignFirstResponder()
                   // lbl_cellNumber.text = txtField_Cell.text!
                    
                    lbl_cellNumber.text = final_str
                    view_backAddNewConver.isHidden = true
                    viewBack_Verification.isHidden = false
                }
            }
            else if response.value(forKey: "status") as! String == "Inbox"
            {
                arr_recentList = (response.value(forKeyPath: "data.recents") as? NSArray)! .mutableCopy() as! NSMutableArray
                if arr_recentList .count > 0
                {
                    tableView_Contacts.isHidden = false
                    lbl_NoAwaits.isHidden = true
                }
                else
                {
                    tableView_Contacts.isHidden = true
                    lbl_NoAwaits.isHidden = false
                }
                
                tableView_Contacts.reloadData()
                // check contact exists  in db then save
                let userDetails =  DBFunctions.sharedDBFunctions.fetchRecentfromDB()
                DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                DBFunctions.sharedDBFunctions.saveRecentsDb(arr_Recent: arr_recentList, isUpdate: true)
                
            }
            else if response.value(forKey: "status") as! String == "Await"
            {
                arr_recentList = (response.value(forKeyPath: "data.session") as? NSArray)! .mutableCopy() as! NSMutableArray
                
                if arr_recentList .count > 0
                {
                    tableView_Contacts.isHidden = false
                    lbl_NoAwaits.isHidden = true
                    for badgeView in self.tabBarController!.tabBar.subviews[1].subviews {
                        
                        if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                            badgeView.layer.transform = CATransform3DIdentity
                            badgeView.layer.transform = CATransform3DMakeTranslation(-17.0, 1.0, 1.0)
                        }
                    }
                }
                else
                {
                    tableView_Contacts.isHidden = true
                    lbl_NoAwaits.isHidden = false
                }
                tableView_Contacts.reloadData()
                let userDetails =  DBFunctions.sharedDBFunctions.fetchAwaitList()
                DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                DBFunctions.sharedDBFunctions.saveAwaitsList(arr_await: arr_recentList, isUpdate: true)
            }
            else if response.value(forKey: "status") as! String == "SearchList"
            {
                
                arr_recentList.removeAllObjects()
                arr_searchList.removeAllObjects()
                arr_searchList = (response.value(forKeyPath: "data.matches") as? NSArray)! .mutableCopy() as! NSMutableArray
                
                tableView_Contacts .reloadData()

                if arr_searchList.count == 0
                {
                    let alertView: UIAlertController = UIAlertController(title: "TextMaxxPro", message: "Contact Not Found!!", preferredStyle: .alert)
                    
            let addContactAction: UIAlertAction = UIAlertAction(title: "Add Contact", style: .default)
                    { action -> Void in
                        self.txtField_Search.resignFirstResponder()
                        // self.txtField_Cell.becomeFirstResponder()
                        self.view_backAddNewConver.isHidden = false
                    }
                    alertView.addAction(addContactAction)
                    let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                        self.view.endEditing(false)
                        self.txtField_Search.text = ""
                        self.CallWBContactList()
                    }
                    alertView.addAction(cancelActionButton)
                    self.present(alertView, animated: true, completion: nil)
                }
                
            }
            else if response.value(forKey: "status") as! String == "Contact"
            {
              //  arr_recentList.removeAllObjects()
                self.view .endEditing(false)
              //  txtField_Cell.resignFirstResponder()
                arr_searchList.removeAllObjects()
                tableView_Contacts.isHidden = false
                arr_searchList = (response.value(forKeyPath: "data.matches") as? NSArray)! .mutableCopy() as! NSMutableArray
                let userDetails =  DBFunctions.sharedDBFunctions.fetchContactfromDB()
                DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                DBFunctions.sharedDBFunctions.saveContactsDb(arr_contact: arr_searchList, isUpdate: true)
                tableView_Contacts .reloadData()
            }
            else if response.value(forKey: "status") as? String == "1a"
            {
                txtField_Label.text = ""
                CallWBContactList()
                txtField_Search.text = ""
                txtField_Cell.text = ""
           //     contactBoolSearch = false
               txtField_Search.resignFirstResponder()
                
                viewBack_Verification.isHidden = true
            //    tableView_Contacts.reloadData()
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"Success")
            }
            else
            {
               if (response.value(forKeyPath: "data.error") as? String)! == ""
               {
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatDetailVC")as! chatDetailVC
                 VC.str_NameTitle = txtField_Label.text!
                VC.str_NameTitle = labelContact

                VC.contactNumber = final_str
                self.navigationController?.pushViewController(VC, animated: true)
                }
                else
               {
                viewBack_Verification.isHidden = true
                view_backAddNewConver.isHidden = true

                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: (response.value(forKeyPath: "data.error") as? String)!)
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
        txtField_Cell.text = ""
        txtField_Label.text = ""
        viewBack_Verification.isHidden = true
        view_backAddNewConver.isHidden = true
//        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message:"We apologize but communication is restricted to the hours of 8AM to 9PM !!")
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
