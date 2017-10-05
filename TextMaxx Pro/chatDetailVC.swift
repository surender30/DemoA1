//
//  chatDetailVC.swift
//  TextMaxx Pro
//
//  Created by Surender on 08/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage


class chatDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource,BaseBLDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate
{
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK:- Outlets
    @IBOutlet var sendButton: UIButton!
    @IBOutlet weak var btnShape: UIButton!
    @IBOutlet weak var txtfield_Payment: UITextField!
    @IBOutlet weak var txtfield_CreditCard: UITextField!
    @IBOutlet weak var viewBack_Payment: UIView!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var growingTextView: NextGrowingTextView!
    @IBOutlet var view_backBG: UIView!
    @IBOutlet weak var tableview_Chat: UITableView!
    @IBOutlet var tableview_template: UITableView!
    @IBOutlet var btn_connect: UIButton!
    @IBOutlet var btn_Link: UIButton!
    @IBOutlet var btn_Call: UIButton!
    @IBOutlet var btn_Payment: UIButton!
    var operationQueue: OperationQueue = OperationQueue()

    //MARK:-Varriables
    
    @IBOutlet var shareImageView: UIView!
    @IBOutlet var shareImage: UIImageView!
    var isImagePickerSelected : Bool = false
    var str_NameTitle = String()
    var pickerIndex : Int = 0
    var contactNumber = String()
    var arr_templates = NSMutableArray()
    var arr_Cards = NSMutableArray()
    var payment_token = String()
    var str_messageID : String = "0"
    var str_occured : String = "after"
    var msgEarlierBool : Bool = false
    var newMsgSend : Int = 0
    var msgSendBool : Bool = false
    var arr_values = NSMutableArray()
    var msdSendSucce : Bool = false
    
    @IBOutlet var btnCross: UIButton!
    var isSelectBtnCross : Bool = false
    
    @IBOutlet var scrollViewImageShare: UIScrollView!
    
    //Mark:- Didload & willAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        
       shareImageView.isHidden = true
        arrayTagPeople.sharedInstance.removeAllObjects()
        self.setupMenuBarButtonItems()
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        tableview_Chat.estimatedRowHeight = 280
        tableview_Chat.rowHeight = UITableViewAutomaticDimension
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(chatDetailVC.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(chatDetailVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.growingTextView.layer.cornerRadius = 4
    
        self.growingTextView.backgroundColor = UIColor.white
        self.growingTextView.textContainerInset = UIEdgeInsets(top: 12, left: 0, bottom: 10, right: 0)
        self.growingTextView.placeholderAttributedText = NSAttributedString(string: "Type here message...",
                                                                            attributes: [NSFontAttributeName: self.growingTextView.font!,
                                                                                         NSForegroundColorAttributeName: UIColor.gray
            ]
        )
        
        
        self.growingTextView.delegates.textViewDidBeginEditing = { (growingTextView: NextGrowingTextView) in
            // Do something
            self.self.tableview_Chat.contentOffset = CGPoint(x: 0,y :self.tableview_Chat.contentSize.height-235)
        }
        UserDefaults.standard.set("false", forKey: "Comment")

        // ** PICKER VIEW **
        
        let pickerView          = UIPickerView()
        txtfield_CreditCard.inputView = pickerView
        pickerView.delegate     = self
        pickerView.dataSource   = self
        pickerView.reloadAllComponents()
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(chatDetailVC.methodForPush),
            name: NSNotification.Name(rawValue: "Chat"),
            object: nil)
    }
    
    
    @IBAction func dismissImageView(_ sender: Any) {
        tableViewScrollToBottom(animated: false)
        scrollViewImageShare.zoomScale = 1.0
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.isStatusBarHidden = false
        shareImageView.isHidden = true
    }
    
