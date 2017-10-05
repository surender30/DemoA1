//
//  FindUserVC.swift
//  TextMaxx Pro
//
//  Created by surender on 14/11/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

class FindUserVC: UIViewController,UITableViewDataSource,UITableViewDelegate,BaseBLDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK:- OUTLETS

    @IBOutlet var lbl_Contact: UILabel!
    @IBOutlet var txtfield_creditCard: UITextField!
    @IBOutlet var lbl_Name: UILabel!
    @IBOutlet var lbl_addYou: UILabel!
    @IBOutlet var view_backAddContact: UIView!
    @IBOutlet weak var txtField_Search: UITextField!
    @IBOutlet weak var tableView_FindUser: UITableView!
    @IBOutlet var btnPromoOutlet: UIButton!
    @IBOutlet var btnAccountOutlet: UIButton!
    @IBOutlet var btnBothOutlet: UIButton!
    
    // MARK:- VARIABLES
    var arr_contactList = NSMutableArray()
    var str_Account = String()
    var str_Marketing = String()
    var contacts: [NSManagedObject] = []
    var contactBoolSearch : Bool = false
    var arr_language = ["English","Spanish"]
    var arr_contactListFalse = NSMutableArray()

    //MARK:- DidLoad & WillAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        btnBothOutlet.isSelected = true
        str_Account = "true"
        str_Marketing = "true"
        
        view_backAddContact.isHidden = true
        CallWBContactList1()
        self.setupMenuBarButtonItems()
        
        txtField_Search.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        txtField_Search.text = ""
        contactBoolSearch = false
        self.navigationController?.navigationBar.isHidden = true
        view_backAddContact.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
    }
    
    //MAKR:- Back Action
    @IBAction func btnBack_Action(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    //MARK:- TextField Deleage & DataSource
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pickerView = UIPickerView()
        txtfield_creditCard.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    }
    
    func textFieldDidChange()
    {
        if (txtField_Search.text?.characters.count)! >= 4
        {
            contactBoolSearch = true
            self.callWBSearch(strSearch: txtField_Search.text!)
        }
        else if txtField_Search.text?.characters.count == 0 {
         //   txtField_Search.resignFirstResponder()
            contactBoolSearch = false
            self.CallWBContactList()
        }
    }
    
    //MARK:- Menu Items
    
    func setupMenuBarButtonItems () {
        self.navigationItem.leftBarButtonItem = self.leftMenuBarButtonItem()
    }
    
    func leftMenuBarButtonItem () -> UIBarButtonItem {
        let leftMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "left-icon"), style: .plain, target: self, action: #selector(ChangePasswordVC.btnLeftMenuClicked))
        
        leftMenu.tintColor = UIColor.white
        return leftMenu
    }
    
    func btnLeftMenuClicked() {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_AllActions(_ sender: AnyObject)
    {
        if sender.tag == 1001
        {
            view_backAddContact.isHidden = true
        }
        else if sender.tag == 1002
        {
            if (txtfield_creditCard.text?.characters.count)! > 0
            {
                callWbVerify()
            }
            else
            {
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"Please select atleast one language")
            }
        }
        else if sender.tag == 1003
        {
            view_backAddContact.isHidden = true
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
            
            loginBL.verify(self.view, cell: lbl_Contact.text!, account: str_Account, marketing: str_Marketing, label:lbl_Name.text!, Language: txtfield_creditCard.text!)
        }
    }
    
    func CallWBContactList1()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchContactfromDB()
           // print(userDetails)
            
            arr_contactList.removeAllObjects()
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
              //  print(dic)
                
                if verified == "false"
                {
                    arr_contactList.add(dic)
                }
            }
            tableView_FindUser .reloadData()
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.contactList(self.view)
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
    
    func CallWBContactList()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchContactfromDB()
           // print(userDetails)
            
            arr_contactList.removeAllObjects()
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
           //     print(dic)
                
                if verified! == "false"
                {
                    arr_contactList.add(dic)
                }
                
                //  arr_contactListTrue.add(dic)
            }
            tableView_FindUser.reloadData()
            
            
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.contactList(self.view)
        }
    }
    
    //MARK:- PickerView Delegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arr_language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0
        {
            txtfield_creditCard.text = arr_language[0]
        }
         return arr_language[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtfield_creditCard.text = arr_language[row]
    }
    
    
    //MARK:- TableView delegate & datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_contactList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath as IndexPath) as! FinsUserCell
        tableCell.lbl_Name.text = ((arr_contactList.object(at: indexPath.row)as! NSDictionary).value(forKey: "label")as! NSString) as String
                
        tableCell.btn_AddUser.addTarget(self, action: #selector(FindUserVC.adduserAction(sender:)), for: .touchUpInside)
        tableCell.btn_AddUser.tag = indexPath.row
        
        if indexPath.row % 2 == 0
        {
            tableCell.backgroundColor = UIColor.init(colorLiteralRed: 238/255, green: 246/255, blue: 254/255, alpha: 1)
        }
        else{
            tableCell.backgroundColor = UIColor.white
        }
        
        if ((arr_contactList.object(at: indexPath.row)as! NSDictionary).value(forKey: "verified")as! NSString) as String == "false"
        {
            tableCell.btn_AddUser .setBackgroundImage(UIImage(named:"addition"), for: UIControlState.normal)
            tableCell.btn_AddUser.isUserInteractionEnabled = false
        }
        else
        {
            tableCell.btn_AddUser .setBackgroundImage(UIImage(named:"info-1"), for: UIControlState.normal)
            tableCell.btn_AddUser.isUserInteractionEnabled = true
        }
        return tableCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        txtField_Search .resignFirstResponder()
        
        if ((arr_contactList.object(at: indexPath.row)as! NSDictionary).value(forKey: "verified")as! NSString) as String == "false"
        {
            lbl_Name.text = ((arr_contactList.object(at: indexPath.row)as! NSDictionary).value(forKey: "label")as! NSString) as String
            lbl_Contact.text = ((arr_contactList.object(at: indexPath.row)as! NSDictionary).value(forKey: "cell")as! NSString) as String
            view_backAddContact.isHidden = false

        }
        else
        {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatDetailVC")as! chatDetailVC
            VC.str_NameTitle = ((arr_contactList[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)!
            VC.contactNumber = ((arr_contactList[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
            self.navigationController?.pushViewController(VC, animated: true)

        }
    }

    //MARK:- Add new user Action
    func adduserAction (sender:AnyObject)
    {
        // view_backAddContact.isHidden = false
        
        if ((arr_contactList.object(at: sender.tag)as! NSDictionary).value(forKey: "verified")as! NSString) as String == "true"
        {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")as! ProfileVC
            VC.phone = ((arr_contactList[sender.tag] as? NSDictionary)?.value(forKey: "cell") as? String)!
            self.navigationController?.pushViewController(VC, animated: true)

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
    
    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        if response is NSDictionary {
            
            if response.value(forKey: "status") as? String == "1a"
            {
                txtField_Search.resignFirstResponder()
                view_backAddContact.isHidden = true
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message:"Sucess")
            }
            else
            {
                if contactBoolSearch == true
                {
                   // txtField_Search.resignFirstResponder()
                    arr_contactList.removeAllObjects()
                    arr_contactList = (response.value(forKey: "matches") as? NSArray)! .mutableCopy() as! NSMutableArray
                    tableView_FindUser .reloadData()
                 //   print(arr_contactList)
                }
                else
                {
                    arr_contactList.removeAllObjects()
                //    arr_contactListFalse.removeAllObjects()
                    arr_contactList = (response.value(forKeyPath: "data.matches") as? NSArray)! .mutableCopy() as! NSMutableArray
                    
//                    for i in 0..<arr_contactList.count
//                    {
//                        if ((arr_contactList.object(at: i)as! NSDictionary).value(forKey: "verified")as! NSString) as String == "false"
//                            
//                        {
//                            arr_contactListFalse.add(arr_contactList.object(at: i) as! NSDictionary)
//                            print(arr_contactListFalse)
//                        }
//                    }
                    
                    // check contact exists  in db then save
                    let userDetails =  DBFunctions.sharedDBFunctions.fetchContactfromDB()
                    DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                    DBFunctions.sharedDBFunctions.saveContactsDb(arr_contact: arr_contactList, isUpdate: true)
                    tableView_FindUser .reloadData()
                }
            }
            
           
        }
    }
    
    func failureResponseReceived (_ response:AnyObject) {
        // Error received in response.
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "", message: "\(response)")
    }
    
    func noDataReceived () {
        view_backAddContact.isHidden = true

//        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message:"We apologize but communication is restricted to the hours of 8AM to 9PM !!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
