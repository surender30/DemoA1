//
//  DataManager.swift
// Restaurant
//
//  Created by Divya Khanna on 9/23/16.
//  Copyright © 2016 Divya Khanna. All rights reserved.
//


import Foundation

class DataManager {
    
    class func getDataFromUrl(_ url: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        //create the full url to retrieve data
        loadDataFromURL(URL(string: url)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    
    class func getDataContactVerified(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadTemplateListFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }


    //for call this function we need to pass the url parameters in a dictionary variable (key,value) and the url complement without final /
    class func getData(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        print(urlComplement)
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    class func getDataVerify(_ urlParameter: [String: AnyObject], urlComplement: String, account: String, marketing: String, label:String, Language:String, success: @escaping ((_ retrieveData: NSData?) -> Void)){
        print(urlComplement)
        
        let parameters: String = ""
        
        
        var globalUrl = ""
        globalUrl = appUrl
        print(globalUrl+urlComplement)
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataVerifyUser(URL(string: globalUrl+urlComplement)!,account: account, marketing: marketing, label: label, Language: Language, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    class func getDataBrodCastMessage(_ urlParameter: [String: AnyObject], urlComplement: String, account: String, marketing: String, notify:String, Language:String, message:String, tags:String ,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        print(urlComplement)
        
        let parameters: String = ""
        
        
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadBrodCastMessage(URL(string: globalUrl+urlComplement)!,account: account, marketing: marketing, notify:notify, Language:Language, message: message,tags:tags, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }

    

    class func getDataContactList(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataContactListFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    
    class func getDataForDeleAwaitMessage(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataDeleateAwaitMessageFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }


    class func getInboxPagefromChat(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataInboxFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }

    
    
    class func getDataProfile(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataContactListFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    class func modifyDataProfile(_ urlParameter: [String: AnyObject], label:String ,urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        modifyProfileFromURL(URL(string: globalUrl+urlComplement)!, label : label,  completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }

    // **** payment send  *****//
    class func sendPaymentData(_ urlParameter: [String: AnyObject], amount:String, token:String, note:String, reference:String, urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataSendPayment(URL(string: globalUrl+urlComplement)!, amount: amount, token:token, note: note, reference: reference, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    class func getDataMessageList(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataMessageListFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    class func getGrpupMessageList(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadGroupData(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    
    class func editProfileData(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        sendEditPrfoileFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    class func storeImageData(_ urlParameter: [String: AnyObject],enocodedImage:String, urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        imageStoreFromURL(URL(string: globalUrl+urlComplement)!,encodeimage:enocodedImage, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }

    

    
    class func sendEditPrfoileFromURL(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        
        let dic_Profile = UserDefaults.standard.value(forKey: "profileData") as! NSDictionary
        
        let first_name = dic_Profile.value(forKey: "first_name") as? String
        let last_name = dic_Profile.value(forKey: "last_name") as? String
        let email_address = dic_Profile.value(forKey: "email_address") as? String
        let cell_number = dic_Profile.value(forKey: "cell") as? String
        let login = dic_Profile.value(forKey: "login") as? String

        
      //  let object_keyName = parameters.value(forKey:"first_name")
        
        let parameters = ["first_name" : first_name!, "last_name" : last_name!, "email_address":email_address!, "cell":cell_number!, "login":login!]
        
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        print(String(describing: data))
        
        
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("99", forHTTPHeaderField: "Content-Length")
        print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }

    class func imageStoreFromURL(_ url: URL, encodeimage:String, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let parameters = ["data" : encodeimage, "file_name":"abc.png"]
        
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        print(String(describing: data))
        
        
        //request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
       // request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      //  request.setValue("99", forHTTPHeaderField: "Content-Length")
        print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }
    
    
    
    class func templateList(_ urlParameter: [String: AnyObject], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadTemplateListFromURL(URL(string: globalUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }

    
    
    class func sendMessage(_ urlParameter: [String: AnyObject], message: String, urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        sendMessageFromURL(URL(string: globalUrl+urlComplement)!,message: message, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    class func getDataSearchContactList(_ urlParameter: [String: AnyObject],phone:String, urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        let parameters: String = ""
        var globalUrl = ""
        globalUrl = appUrl
        
        print(globalUrl+urlComplement)
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url:\(globalUrl + urlComplement + parameters)")
        
        print(globalUrl+urlComplement+parameters)
        //create the full url to retrieve data
        loadDataSearchContactListFromURL(URL(string: globalUrl+urlComplement)!, phone: phone, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
    }
    
    
    class func getDataWithoutParams(_ urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        CommonFunctions.sharedCommonFunctions.CustomLog("url: "+urlComplement)
        
        // let urlComplement = urlComplement.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        //create the full url to retrieve data
        /* loadDataFromURL(url: NSURL(string: appUrl+urlComplement)!, completion:{(data, error) -> Void in
         
         if let urlData = data {
         //retrieve when i get some data from server error success or something else
         do {
         if let jsonDict = try NSJSONSerialization.JSONObjectWithData(urlData, options: []) as? NSDictionary {
         CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
         success(retrieveData: urlData)
         }
         } catch let error as NSError {
         CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
         success(retrieveData: nil)
         }
         }else{
         //retrieve when is imposible connect to the service
         success(retrieveData: nil)
         }
         })*/
        
    }
    
    class func postOrPutData(_ urlParameter: [String: String],httpMethod: String, urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url: "+appUrl+urlComplement)
        CommonFunctions.sharedCommonFunctions.CustomLog("param: \(urlParameter)")
        
        loadDataFromURLPostOrPut(urlParameter,httpMethod:httpMethod,url: URL(string: appUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }
            else
            {
                success(nil)
            }
        })
        
    }
    class func postData(_ urlParameter: [String: AnyObject],httpMethod: String, urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        CommonFunctions.sharedCommonFunctions.CustomLog("url: "+appUrl+urlComplement)
        CommonFunctions.sharedCommonFunctions.CustomLog("param: \(urlParameter)")
        
        loadDataFromURLPost(urlParameter,httpMethod:httpMethod,url: URL(string: appUrl+urlComplement)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }
            else
            {
                success(nil)
            }
        })
        
    }
    class func deleteData(_ urlParameter: [String: String], urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        
        //urlForRequest = urlForRequest.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        var parameters: String = ""
        for (key, value) in urlParameter{
            parameters = parameters+"/\(key)"+"/\(value)"
        }
        CommonFunctions.sharedCommonFunctions.CustomLog("url: "+appUrl+urlComplement+parameters)
        let strUrl = appUrl+urlComplement+parameters
        CommonFunctions.sharedCommonFunctions.CustomLog("strUrl: "+strUrl)
        
        if let url: URL = URL(string: strUrl) as URL? {
            CommonFunctions.sharedCommonFunctions.CustomLog("url: \(url)")
        }
        else {
            CommonFunctions.sharedCommonFunctions.CustomLog("Invalid url")
        }
        
        //create the full url to retrieve data
        loadDataFromURLDelete(URL(string: strUrl)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
        
    }
    
    class func deleteDataRaw(_ urlParameter: String, urlComplement: String,success: @escaping ((_ retrieveData: NSData?) -> Void)){
        CommonFunctions.sharedCommonFunctions.CustomLog("url: "+appUrl+urlComplement)
        //create the full url to retrieve data
        loadDataFromURLRawDelete(urlParameter, url: URL(string: appUrl+urlComplement)!, completion: { (data, error) -> Void in
            if let urlData = data {
                //retrieve when i get some data from server error success or something else
                do {
                    if let jsonDict = try JSONSerialization.jsonObject(with: urlData as Data, options: []) as? NSDictionary {
                        CommonFunctions.sharedCommonFunctions.CustomLog("\(jsonDict)")
                        success(urlData)
                    }
                } catch let error as NSError {
                    CommonFunctions.sharedCommonFunctions.CustomLog("\(error)")
                    success(nil)
                }
            }else{
                //retrieve when is imposible connect to the service
                success(nil)
            }
        })
        
    }
    
    
    class func loadDataFromURLRawDelete(_ dataParameter: String, url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        CommonFunctions.sharedCommonFunctions.CustomLog("dataParameter: \(dataParameter)")
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "DELETE"
        
        request.httpBody = dataParameter .data(using: String.Encoding.utf8, allowLossyConversion: false)//NSJSONSerialization.dataWithJSONObject(dataParameter, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                CommonFunctions.sharedCommonFunctions.CustomLog("el codigo es: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404  || httpResponse.statusCode == 401 {
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        
        Variables.sharedVariables.currentTask!.resume()
    }
    
    
    class func loadDataFromURLDelete(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "DELETE"
        
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        
        Variables.sharedVariables.currentTask!.resume()
    }
    
    class func loadDataFromURL(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let token = UserDefaults.standard.value(forKey: "deviceToken") as! String
        let userName = UserDefaults.standard.value(forKey: "userName") as! String
        
        let shastring = "\(token)\(userName)"
        
        let shaConversion = shastring.sha1()
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
    
        
        if UserDefaults.standard.bool(forKey:"Logout") == true
        {
            let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
            let str_token_key = UserDefaults.standard.object(forKey: "token") as! String

            let encodeString = "\(str_clientKey):\(str_token_key)"
            
            let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"

            request.httpMethod = "DELETE"
            request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        }
        else
        {
            request.httpMethod = "GET"
        }
        
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("PP_APPLE", forHTTPHeaderField: "User-Agent")
        request.setValue(token, forHTTPHeaderField: "X-Device-Token")
        request.setValue(shaConversion, forHTTPHeaderField: "X-Mobility-Id")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        
        Variables.sharedVariables.currentTask!.resume()
    }
    
    class func loadDataInboxFromURL(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let parameters = ["agaent" : "Textmaxx mobile app v0.0.1beta"]

        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
     //   request.setValue("-5", forHTTPHeaderField: "X-Timezone-Offset")

        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }

    class func loadDataDeleateAwaitMessageFromURL(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "PUT"
        let parameters = [ "awaiting":false] as Dictionary
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
       // request.setValue("en", forHTTPHeaderField: "Accept-Language")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }

    
    class func loadDataContactListFromURL(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        if UserDefaults.standard.bool(forKey: "InboxPage") == true
        {
            request.httpMethod = "GET"
        }
        else
        {
            request.httpMethod = "DELETE"
        }
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }
    
    class func modifyProfileFromURL(_ url: URL, label : String, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        var postData    = Data()
        let parameters = ["label": label] as [String : Any]
        
        do {
            postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
        } catch let error {
            print(error.localizedDescription)
        }
 
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        print(data)
      let session = URLSession.shared
      //  let request = NSMutableURLRequest(url: url as URL)
        
        let request = NSMutableURLRequest(url: url as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
       
        request.httpBody = postData as Data
        request.httpMethod = "PUT"
        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//            
//        } catch let error {
//            print(error.localizedDescription)
//        }
        
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }


    class func loadDataSearchContactListFromURL(_ url: URL,phone : String , completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        request.setValue(phone, forHTTPHeaderField: "If-Match")
        
        print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }
    
    class func loadTemplateListFromURL(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        let encodeString = "\(str_clientKey)"
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
         request.setValue("en", forHTTPHeaderField: "Accept-Language")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        
        print(request.allHTTPHeaderFields!)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }

    
    
    class func loadDataMessageListFromURL(_ url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        
        let encodeString = "\(str_clientKey)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        
        print(request.allHTTPHeaderFields!)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }
    
    class func loadDataSendPayment(_ url: URL, amount:String, token:String, note:String, reference:String, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let parameters = [ "token":token,"amount": amount] as Dictionary
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        print(String(describing: data))
        
        
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("99", forHTTPHeaderField: "Content-Length")
        print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }

    class func loadGroupData(_ url: URL,completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        
        request.httpMethod = "GET"
        
       // request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        //request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
       // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.setValue("99", forHTTPHeaderField: "Content-Length")
        print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }
    
    
    class func sendMessageFromURL(_ url: URL, message:String,  completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        
      //  "sender": "iOS"
        let messageStatus = UserDefaults.standard.value(forKey: "Comment")
//        let parameters = [ "message":message,"marketing":"true", "comment":messageStatus!] as Dictionary
        
        let parameters = ["message":message]
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String

        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        print(String(describing: data))
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("99", forHTTPHeaderField: "Content-Length")
      //  request.setValue("-5", forHTTPHeaderField: "X-Timezone-Offset")
        
        print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }
                    else if httpResponse.statusCode == 403{
                        completion(data as NSData?, statusError)
                    }
                    else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }

    class func loadDataVerifyUser(_ url: URL, account:String, marketing:String, label:String, Language:String, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        
        
        
        let parameters = [ "label":label,"account": account,"marketing":marketing] as Dictionary
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        
        let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        let encodeString = "\(str_clientKey):\(str_token_key)"
        print(encodeString)
        
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        print(String(describing: data))
        
        
        request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
        request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
         request.setValue(Language, forHTTPHeaderField: "Accept-Language")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("99", forHTTPHeaderField: "Content-Length")
        
        print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }
    
    class func loadBrodCastMessage(_ url: URL, account:String, marketing:String, notify:String,Language:String,message:String, tags:String, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
    
        
        let parameters = [ "notify":notify,"account": account,"marketing":marketing,"Language":Language,"tags":tags, "message":message] as Dictionary
        
        let str_clientKey = UserDefaults.standard.object(forKey: "Client") as! String
        
         let str_token_key = UserDefaults.standard.object(forKey: "token") as! String
        
        let encodeString = "\(str_clientKey):\(str_token_key)"
        
        
       
        
//        let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
        
        
        
        
        let data = "\("Basic") \((encodeString.data(using: String.Encoding.utf8)?.base64EncodedString())!)"
        
        print(data)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        
        let data1 = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = NSString(data: data1, encoding: String.Encoding.utf8.rawValue)
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        
        request.httpMethod = "POST"
        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//            
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        print(String(describing: data))
        
        
     //   request.setValue("api.paymaxxpro.com", forHTTPHeaderField: "Host")
      // request.setValue("Fiddler", forHTTPHeaderField: "User-Agent")
      //  request.setValue(Language, forHTTPHeaderField: "Accept-Language")
       // request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(describing: data), forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
       // request.setValue("205", forHTTPHeaderField: "Content-Length")
        
      //  print(request.allHTTPHeaderFields)
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            print(response)
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 && httpResponse.statusCode != 202 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404{
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        Variables.sharedVariables.currentTask!.resume()
    }

    
    
    class func loadDataFromURLPostOrPut(_ dataParameter: [String:String], httpMethod: String, url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = httpMethod//POST
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dataParameter, options: JSONSerialization.WritingOptions.init(rawValue: 2))
        }
        catch {
            // Error Handling
            CommonFunctions.sharedCommonFunctions.CustomLog("NSJSONSerialization Error")
        }
        CommonFunctions.sharedCommonFunctions.CustomLog("dataParameter: \(dataParameter)")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                CommonFunctions.sharedCommonFunctions.CustomLog("el codigo es: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404  || httpResponse.statusCode == 401 {
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        
        Variables.sharedVariables.currentTask!.resume()
    }
    class func loadDataFromURLPost(_ dataParameter: [String:AnyObject], httpMethod: String, url: URL, completion:@escaping (_ data: NSData?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = httpMethod//POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dataParameter, options: JSONSerialization.WritingOptions.init(rawValue: 2))
        }
        catch {
            // Error Handling
            CommonFunctions.sharedCommonFunctions.CustomLog("NSJSONSerialization Error")
        }
        CommonFunctions.sharedCommonFunctions.CustomLog("dataParameter: \(dataParameter)")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        Variables.sharedVariables.currentTask = session.dataTask(with: request as URLRequest) {data, response, error in
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                CommonFunctions.sharedCommonFunctions.CustomLog("el codigo es: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.activgard", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    //404 contains 200 response with error messages
                    if httpResponse.statusCode == 404  || httpResponse.statusCode == 401 {
                        completion(data as NSData?, statusError)
                    }else{
                        completion(nil, statusError)
                    }
                } else {
                    completion(data as NSData?, nil)
                }
            }
        }
        
        Variables.sharedVariables.currentTask!.resume()
    }
    
}
