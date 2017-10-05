//
//  LoginBL.swift
//  Restaurant
//
//  Created by Divya Khanna on 9/26/16.
//  Copyright © 2016 Divya Khanna. All rights reserved.
//

import Foundation
import UIKit

class LoginBL: BaseBL {
    //MARK:- Login
    //    func login(onView: UIView, emailId:String, pwd:String, userType:String, socialId:String, socialType:String, isAutoLogin: Bool)
    func login(_ onView: UIView, userName:String, password:String){
        
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = loginApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
//        let details = ["user_name":"\(userName)","password":"\(password)"] as [String : Any]
        
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        if UserDefaults.standard.bool(forKey:"Logout") == true
        {
             urlCompleteLogin =  "\(urlComplement)"
        }
        else
        {
            urlCompleteLogin =  "\(urlComplement)/\(userName)/\(password)"
        }
        // Post data
        DataManager.getData(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }

            if retrieveData != nil {
                do {
                    // Json parsing
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary

                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        self.delegate.successResponseReceived(json)
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    func contactVerified(_ onView: UIView, cell:String){
        // Show Loading Indicator
        
        // Api
        let urlComplement = verifiedApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        
        urlCompleteLogin =  "\(urlComplement)/\(cell)"
        
        // Post data
        DataManager.getDataContactVerified(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                do {
                    // Json parsing
                    
                    var dataToPass = [String:AnyObject]()
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"contactVerified" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                        
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    
    
    func creditCardType(_ onView: UIView, cell:String){
        // Show Loading Indicator
      //  CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = accountsApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        
        urlCompleteLogin =  "\(urlComplement)/\(cell)"
        
        // Post data
        DataManager.getDataMessageList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                do {
                    // Json parsing
                    
                    var dataToPass = [String:AnyObject]()
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"CreditCards" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                        
                    }
            } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    func sendPayemnt(_ onView: UIView, cell:String, amount:String, token:String, note:String, reference:String, batch:String){
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = payApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        
        urlCompleteLogin =  "\(urlComplement)/\(cell)"
        
        // Post data
        DataManager.sendPaymentData(details as [String : AnyObject],amount:amount, token:token, note:note, reference:reference, urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                do {
                    // Json parsing
                    
                    var dataToPass = [String:AnyObject]()
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"3a" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                        
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    
    
    func myAccount(_ onView: UIView){
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = userApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        //        let details = ["user_name":"\(userName)","password":"\(password)"] as [String : Any]
        
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        let userId = UserDefaults.standard.value(forKey:"userID") as? String
            urlCompleteLogin =  "\(urlComplement)/\(userId!)"
        // Post data
        DataManager.getDataMessageList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                do {
                     var dataToPass = [String:AnyObject]()
                    // Json parsing
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"MyAccount" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    func groupList(_ onView: UIView){
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        // Api
        let urlComplement = groupApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        urlCompleteLogin =  "\(urlComplement)"
        // Post data
        DataManager.getGrpupMessageList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                do {
                    var dataToPass = [String:AnyObject]()
                    // Json parsing
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"GroupList" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    
    func editMyAccount(_ onView: UIView){
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = userApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        //        let details = ["user_name":"\(userName)","password":"\(password)"] as [String : Any]
        
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        let userId = UserDefaults.standard.value(forKey:"userID") as? String
        urlCompleteLogin =  "\(urlComplement)/\(userId!)"
        // Post data
        DataManager.editProfileData(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                do {
                    // Json parsing
                    var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"EditAccount" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    
    func StoreImageFile(_ onView: UIView,encodedStr:String){
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: "Uploading")
        
        // Api
        let urlComplement = imageStoreApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        //        let details = ["user_name":"\(userName)","password":"\(password)"] as [String : Any]
        
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        urlCompleteLogin =  urlComplement
        // Post data
        DataManager.storeImageData(details as [String : AnyObject],enocodedImage:encodedStr,urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                do {
                    // Json parsing
                    var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"ImageStore" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    
    func verify(_ onView: UIView, cell:String, account:String, marketing:String , label:String, Language:String){
        
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = verifyApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        //        let details = ["user_name":"\(userName)","password":"\(password)"] as [String : Any]
        
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
       
        urlCompleteLogin =  "\(urlComplement)/\(cell)"
    
        // Post data
        DataManager.getDataVerify(details as [String : AnyObject], urlComplement: urlCompleteLogin, account:account, marketing:marketing,label:label, Language: Language) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                
                do {
                    // Json parsing
                    
                    var dataToPass = [String:AnyObject]()
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"1a" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                        
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    
    func BrodCastMessage(_ onView: UIView, message:String, account:String, marketing:String , notify:String, Language:String,tags:String){
        
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = broadcastApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        //        let details = ["user_name":"\(userName)","password":"\(password)"] as [String : Any]
        
        let details = ["":""]
        
        var urlCompleteLogin = String()
        
        
        urlCompleteLogin =  "\(urlComplement)"
        
        // Post data
        DataManager.getDataBrodCastMessage(details as [String : AnyObject], urlComplement: urlCompleteLogin, account:account, marketing:marketing,notify:notify,Language: Language,message:message,tags:tags) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            if retrieveData != nil {
                
                do {
                    // Json parsing
                    
                    var dataToPass = [String:AnyObject]()
                    
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"8a" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                        
                    }
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    
    
    func contactList(_ onView: UIView)
    {
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        // Api
        let urlComplement = contactListApi
        let details = ["":""]
        let urlCompleteLogin =  "\(urlComplement)"
        print(urlCompleteLogin)
        // Post data
        DataManager.getDataContactList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    // Json parsing
                     var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        dataToPass = ["data":json as AnyObject,"status":"Contact" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    func contactListSearch(_ onView: UIView, phonestr:String)
    {
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        // Api
        let urlComplement = contactListApi
        let details = ["ifmatch":phonestr]
        let urlCompleteLogin =  "\(urlComplement)"
        print(urlCompleteLogin)
        // Post data
        
        DataManager.getDataSearchContactList(details as [String : AnyObject],phone: phonestr, urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    // Json parsing
//                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
//                    
//                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
//                    DispatchQueue.main.async {
//                        self.delegate.successResponseReceived(json)
//                    }
//                    
                    
                    var dataToPass = [String:AnyObject]()
                    
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"SearchList" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                        
                    }
                    
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
        
        
    }
    
    func registration(_ onView: UIView,name:String, email:String, password:String,phone:String,locattion:String,lat:String,Long:String){
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = registerApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        
        
        
        let details = ["result":true,"password":"\(password)","full_name":"\(name)","email":"\(email)","phone":"\(phone)","location":"\(locattion)","lat":"\(lat)","long":"\(Long)","device_token":"s6d54f5sd4f564sd65f465sd4f654sd6f54","device_type":"ios"] as [String : Any]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: details, options: JSONSerialization.WritingOptions.prettyPrinted)
            tempJson = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        }catch let error as NSError{
            print(error.description)
            
        }
        
        urlParameters = ["user_details":tempJson]
        let valid = JSONSerialization.isValidJSONObject(urlParameters)
        print("Params : \(valid)")
        
        
        // Post data
        DataManager.getData(urlParameters, urlComplement: urlComplement) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            // Data received
            if retrieveData != nil {
                do {
                    // Json parsing
                    //let json = try JSONSerialization.jsonObject(with: retrieveData, options: .allowFragments) as?[String: Any]
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    if let result = json["result"]! as? Int {
                        var dataToPass = [String:AnyObject]()
                        let messageToPass = json["response"] as? String
                        if result == 1 {
                            if let response = json["user_details"] as? NSDictionary {
                                
                                if let responseSuccess = response.value(forKey: "status")! as? String{
                                    
                                    //if responseSuccess == "1" {//Success
                                        // Pass data to controller.
                                       
                                        DispatchQueue.main.async {
                                            // Save user profile
                                            if let data = json["user_details"] as? NSDictionary {
                                                CommonFunctions.sharedCommonFunctions.CustomLog("data:\(data)")
                                                // Save user profile in defaults and DB
                                                let userName = data.value(forKey: "full_name")!
                                                print(userName)
                                           }
                                            dataToPass = ["status":1 as AnyObject,"message" : messageToPass! as AnyObject]
                                            self.delegate.successResponseReceived(dataToPass as AnyObject)
                                        }
                                    //}
                                }
                            }
                        }else{
                            // Pass data to controller.
                            DispatchQueue.main.async {
                                dataToPass = ["status":0 as AnyObject,"message" : messageToPass! as AnyObject]
                                self.delegate.successResponseReceived(dataToPass as AnyObject)
                            }
                        }
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        // Invalid json
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    // Invalid data
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    func messageList(_ onView: UIView, phonestr:String, messageID:String, occured:String)
    {
//        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        // Api
        let urlComplement = messageListApi
        let details = ["":""]
        let urlCompleteLogin =  "\(urlComplement)/\(phonestr)/\("10")/\(messageID)/\(occured)"
        print(urlCompleteLogin)
        // Post data
        DataManager.getDataMessageList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    // Json parsing
                    var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        // self.delegate.successResponseReceived(json)
                        dataToPass = ["data":json as AnyObject,"status":"MessageList" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    func inboxMessage(_ onView: UIView, cell:String)
    {
        var urlCompleteLogin = ""
        // Api
        let urlComplement = uiApi
        let details = ["":""]
        
        if UserDefaults.standard.bool(forKey: "InboxPage") == true
        {
            urlCompleteLogin =  "\(urlComplement)"

        }
        else{
            urlCompleteLogin =  "\(urlComplement)/\(cell)"
        }
        
        print(urlCompleteLogin)
        // Post data
        DataManager.getDataContactList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    var dataToPass = [String:AnyObject]()
                    // Json parsing
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        dataToPass = ["data":json as AnyObject,"status":"Inbox" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    func DeleteAwaitMessage(_ onView: UIView, cell:String)
    {
        var urlCompleteLogin = ""
        // Api
        let urlComplement = cellApi
        let details = ["":""]
        urlCompleteLogin =  "\(urlComplement)/\(cell)"
        print(urlCompleteLogin)
        // Post data
        DataManager.getDataForDeleAwaitMessage(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    var dataToPass = [String:AnyObject]()
                    // Json parsing
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        dataToPass = ["data":json as AnyObject,"status":"AwaitDelList" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    
    // put method //
    func inboxMessagefromchat(_ onView: UIView, cell:String)
    {
      //  CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        var urlCompleteLogin = ""
        // Api
        let urlComplement = uiApi
        let details = ["":""]
        
        urlCompleteLogin =  "\(urlComplement)/\(cell)"
        
        print(urlCompleteLogin)
        // Post data
        DataManager.getInboxPagefromChat(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    var dataToPass = [String:AnyObject]()
                    // Json parsing
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        dataToPass = ["data":json as AnyObject,"status":"InboxFromChat" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    
    func awaitsMessage(_ onView: UIView)
    {
    CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        // Api
        let urlComplement = awaitsApi
        let details = ["":""]
        let urlCompleteLogin =  "\(urlComplement)"
        print(urlCompleteLogin)
        // Post data
        DataManager.getDataMessageList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    var dataToPass = [String:AnyObject]()
                    // Json parsing
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        
                        dataToPass = ["data":json as AnyObject,"status":"Await" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)

                        
                   //     self.delegate.successResponseReceived(json)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    func template(_ onView: UIView, type:String, source:String, broadCast: String)
    {
//        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        // Api
        let urlComplement = templateApi
        let details = ["":""]
        let urlCompleteLogin =  "\(urlComplement)/\(type)/\(source)/\(broadCast)"
        print(urlCompleteLogin)
        // Post data
        DataManager.templateList(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    // Json parsing
                    var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        //self.delegate.successResponseReceived(json)
                        dataToPass = ["data":json as AnyObject,"status":"Template" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    
    
    func sendMessage(_ onView: UIView, phonestr:String, message:String)
    {
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: "Sending")
        // Api
        let urlComplement = sendMessageApi
        let details = ["":""]
        let urlCompleteLogin =  "\(urlComplement)/\(phonestr)"
        print(urlCompleteLogin)
        // Post data
        DataManager.sendMessage(details as [String : AnyObject], message:message, urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            if retrieveData != nil {
                do {
                    // Json parsing
                     var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        //self.delegate.successResponseReceived(json)
                        dataToPass = ["data":json as AnyObject,"status":"SendMessage" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    func profileFetch(_onView: UIView, phonestr: String)
    {
      //  CommonFunctions.sharedCommonFunctions.inactivateView(_onView, loaderText: loading)
        // Api
        let urlComplement = readCellApi
        let details = ["":""]
        let urlCompleteLogin =  "\(urlComplement)/\(phonestr)"
        print(urlCompleteLogin)
        // Post data
        DataManager.getDataProfile(details as [String : AnyObject], urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(_onView)
            }
            if retrieveData != nil {
                do {
                    // Json parsing
                    var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        dataToPass = ["data":json as AnyObject,"status":"ProfileData" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
        
        
    }
    
    func modifyProfile(_onView: UIView, phonestr: String , label : String)
    {
        CommonFunctions.sharedCommonFunctions.inactivateView(_onView, loaderText: loading)
        // Api
        let urlComplement = readCellApi
        let details = ["":""]
        let urlCompleteLogin =  "\(urlComplement)/\(phonestr)"
        print(urlCompleteLogin)
        // Post data
        DataManager.modifyDataProfile(details as [String : AnyObject], label : label , urlComplement: urlCompleteLogin) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(_onView)
            }
            if retrieveData != nil {
                do {
                    // Json parsing
                    var dataToPass = [String:AnyObject]()
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    DispatchQueue.main.async {
                        dataToPass = ["data":json as AnyObject,"status":"ProfileData" as AnyObject]
                        self.delegate.successResponseReceived(dataToPass as AnyObject)
                    }
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }

    
    
    func forgotPwd(_ onView: UIView, email:String){
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        // Api
        let urlComplement = forgotPwdApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        
            //{"result":true,"email":"bhavnish.narang@trigma.co.in","device_token":"s6d54f5sd4f564sd65f465sd4f654sd6f54","device_type":"ios/android"}

        
        let details = ["result":true,"email":"\(email)","device_token":"s6d54f5sd4f564sd65f465sd4f654sd6f54","device_type":"ios"] as [String : Any]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: details, options: JSONSerialization.WritingOptions.prettyPrinted)
            tempJson = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        }catch let error as NSError{
            print(error.description)
            
        }
        
        urlParameters = ["user_details":tempJson]
        let valid = JSONSerialization.isValidJSONObject(urlParameters)
        print("Params : \(valid)")
        
        
        // Post data
        DataManager.getData(urlParameters, urlComplement: urlComplement) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
            
            //        DataManager.postData(urlParameters, httpMethod: "POST", urlComplement: urlComplement){ (retrieveData) -> Void in
            //                            DispatchQueue.main.async() {
            //                                // Hide Loading Indicator
            //                                CommonFunctions.sharedCommonFunctions.activateView(onView)
            //                            }
            
            
            // Data received
            if retrieveData != nil {
                do {
                    // Json parsing
                    //let json = try JSONSerialization.jsonObject(with: retrieveData, options: .allowFragments) as?[String: Any]
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    var messageToPass = ""
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    if let result = json["result"]! as? Int {
                       
                        if result == 1 {
                                    DispatchQueue.main.async {
                                        messageToPass = (json["response"] as? String)!
                                        }
                                       self.delegate.successResponseReceived(messageToPass as AnyObject)
                            }else{
                             messageToPass = (json["response"] as? String)!
                             self.delegate.successResponseReceived(messageToPass as AnyObject)
                            }
                        
                            }
                    
                        else{
                            // Pass data to controller.
                            DispatchQueue.main.async {
                                
                                self.delegate.successResponseReceived(messageToPass as AnyObject)
                            }
                        }
            
                    
                } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        // Invalid json
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    // Invalid data
                    self.delegate.noDataReceived()
                }
            }
        }//finish
        
    }
    
    
    
    func logout(_ onView: UIView, id:String,token:String){
        
        // Show Loading Indicator
        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
        
        
        // Api
        let urlComplement = logoutApi
        var urlParameters = [String:AnyObject]()
        var tempJson : NSString = ""
        //{"result":true,"user_id":1,"access_token":"26e6efb17f715a2ffc7e0126ab10fab9"}
       
         //let details = ["result":true,"user_id":1,"access_token":"26e6efb17f715a2ffc7e0126ab10fab9"] as [String : Any]
         let details = ["result":true,"user_id":"\(id)","access_token":"\(token)"] as [String : Any]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: details, options: JSONSerialization.WritingOptions.prettyPrinted)
            tempJson = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        }catch let error as NSError{
            print(error.description)
            
        }
        
        urlParameters = ["user_details":tempJson]
        let valid = JSONSerialization.isValidJSONObject(urlParameters)
        print("Params : \(valid)")
        
        
        // Post data
        DataManager.getData(urlParameters, urlComplement: urlComplement) { (retrieveData) in
            DispatchQueue.main.async() {
                // Hide Loading Indicator
                CommonFunctions.sharedCommonFunctions.activateView(onView)
            }
        
//                    DataManager.postData(urlParameters, httpMethod: "POST", urlComplement: urlComplement){ (retrieveData) -> Void in
//                                        DispatchQueue.main.async() {
//                                            // Hide Loading Indicator
//                                            CommonFunctions.sharedCommonFunctions.activateView(onView)
//                                        }
            
            
            // Data received
            if retrieveData != nil {
                do {
                    
                    let json : NSDictionary = try JSONSerialization.jsonObject(with: retrieveData! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    var messageToPass = ""
                    CommonFunctions.sharedCommonFunctions.CustomLog("JSON:\(json)")
                    if let result = json["result"]! as? Int {
                        
                        if result == 1 {
                            DispatchQueue.main.async {
                                messageToPass = (json["response"] as? String)!
                            }
                            self.delegate.successResponseReceived(messageToPass as AnyObject)
                        }else{
                            messageToPass = (json["response"] as? String)!
                            self.delegate.successResponseReceived(messageToPass as AnyObject)
                        }
                        
                    }
                    else{
                        // Pass data to controller.
                        DispatchQueue.main.async {
                            
                            self.delegate.successResponseReceived(messageToPass as AnyObject)
                        }
                    }
                 } catch {//Error in parsing
                    CommonFunctions.sharedCommonFunctions.CustomLog("error serializing JSON: \(error)")
                    
                    DispatchQueue.main.async {
                        // Invalid json
                        self.delegate.noDataReceived()
                    }
                }
            }
            else {//No data received
                DispatchQueue.main.async {
                    // Invalid data
                    self.delegate.noDataReceived()
                }
            }
        }//finish
    }
    
    
//    func data_request()
//    {
//        
//        let url:NSURL = NSURL(string: "http://dev514.trigma.us/cardealer/webservices/webservices/logout")!
//        let session = URLSession.shared
//        
//        let request = NSMutableURLRequest(url: url as URL)
//        request.httpMethod = "POST"
//        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//        let paramString =  "user_details={\"result\":true,\"user_id\":1,\"access_token\":\"26e6efb17f715a2ffc7e0126ab10fab9\"}"
//        //request.httpBody = paramString.data(using: String.Encoding.utf8)
//        
//        let data = paramString.data(using: String.Encoding.utf8)
//        let task = session.uploadTask(with: request as URLRequest, from: data, completionHandler:
//            {(data,response,error) in
//                
//                guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
//                    print("error")
//                    return
//                }
//                
//                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                print(dataString)
//            }
//        );
//        
//        task.resume()
//    }
//    
//
//}
//

func logoutDemo(){
    
//    let requestURL: NSURL = NSURL(string: "http://dev514.trigma.us/cardealer/webservices/webservices/logout")!
//    let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
//    let session = URLSession.shared
//    let task = session.dataTask(with: urlRequest as URLRequest) {
//        (data, response, error) -> Void in
//        
//        let httpResponse = response as! HTTPURLResponse
//        let statusCode = httpResponse.statusCode
//        
//        if (statusCode == 200) {
//            print("Everyone is fine, file downloaded successfully.")
//            
//            do{
//                
//                let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
//                
//                if let stations = json["stations"] as? [[String: AnyObject]] {
//                    
//                    for station in stations {
//                        
//                        if let name = station["stationName"] as? String {
//                            
//                            if let year = station["buildYear"] as? String {
//                                print(name,year)
//                            }
//                            
//                        }
//                    }
//                    
//                }
//                
//            }catch {
//                print("Error with Json: \(error)")
//            }
//            
//        }
//    }
//    
//    task.resume()
}
//    func loginUser(_ onView: UIView, email:String, password:String){
//        // Show Loading Indicator
//        CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
//        
//        let dict : NSDictionary = ["result":true,"user_name":"","password":password,"email":email,"device_token":"s6d54f5sd4f564sd65f465sd4f654sd6f54","device_type":"ios"]
//        
//        
//        var jsonData = NSData()
//        do {
//            
//            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
//            let tempJson = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
//            
//            let post: NSDictionary = ["user_details":tempJson]
//            print(post)
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        let url = NSURL(string:"http://dev514.trigma.us/cardealer/webservices/webservices/login")
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        
//        request.httpBody = jsonData as Data
//        
//        let task = session.dataTask(with: request as URLRequest)
//        {
//            data, response, error in
//            
//            DispatchQueue.main.async {
//                // Hide Loading Indicator
//                CommonFunctions.sharedCommonFunctions.inactivateView(onView, loaderText: loading)
//            }
//            
//            if let httpResponse = response as? HTTPURLResponse
//            {
//                if httpResponse.statusCode != 200 {
//                    print("response was not 200: \(response)")
//                    return
//                }
//            }
//            if (error != nil)
//            {
//                print("error submitting request: \(error)")
//                return
//            }
//            let abc = try! JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions(rawValue: UInt(1)))  as AnyObject
//            
//            print(abc)
//        }
//        task.resume()
//    }
//    
//    
//    
////   

            
}
            
            