    func methodForPush()
    {
        if UserDefaults.standard.bool(forKey: "Chat") == true
        {
            contactNumber = UserDefaults.standard.value(forKey: "cell") as! String
            str_NameTitle = UserDefaults.standard.value(forKey: "label") as! String
            self.navigationItem.title = str_NameTitle

        }
         callWbInboxMessages()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false

        if isImagePickerSelected == false{
            //        let bottomoffset: CGPoint = CGPoint(x: 0, y: tableview_Chat.bounds.size.height-tableview_Chat.contentSize.height)
            //
            //        if bottomoffset.y > 0 {
            //            //  tableview_Chat.contentOffset = bottomoffset;
            //            tableview_Chat .setContentOffset(bottomoffset, animated: false)
            //        }
            tableViewScrollToBottom(animated: false)
            
            operationQueue.maxConcurrentOperationCount = 5
            super.viewWillAppear(true)
            
            if UserDefaults.standard.bool(forKey: "Chat") == true
            {
                contactNumber = UserDefaults.standard.value(forKey: "cell") as! String
                str_NameTitle = UserDefaults.standard.value(forKey: "label") as! String
            }
            
            let decimalCharacters = CharacterSet.decimalDigits
            let decimalRange = str_NameTitle.rangeOfCharacter(from: decimalCharacters)
            
            if decimalRange != nil {
                self.navigationItem.title = str_NameTitle.tochangePhoneNumber()
            }
            else{
                self.navigationItem.title = str_NameTitle
            }
            
            operationQueue.addOperation(self.getOperation1())
            operationQueue.addOperation(self.getOperation3())
            // operationQueue.addOperation(self.getOperation4())
            // operationQueue.addOperation(self.getOperation5())
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if isImagePickerSelected == false
        {
            UserDefaults.standard.set(false, forKey: "Chat")
            tableview_Chat.delegate = nil
            tableview_Chat.dataSource = nil
            
        }
    }
    
    //MARK:- operation queue
    func getOperation1() -> Operation {
        let operation: Operation = BlockOperation { () -> Void in
            self.callWBContactVerified()
        }
        
        return operation
    }
    
    func getOperation2() -> Operation {
        let operation: Operation = BlockOperation { () -> Void in
             self.callWbInboxMessages()
        }
        
        return operation
    }
    
    func getOperation3() -> Operation {
        let operation: Operation = BlockOperation { () -> Void in
             self.callWBContactVerified()
        }
        
        return operation
    }
    
    func getOperation4() -> Operation {
        let operation: Operation = BlockOperation { () -> Void in
             self.callWbTemplate()
        }
        return operation
    }
    
    func getOperation5() -> Operation {
        let operation: Operation = BlockOperation { () -> Void in
             self.callWbCardType()
        }
        return operation
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
        
        if let viewControllers = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController.isKind(of: InboxVC.self)
                {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
                else if viewController.isKind(of: ContactsVC.self)
                {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
                else if viewController.isKind(of: HomeVC.self)
                {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }
        

        
        
      //  self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -TextFieldDelegate
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count > 0
        {
            sendButton .isUserInteractionEnabled = true
        }
        else
        {
            sendButton .isUserInteractionEnabled = false
        }
    }

    //MARK: - View touch Action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Call Wb
    func callWbProfile()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            arr_values.removeAllObjects()
            let userDetails =  DBFunctions.sharedDBFunctions.fetchProfileData(cell: contactNumber)
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
                arr_values.add(dic)
            }
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.profileFetch(_onView: self.view, phonestr: contactNumber)
        }
        
    }
    
