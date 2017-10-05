//
//  InboxVC.swift
//  TextMaxx Pro
//
//  Created by surender on 04/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit
import CoreData

class InboxVC: UIViewController,UITableViewDataSource,UITableViewDelegate,BaseBLDelegate {

    //MARK:- Outlets
    
    @IBOutlet var lbl_NoInbox: UILabel!
    @IBOutlet var tableView_Inbox: UITableView!
    
    //MARK:- Varriables
    var arr_Inbox = NSMutableArray()
    var cell_number = ""
    var indexPathofCell = NSIndexPath()
    var counter : Int = 0
    
    var phoneFormatter = PhoneNumberFormatter()

    //MARK:- Did Load & Will Appear
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cellnumber = ""

     //   self.setupMenuBarButtonItems()
        
        
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(InboxVC.callPushMethod),
//            name: NSNotification.Name(rawValue: "Inbox"),
//            object: nil)
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(InboxVC.callWbInboxMessages),
//            name: NSNotification.Name(rawValue: "ReloadInbox"),
//            object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "InboxPage")
        
         callWbInboxMessages()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        counter = 0
    }
    
    func callPushMethod()
    {
        counter = counter+1
        callWbInboxMessages()
    }
    
    
    
    //MARK: - Call Wb
    func callWbInboxMessages()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            let userDetails =  DBFunctions.sharedDBFunctions.fetchInboxfromDB()
           // print(userDetails)
            
            arr_Inbox.removeAllObjects()
            let arrayvalues = NSArray(array: userDetails)
            
            for i in 0..<arrayvalues.count
            {
                let dic = NSMutableDictionary()
                
                let account = userDetails[i].value(forKey: "account") as? String
                let accountNumber = userDetails[i].value(forKey: "account_number") as? String
                let cell = userDetails[i].value(forKey: "cell") as? String
                let h = userDetails[i].value(forKey: "h") as? String
                let label = userDetails[i].value(forKey: "label") as? String
                let marketed = userDetails[i].value(forKey: "marketed") as? String
                
                let rank = userDetails[i].value(forKey: "rank") as? String
                let updated = userDetails[i].value(forKey: "update") as? String
                let visible = userDetails[i].value(forKey: "visible") as? String
                let w = userDetails[i].value(forKey: "w") as? String
                let window = userDetails[i].value(forKey: "window") as? String
                let x = userDetails[i].value(forKey: "x") as? String
                let y = userDetails[i].value(forKey: "y") as? String
                let message = userDetails[i].value(forKey: "message") as? String

                
                dic.setValue(account!, forKey:  "account")
                dic.setValue(accountNumber!, forKey:  "account_number")
                dic.setValue(cell!, forKey:  "cell")
                dic.setValue(h!, forKey:  "h")
                dic.setValue(message!, forKey:  "message")
                dic.setValue(label!, forKey:  "label")
                dic.setValue(marketed!, forKey:  "marketed")
                dic.setValue(rank!, forKey:  "rank")
                dic.setValue(updated!, forKey:  "updated")
                dic.setValue(visible!, forKey:  "visible")
                dic.setValue(w!, forKey:  "w")
                dic .setValue(window!,  forKey:  "window")
                
                dic .setValue(x!,    forKey: "x")
                dic .setValue(y!, forKey: "y")
              //  print(dic)
                arr_Inbox.add(dic)
            }
            
            if arr_Inbox .count > 0
            {
                tableView_Inbox.isHidden = false
                lbl_NoInbox.isHidden = true
            }
            else
            {
                tableView_Inbox.isHidden = true
                lbl_NoInbox.isHidden = false
            }
            tableView_Inbox.reloadData()
            
            
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            if UserDefaults.standard.bool(forKey: "InboxPage") == true
            {
                CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)

            }
            loginBL.inboxMessage(self.view, cell: cell_number)
            
        }
    }
    
    func CallWBMessagesList(Index: Int)
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            
            let userDetails =  DBFunctions.sharedDBFunctions.fetchChatList(cell: ((arr_Inbox[Index] as? NSDictionary)?.value(forKey: "cell") as? String)!)
         //   print(userDetails)
            
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
            //    print(dic)
                arrayTagPeople.sharedInstance.add(dic)
                //  arr_contactListTrue.add(dic)
            }
        default:
            // Hit login WS.
            let loginBL: LoginBL = LoginBL()
            loginBL.delegate = self
            
            loginBL.messageList(self.view, phonestr: ((arr_Inbox[Index] as? NSDictionary)?.value(forKey: "cell") as? String)!, messageID: "0", occured: "after")
        }
    }

    //MARK:- TableView delegate & datasorces
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_Inbox.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! InboxCell
        
       //  tableCell.lbl_Name.text = ((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)?.replacingOccurrences(of: "\n", with: "")
        
        let str_label = ((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)?.replacingOccurrences(of: "\n", with: "")
    
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = str_label?.rangeOfCharacter(from: decimalCharacters)
        
        if decimalRange != nil {
            tableCell.lbl_Name.text = str_label?.tochangePhoneNumber()

        }
        else{
             tableCell.lbl_Name.text = ((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)?.replacingOccurrences(of: "\n", with: "")
        }
        
       // phoneFormatter.format(text)
        
        tableCell.lbl_Message.text = (arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "message") as? String
      
        
        if (arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "unread") as? String == "0"
        {
            tableCell.lbl_Count.isHidden = true
        }
        else
        {
            tableCell.lbl_Count.isHidden = false
            tableCell.lbl_Count.text = (arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "unread") as? String
            
        }

        if indexPath.row % 2 == 0
        {
            tableCell.backgroundColor = UIColor.init(colorLiteralRed: 238/255, green: 246/255, blue: 254/255, alpha: 1)
        }
        else{
            tableCell.backgroundColor = UIColor.white
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateA = dateFormatter.date(from: (((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "updated") as? String)!))
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm a"
        let strA = dateFormatter1.string(from: dateA!)
        tableCell.lbl_Time.text = strA
        tableCell.btn_Info.addTarget(self, action: #selector(InboxVC.btnInfoAction(sender:)), for: UIControlEvents.touchUpInside)
        tableCell.btn_Info.tag = indexPath.row
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.cellnumber = ((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!

        let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatDetailVC")as! chatDetailVC
        VC.str_NameTitle = ((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "label") as? String)!
        VC.contactNumber = ((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    //** tableview delegate for delete row **//
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            UserDefaults.standard.set(false, forKey: "InboxPage")
            cell_number = ((arr_Inbox[indexPath.row] as? NSDictionary)?.value(forKey: "cell") as? String)!
            indexPathofCell = indexPath as NSIndexPath
            callWbInboxMessages()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    //MARK:- Information Action
    func btnInfoAction (sender:AnyObject)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")as! ProfileVC
        VC.phone = ((arr_Inbox[sender.tag] as? NSDictionary)?.value(forKey: "cell") as? String)!
        self.navigationController?.pushViewController(VC, animated: true)
    }

    // MARK: - Response Received
    func successResponseReceived (_ response:AnyObject) {
        
        if response is NSDictionary {
          
            if response.value(forKey: "status") as! String == "Inbox"
            {
                if UserDefaults.standard.bool(forKey: "InboxPage") == true
                {
                    arr_Inbox = (response.value(forKeyPath: "data.sessions") as? NSArray)! .mutableCopy() as! NSMutableArray
                    
                    let arr_Inbox1 = NSMutableArray()
                    arr_Inbox1.addObjects(from: arr_Inbox as? AnyObject as! [Any])
                    
                        if arr_Inbox1 .count > 0
                        {
                            arr_Inbox.removeAllObjects()
                            for i in 0..<arr_Inbox1.count
                            {
                                var dic = NSMutableDictionary()
                                dic = (arr_Inbox1.object(at: i) as? NSDictionary)!.mutableCopy() as! NSMutableDictionary
                                if dic.value(forKey:"cell") as! String == UserDefaults.standard.value(forKey: "cell") as! String
                                {
                                    dic.setValue(String(counter), forKey: "Counter")
                                }
                                else
                                {
                                    dic.setValue("0", forKey: "Counter")
                                }
                                arr_Inbox.add(dic)
                            }
                            tableView_Inbox.isHidden = false
                            lbl_NoInbox.isHidden = true
                        }
                        else
                        {
                            tableView_Inbox.isHidden = true
                            lbl_NoInbox.isHidden = false
                        }
                        tableView_Inbox.reloadData()
                   
                }
                else{
                    arr_Inbox.removeObject(at: indexPathofCell.row)
                    tableView_Inbox.deleteRows(at: [indexPathofCell as IndexPath], with: .fade)
                }
                // check contact exists  in db then save
                let userDetails =  DBFunctions.sharedDBFunctions.fetchInboxfromDB()
                DBFunctions.sharedDBFunctions.deleteContactFromDB(userDetails)
                DBFunctions.sharedDBFunctions.saveInboxList(arr_inbox: arr_Inbox, isUpdate: true)
                
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