    func  callWBContactVerified()
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
            loginBL.contactVerified(self.view, cell: contactNumber)
        }
    }
    
    // ****** Template Web Api Call ******//
    
    func callWbTemplate()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchTemplatefromDB()
          //  print(userDetails)
            
            arr_templates.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                
                let id = userDetails[i].value(forKey: "id") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                let owned = userDetails[i].value(forKey: "owned") as? String
                let tags = userDetails[i].value(forKey: "tags") as? NSArray
                
                dic.setValue(id!, forKey:  "id")
                dic .setValue(label!, forKey: "label")
                dic .setValue(owned!, forKey: "owned")
                dic .setValue(tags!, forKey: "tags")
                print(dic)
                arr_templates.add(dic)
            }
            
            tableview_template.reloadData()
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.template(self.view, type: "account", source: "own", broadCast:"all")
        }
    }
    // ****** card Web Api Call ******//


    func callWbCardType()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchAccountsData()
            arr_Cards.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                
                let customer = userDetails[i].value(forKey: "customer") as? String
                let holder = userDetails[i].value(forKey: "holder") as? String
                let issuer = userDetails[i].value(forKey: "issuer") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                let last_four = userDetails[i].value(forKey: "last_four") as? String
                let token = userDetails[i].value(forKey: "token") as? String
                let type = userDetails[i].value(forKey: "type") as? String

                dic.setValue(customer!, forKey:  "customer")
                dic .setValue(holder!, forKey: "holder")
                dic .setValue(issuer!, forKey: "issuer")
                dic .setValue(label!, forKey: "label")
                dic .setValue(last_four!, forKey: "last_four")
                dic .setValue(token!, forKey: "token")
                dic .setValue(type!, forKey: "type")
                
                arr_Cards.add(dic)
            }
            
            tableview_template.reloadData()
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.creditCardType(self.view, cell: contactNumber)
        }
    }
    
    func callWbSendPayment()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchTemplatefromDB()
            print(userDetails)
            
            arr_templates.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                
                let id = userDetails[i].value(forKey: "id") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                let owned = userDetails[i].value(forKey: "owned") as? String
                let tags = userDetails[i].value(forKey: "tags") as? NSArray
                
                dic.setValue(id!, forKey:  "id")
                dic .setValue(label!, forKey: "label")
                dic .setValue(owned!, forKey: "owned")
                dic .setValue(tags!, forKey: "accountNumber")
               // print(dic)
                
                arr_templates.add(dic)
                
            }
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            loginBL.sendPayemnt(self.view, cell: contactNumber, amount: txtfield_Payment.text!, token: payment_token, note: "", reference: "", batch: "")
        }
    }
    
    func CallWBSendMessage(message: String)
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
            loginBL.sendMessage(self.view, phonestr: contactNumber, message: message)
        }
    }
    
    func CallWBMessagesList()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            
            self.sendButton.isUserInteractionEnabled = false
            let userDetails =  DBFunctions.sharedDBFunctions.fetchChatList(cell: contactNumber)
            
            arrayTagPeople.sharedInstance.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                let c = userDetails[i].value(forKey: "c") as? String
                let direction = userDetails[i].value(forKey: "direction") as? String
                let id = userDetails[i].value(forKey: "id") as? String
                let k = userDetails[i].value(forKey: "k") as? String
                let m = userDetails[i].value(forKey: "m") as? String
                let message = userDetails[i].value(forKey: "message") as? String
                
                let p = userDetails[i].value(forKey: "p") as? String
                let r = userDetails[i].value(forKey: "r") as? String
                let sender = userDetails[i].value(forKey: "sender") as? String
                let sent = userDetails[i].value(forKey: "sent") as? String
                let utc = userDetails[i].value(forKey: "utc") as? String
                let v = userDetails[i].value(forKey: "v") as? String
                let cell = userDetails[i].value(forKey: "cell") as? String
                
                dic.setValue(c!, forKey:  "c")
                dic.setValue(direction!, forKey:  "direction")
                dic.setValue(id!, forKey:  "id")
                dic.setValue(k!, forKey:  "k")
                dic.setValue(m!, forKey:  "m")
                dic.setValue(message!, forKey:  "message")
                dic.setValue(p!, forKey:  "p")
                dic.setValue(r!, forKey:  "r")
                dic.setValue(sender!, forKey:  "sender")
                dic.setValue(sent!, forKey:  "sent")
                dic .setValue(utc!,  forKey:  "utc")
                dic .setValue(v!,  forKey:  "v")
                dic .setValue(cell!,    forKey: "cell")
               // print(dic)
                
                arrayTagPeople.sharedInstance.add(dic)
            }
            tableview_Chat.reloadData()
            
        default:
            // Hit login WS.
            self.sendButton.isUserInteractionEnabled = true
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            //           loginBL.messageList(self.view, phonestr: "13300012", messageID: "0",occu)
            loginBL.messageList(self.view, phonestr: contactNumber, messageID: str_messageID, occured: str_occured)
        }
    }

    func callWbInboxMessages()
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
            loginBL.inboxMessagefromchat(self.view, cell: contactNumber)
        }
    }
    
    func callWbImageStore(enocdedStr:String){
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
            loginBL.StoreImageFile(self.view, encodedStr: enocdedStr)
        }
        
    }

    //MARK:- PICKER VIEW DELGATE AND Datasource
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return arr_Cards.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0
        {
            txtfield_CreditCard.text = (arr_Cards[0] as! NSDictionary).value(forKey: "label") as! String?
            payment_token = ((arr_Cards[0] as! NSDictionary).value(forKey: "token") as! String?)!
        }
        return (arr_Cards[row] as! NSDictionary).value(forKey: "label") as! String?
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerIndex = row
        payment_token = ((arr_Cards[row] as! NSDictionary).value(forKey: "token") as! String?)!
        txtfield_CreditCard.text = (arr_Cards[row] as! NSDictionary).value(forKey: "label") as! String?
    }
    
    //MARK: TableViewDelegae & DataSources
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   //  + .milliseconds(300)
    func tableViewScrollToBottom(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let numberOfSections = self.tableview_Chat.numberOfSections
            let numberOfRows = self.tableview_Chat.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.tableview_Chat.delegate = self
                self.tableview_Chat.dataSource = self
                self.tableview_Chat.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tableview_template{
            return arr_templates.count
        }
        else{
            return arrayTagPeople.sharedInstance.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell
    {
        if tableView == tableview_template{
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell.textLabel?.text = (arr_templates[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String
            return cell
        }
        else{
            
            if indexPath.row == 0{
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Loading Cell")
                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
                activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray;
                activityIndicator.startAnimating()
                return cell
                
            }
            else{
                if (arrayTagPeople.sharedInstance.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "direction") as? String == "out"
                {
                    let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath as IndexPath) as! LeftCell
                    
                    tableCell.lbl_outMessage.text = (arrayTagPeople.sharedInstance.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "message") as? String
                    
                    let message = (arrayTagPeople.sharedInstance.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "message") as? String
                    
                    tableCell.lbl_outMessage.tag = indexPath.row
                    if validateUrl(urlString: message)
                    {
                        let tap = UITapGestureRecognizer(target: self, action: #selector(chatDetailVC.tapFunction(sender:)))
                        tap.numberOfTapsRequired = 1
                        tap.delegate = self
                        tableCell.lbl_outMessage.isUserInteractionEnabled = true
                        tableCell.lbl_outMessage.addGestureRecognizer(tap)
                    }
                    else
                    {
                        tableCell.lbl_outMessage.isUserInteractionEnabled = false
                    }
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    let dateA = dateFormatter.date(from: ((arrayTagPeople.sharedInstance[indexPath.row] as? NSDictionary)?.value(forKey: "sent") as? String)!)
                    
                   
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "dd, MMM yyyy hh:mm a"
                    let strA = dateFormatter1.string(from: dateA!)
                    tableCell.lbl_outTime.text = strA
                    
                    if (arrayTagPeople.sharedInstance.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "c") as? Bool == true
                    {
                        tableCell.img_bubleLeft.image = UIImage(named:"yellow-chatbox")
                        tableCell.lbl_outMessage.textColor = UIColor.black
                    }
                    else
                    {
                        tableCell.img_bubleLeft.image = UIImage(named:"user-2-chatbox")
                        tableCell.lbl_outMessage.textColor = UIColor.white
                        
                        
                    }
                    return tableCell
                }
                else{
                    let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath as IndexPath) as! RightCell
                    tableCell.lbl_outMessage.text = (arrayTagPeople.sharedInstance.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "message") as? String
                    
                    
                    let message = (arrayTagPeople.sharedInstance.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "message") as? String
                    
                    tableCell.lbl_outMessage.tag = indexPath.row
                    if validateUrl(urlString: message)
                    {
                        let tap = UITapGestureRecognizer(target: self, action: #selector(chatDetailVC.tapFunction(sender:)))
                        tap.numberOfTapsRequired = 1
                        tap.delegate = self
                        tableCell.lbl_outMessage.isUserInteractionEnabled = true
                        tableCell.lbl_outMessage.addGestureRecognizer(tap)
                    }
                    else
                    {
                        tableCell.lbl_outMessage.isUserInteractionEnabled = false
                    }

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    let dateA = dateFormatter.date(from: ((arrayTagPeople.sharedInstance[indexPath.row] as? NSDictionary)?.value(forKey: "sent") as? String)!)
                    
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "dd, MMM yyyy hh:mm a"
                    let strA = dateFormatter1.string(from: dateA!)
                    
                    tableCell.lbl_outTime.text = strA
                    
                    if (arrayTagPeople.sharedInstance.object(at: indexPath.row) as? NSDictionary)?.value(forKey: "c") as? Bool == true
                    {
                        tableCell.lbl_outMessage.textColor = UIColor.yellow
                    }
                    else
                    {
                        tableCell.lbl_outMessage.textColor = UIColor.white
                    }
                    return tableCell
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableview_template
        {
            self.growingTextView.text =  (arr_templates[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String
            view_backBG.isHidden = true
        }
    }
    
    
    //MARK:- scrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if msgEarlierBool == false{
            if tableview_Chat.contentOffset.y == 0
            {
                refresh()
            }
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return shareImage
    }
    
    //MARK: - Tap gesture for image zoom Action
    
    func tapFunction(sender:UITapGestureRecognizer) {
        
        self.growingTextView.resignFirstResponder()
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.isStatusBarHidden = true
        shareImageView.isHidden = false
        let lblMessage = sender.view as! UILabel
        let messageUrl = (arrayTagPeople.sharedInstance.object(at: lblMessage.tag) as? NSDictionary)?.value(forKey: "message") as? String
        
        shareImage.setIndicatorStyle(.whiteLarge)
        shareImage.setShowActivityIndicator(true)
        
        scrollViewImageShare.minimumZoomScale = 1
        scrollViewImageShare.maximumZoomScale = 3
        scrollViewImageShare.bounces=false
        scrollViewImageShare.delegate = self
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(chatDetailVC.signletapGesture))
        tapGesture1.numberOfTapsRequired = 1
        scrollViewImageShare.addGestureRecognizer(tapGesture1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chatDetailVC.pinchedView))
        tapGesture.numberOfTapsRequired = 2
        scrollViewImageShare.addGestureRecognizer(tapGesture)
        scrollViewImageShare.contentSize = shareImage.frame.size
        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(chatDetailVC.pinchedView))
//        shareImage.isUserInteractionEnabled = true
//        shareImage.addGestureRecognizer(pinchGesture)
        shareImage.sd_setImage(with: URL(string: messageUrl!), placeholderImage: UIImage(named: ""))
    }
    
    func pinchedView(sender:UITapGestureRecognizer){
        if (scrollViewImageShare.zoomScale > scrollViewImageShare.minimumZoomScale) {
            scrollViewImageShare.setZoomScale(scrollViewImageShare.minimumZoomScale, animated: true)
            btnCross.isHidden = false
        } else {
            btnCross.isHidden = true
            let touchPoint = sender.location(in: view)
            let scrollViewSize = scrollViewImageShare.bounds.size
            let width = scrollViewSize.width / scrollViewImageShare.maximumZoomScale
            let height = scrollViewSize.height / scrollViewImageShare.maximumZoomScale
            let x = touchPoint.x - (width/2.0)
            let y = touchPoint.y - (height/2.0)
            let rect = CGRect(x: x, y: y, width: width, height: height)
            scrollViewImageShare.zoom(to: rect, animated: true)
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func centerScrollViewContents(){
        
        if scrollViewImageShare.zoomScale > 1 {
            btnCross.isHidden = true
            if let image = shareImage.image {
                let ratioW = shareImage.frame.width / image.size.width
                let ratioH = shareImage.frame.height / image.size.height
                let ratio = ratioW < ratioH ? ratioW:ratioH
                
                let newWidth = image.size.width*ratio
                let newHeight = image.size.height*ratio
                
                let left = 0.5 * (newWidth * scrollViewImageShare.zoomScale > shareImage.frame.width ? (newWidth - shareImage.frame.width) : (scrollViewImageShare.frame.width - scrollViewImageShare.contentSize.width))
                let top = 0.5 * (newHeight * scrollViewImageShare.zoomScale > shareImage.frame.height ? (newHeight - shareImage.frame.height) : (scrollViewImageShare.frame.height - scrollViewImageShare.contentSize.height))
                scrollViewImageShare.contentInset = UIEdgeInsetsMake(top, left, top, left)
            }
        } else {
            btnCross.isHidden = false
            scrollViewImageShare.contentInset = UIEdgeInsets.zero
        }
    }
    
    func signletapGesture(sender:UITapGestureRecognizer){
        
        if isSelectBtnCross == false{
            isSelectBtnCross = true
            btnCross.isHidden = true
        }
        else
        {
            isSelectBtnCross = false
            btnCross.isHidden = false
        }
    }
    
    //MARK: Top Actions
    @IBAction func btnAll(_ sender: Any) {
        if (sender as AnyObject).tag == 1101
        {
            if UserDefaults.standard.bool(forKey: "Comment") == false{
                UserDefaults.standard.set("true", forKey: "Comment")
                btnShape.backgroundColor = UIColor(red: (82/255), green: (154/255), blue: (208/255), alpha: 1.0)
            }
            else
            {
                UserDefaults.standard.set("false", forKey: "Comment")
                btnShape.backgroundColor = UIColor.clear
            }
            
        }
        else if (sender as AnyObject).tag == 1102
        {
            self.growingTextView.resignFirstResponder()
            
            
            if arr_templates.count > 0
            {
                view_backBG.isHidden = false
            }
            else
            {
                view_backBG.isHidden = true
                 CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "No Template added")
            }
        }
        else if (sender as AnyObject).tag == 1103
        {
            self.growingTextView.resignFirstResponder()
//            self.growingTextView.text =  (arr_values[0] as? NSDictionary)?.value(forKey: "web") as? String
                //Create the AlertController and add Its action like button in Actionsheet
                let actionSheetControllerIOS: UIAlertController = UIAlertController(title: "TextMaxxPro", message: "Image Share", preferredStyle: .actionSheet)
                let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                }
                actionSheetControllerIOS.addAction(cancelActionButton)
                let cameraActionButton: UIAlertAction = UIAlertAction(title: "Camera", style: .default)
                { action -> Void in
                    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                        imagePicker.allowsEditing = true
                        self.isImagePickerSelected = true
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
                actionSheetControllerIOS.addAction(cameraActionButton)
                let galleryActionButton: UIAlertAction = UIAlertAction(title: "Library", style: .default)
                { action -> Void in
                    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                        imagePicker.allowsEditing = true
                        self.isImagePickerSelected = true
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
                actionSheetControllerIOS.addAction(galleryActionButton)
                self.present(actionSheetControllerIOS, animated: true, completion: nil)
        }
        else if (sender as AnyObject).tag == 1104
        {
            if arr_values.count > 0
            {
                let cellNumber = ((arr_values[0] as? NSDictionary)?.value(forKey: "ivr") as? String)!
                
                let phone = cellNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
                
               // print(phone)
                
                if let url = URL(string: "telprompt://\(phone)") {
                    UIApplication.shared.openURL(url)
                }
            }
        }
            
        else if (sender as AnyObject).tag == 1105
        {
            inputContainerView.isHidden = true
             NotificationCenter.default.addObserver(self, selector: #selector(chatDetailVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            self.growingTextView.resignFirstResponder()
            IQKeyboardManager.sharedManager().enableAutoToolbar = true
            if arr_Cards.count > 0
            {
                viewBack_Payment.isHidden = false
                inputContainerView.isHidden = true
            }
            else{
                inputContainerView.isHidden = false
                IQKeyboardManager.sharedManager().enableAutoToolbar = false
                CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "No acccount added")
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        isImagePickerSelected = true
        let image  = info[UIImagePickerControllerEditedImage] as! UIImage
        let imageData : Data = UIImageJPEGRepresentation(image, 0.2)! as Data
        let strBase64 = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let escapedString = strBase64.addingPercentEncoding(withAllowedCharacters:.whitespaces)
        
        callWbImageStore(enocdedStr: escapedString!)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isImagePickerSelected = false
        dismiss(animated: true, completion: nil)
    }
    
   
    //MARK: Messages More Loading
    func refresh() {
        // Code to refresh table view
        
        msgEarlierBool = true
        str_occured = "before"
        if arrayTagPeople.sharedInstance.count > 0
        {
            str_messageID =  String(describing: ((arrayTagPeople.sharedInstance .object(at: 0) as? NSDictionary)?.value(forKey: "id"))!)
            
            CallWBMessagesList()
        }
    }
    
    //MARK: -Payment send Actions
    @IBAction func paymentActions(_ sender: Any) {
        
        if (sender as AnyObject).tag == 1201
        {
            IQKeyboardManager.sharedManager().enableAutoToolbar = false
            viewBack_Payment.isHidden = true
            inputContainerView.isHidden = false
            
        }
        else if (sender as AnyObject).tag == 1202
        {
            IQKeyboardManager.sharedManager().enableAutoToolbar = false
            viewBack_Payment.isHidden = true
            inputContainerView.isHidden = false
        }
        else if (sender as AnyObject).tag == 1203
        {
            callWbSendPayment()
        }
    }
    
    //MARK: Message Send & handle actions
    @IBAction func messageSnedAction(_ sender: Any) {
        if self.growingTextView.text.characters.count > 0
        {
            msgSendBool = true
            str_occured = "after"
            CallWBSendMessage(message: self.growingTextView.text)
            self.growingTextView.text = ""
        }
        else
        {
              CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Please enter text")
        }
    }
    
    
    @IBAction func handleSendButton(_ sender: AnyObject) {
        self.growingTextView.text = ""
        self.view.endEditing(true)
    }
    
    //MARK- Hide View Action
    @IBAction func btnCrossAction(_ sender: Any) {
        view_backBG.isHidden = true
    }
    
    //MARK:- Keyboard hide & show Actions
    func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                //key point 0,
                self.inputContainerViewBottom.constant =  0
                //textViewBottomConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    
    func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.inputContainerViewBottom.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

    //MARK:- url check
    
    func validateUrl (urlString: String?) -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }
    
    
    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        if response is NSDictionary {
    
            if response.value(forKey: "status") as! String == "contactVerified"
            {
                if (response.value(forKeyPath: "data.verified") as? Bool)! == true
                {
                    msgEarlierBool = false
                    btnShape.isUserInteractionEnabled = true
                    btn_Call.isUserInteractionEnabled = true
                    btn_connect.isUserInteractionEnabled = true
                    btn_Payment.isUserInteractionEnabled = true
                    tableview_Chat.isScrollEnabled = true
                    operationQueue.addOperation(self.getOperation2())
                }
                else
                {
                    msgEarlierBool = true
                    sendButton.isUserInteractionEnabled = false
                     CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Pending Opt In By Cell User")
                    btnShape.isUserInteractionEnabled = false
                    btn_Call.isUserInteractionEnabled = false
                    btn_connect.isUserInteractionEnabled = false
                    btn_Payment.isUserInteractionEnabled = false
                    tableview_Chat.isScrollEnabled = false
                }
            }
            else if response.value(forKey: "status") as! String == "Template"
            {
                arr_templates = ((response.value(forKeyPath: "data.templates") as? NSArray)! .mutableCopy() as! NSMutableArray)
                tableview_template.reloadData()
                
                let userDetails =  DBFunctions.sharedDBFunctions.fetchTemplatefromDB()
                DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                
                DBFunctions.sharedDBFunctions.saveTemplatesDb(arr_Template: arr_templates, isUpdate: true)
            }
            else if response.value(forKey: "status") as! String == "CreditCards"
            {
                arr_Cards = ((response.value(forKeyPath: "data.accounts") as? NSArray)! .mutableCopy() as! NSMutableArray)
                
                let userDetails =  DBFunctions.sharedDBFunctions.fetchAccountsData()
                DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                DBFunctions.sharedDBFunctions.saveAccountsDb(arr_Accounts: arr_Cards, isUpdate: true)
                
            }
            else if response.value(forKey: "status") as! String == "ProfileData"
            {
                let arr_profileData = NSMutableArray()
                arr_profileData .removeAllObjects()
                arr_profileData.add(response.value(forKey: "data"))
                
                if arr_profileData.count > 0
                {
                    for i in 0..<arr_profileData.count
                    {
                        let dic : NSMutableDictionary = ((arr_profileData.object(at: i) as! NSDictionary) .mutableCopy() as! NSMutableDictionary)
                        dic.setValue(contactNumber, forKey: "cell")
                        arr_values.add(dic)
                    }
                    let userDetails =  DBFunctions.sharedDBFunctions.fetchProfileData(cell: contactNumber)
                    DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                    DBFunctions.sharedDBFunctions.saveProfileData(arr_Profile: arr_values, isUpdate: true)
                }
            }
            else if response.value(forKey: "status") as! String == "3a"
            {
//                if response.value(forKeyPath:"data.error") as? String == ""
//                {
                    IQKeyboardManager.sharedManager().enableAutoToolbar = false
                   UserDefaults.standard.set("false", forKey: "Comment")
                UserDefaults.standard.set(response.value(forKeyPath:"data.id") as? String, forKey:"paymentID")
                   viewBack_Payment.isHidden = true
                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Payment sucessfully send")
                     inputContainerView.isHidden = false
                //}
            }
            else if response.value(forKey: "status") as! String == "SendMessage"
            {
                 if let val = response.value(forKeyPath: "data.error") {
                    
                    self.growingTextView.resignFirstResponder()
                    
                    let alertView = UIAlertController(title: "TextMaxxPro", message: "\(String(describing: (response.value(forKeyPath: "data.error") as? String)!))", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        })
                    alertView.addAction(action)
                    self.present(alertView, animated: true, completion: nil)
                }
                else
                 {
                    str_messageID = String(describing: ((arrayTagPeople.sharedInstance .lastObject as? NSDictionary)?.value(forKey: "id"))!)
                    
                    UserDefaults.standard.set("false", forKey: "Comment")
                    btnShape.backgroundColor = UIColor.clear
                    CallWBMessagesList()
                }
                
                
//                if response.value(forKeyPath: "data.error") as? String == ""
//                {
                    //                }
//                else{
//                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "\(response.value(forKey: "message") as? String)")
//                }
                
             //   9569669495
            }
            else if response.value(forKey: "status") as! String == "MessageList"
            {
//                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadInbox"), object: nil)
                
                //  tableview_Chat.isScrollEnabled = true
                var arr_earlierMessages = NSMutableArray()
                if msgEarlierBool == true{
                
                    arr_earlierMessages.removeAllObjects()
                    var arr_loadEarlierMSgs = NSMutableArray()
                    
                    arr_loadEarlierMSgs = ((response.value(forKeyPath: "data.messages") as? NSArray)! .mutableCopy() as! NSMutableArray)
                    
                    if arr_loadEarlierMSgs.count > 0
                    {
                        msgEarlierBool = false
                        for i in 0..<arr_loadEarlierMSgs.count
                        {
                            let dic : NSMutableDictionary = ((arr_loadEarlierMSgs.object(at: i) as! NSDictionary) .mutableCopy() as! NSMutableDictionary)
                            dic.setValue(contactNumber, forKey: "cell")
                            arr_earlierMessages.add(dic)
                        }
                        
                        for i in 0..<arrayTagPeople.sharedInstance.count
                        {
                            let dic : NSDictionary = arrayTagPeople.sharedInstance.object(at: i) as! NSDictionary
                            dic.setValue(contactNumber, forKey: "cell")
                            arr_earlierMessages.add(dic)
                        }
                        arrayTagPeople.sharedInstance = arr_earlierMessages
                        
                        // data base manage //
                        
                        let userDetails =  DBFunctions.sharedDBFunctions.fetchChatList(cell: contactNumber)
                        
                        DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                        
                        DBFunctions.sharedDBFunctions.saveChat(arr_chat: arrayTagPeople.sharedInstance, isUpdate: true)
                        tableview_Chat.reloadData()
                        
                        tableview_Chat.contentOffset = CGPoint(x: 0,y :tableview_Chat.contentSize.height/5)
                    }
                    else{
                        msgEarlierBool = true
                    }
                    
                }
                else
                {
                    if msgSendBool == true{
                        msgSendBool = false
                    }
                    else
                    {
                        arrayTagPeople.sharedInstance.removeAllObjects()
                    }
                    arr_earlierMessages = ((response.value(forKeyPath: "data.messages") as? NSArray)! .mutableCopy() as! NSMutableArray)
                    for i in 0..<arr_earlierMessages.count
                    {
                        let dic : NSMutableDictionary = ((arr_earlierMessages.object(at: i) as! NSDictionary) .mutableCopy() as! NSMutableDictionary)
                        dic.setValue(contactNumber, forKey: "cell")
                        arrayTagPeople.sharedInstance.add(dic)
                    }
                    self.growingTextView.text = ""
                    tableview_Chat.reloadData()
                  //  tableViewScrollToBottom(animated: true)
                    NotificationCenter.default.addObserver(self, selector: #selector(chatDetailVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
                    
                    // data base manage // 
                    
                    let userDetails =  DBFunctions.sharedDBFunctions.fetchChatList(cell: contactNumber)
                    
                    DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                    
                    DBFunctions.sharedDBFunctions.saveChat(arr_chat: arrayTagPeople.sharedInstance, isUpdate: true)
                    tableViewScrollToBottom(animated: false)
                    
//                    let bottomoffset: CGPoint = CGPoint(x: 0, y: tableview_Chat.contentSize.height - tableview_Chat.bounds.size.height)
//                    
//                    if bottomoffset.y > 0 {
//                      //  tableview_Chat.contentOffset = bottomoffset;
//                        tableview_Chat .setContentOffset(bottomoffset, animated: false)
//                    }
                }
            }
            else if response.value(forKey: "status") as! String == "InboxFromChat"
            {
//                if response.value(forKeyPath:"data.error") as? String == ""
//                {
                    CallWBMessagesList()
               // }
                
            }
            else if response.value(forKey: "status") as! String == "ImageStore"
            {
//                if self.growingTextView.text.characters.count > 0
//                {
                    msgSendBool = true
                    str_occured = "after"
                    CallWBSendMessage(message: (response.value(forKeyPath: "data.url") as? String)!)
                    self.growingTextView.text = ""
//                }
//                else
//                {
//                    CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxxPro", message: "Please enter text")
//                }
                
//               self.growingTextView.text = response.value(forKeyPath: "data.url") as? String
            }
        }
    }
    
    
    func failureResponseReceived (_ response:AnyObject) {
        // Error received in response.
        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "", message: "\(response)")
    }
    
    func noDataReceived () {
        // No data received in response.
        inputContainerView.isHidden = false
        msgEarlierBool = true
//        CommonFunctions.sharedCommonFunctions.showAlert(self, title: "TextMaxx Pro", message:"We apologize but communication is restricted to the hours of 8AM to 9PM !!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
