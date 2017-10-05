//
//  Constants.swift
// Restaurant
//
//  Created by Divya Khanna on 9/23/16.
//  Copyright © 2016 Divya Khanna. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
// Enable/Disable Logs
let enableLogs = 0

// Webservices
let appUrl = "https://api.paymaxxpro.com/sms/"
let imageStoreApi = "file/store"
let loginApi = "tokenize"
let userApi  = "user"
let groupApi = "tags"
let verifyApi = "verify"
let verifiedApi = "verified"
let accountsApi = "accounts"
let payApi      = "pay"
let recentMessagesApi = "messages"
let contactListApi = "cells"
let messageListApi = "messages"
let awaitsApi       = "awaits"
let templateApi     = "templates"
let uiApi           = "ui"
let cellApi         = "cell"

let sendMessageApi    = "send"
let readCellApi    = "cell"
let registerApi = "userRegistration"
let forgotPwdApi = "forgotPassword"
let logoutApi = "logout"
let carDetailsApi = "getCars"
let broadcastApi = "broadcast"

// Common Strings - Alerts
let appTitle = "TextMaxxPro"
let internetNotAvailableTitle = "Internet Not Available"
let internetNotAvailableMsg = "Please check your internet connection."
let noDataAvailableTitle = "No Data Available"
let pleaseTryAgainMsg = "Please try again."
let messageSuccessfulLogin = "Login Successfully... redirecting..."
let messageUnsuccessfulLogin = "Invalid credentials or Your account may not be active."
let enterEmailMsg = "Please enter email."
let invalidEmailMsg = "Please enter valid email address."


// Common Strings - Loading Indicator
let loading = "Please Wait"

// Common Strings - NSUserDefaults
let loggedInUserNameKey = "Logged_In_Username"
let loggedInUserId = "Logged_In_User_Id"
let loggedInUserEmailKey = "Logged_In_Email"
let loggedInUserAccesstokenKey = "Logged_In_UserToken"

let loggedInPwdKey = "Logged_In_Password"
let loggedInSocialTypeKey = "Logged_In_Social_Type"


// Common Images
// MARK: - Tick Images
let tickimage: UIImage = UIImage(named: "tick")!
let blankimage: UIImage = UIImage(named: "tick-blank")!


let customBlueColor:UIColor = UIColor(red: 243.0/255.0, green: 250.0/255.0, blue: 255.0/255.0, alpha: 1.0)

let customGreyColor:UIColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)

struct Colors {
    static let darkBlueUnreadColor = UIColor(red:0.02, green:0.47, blue:0.71, alpha:1.00)
    static let lightBackgroundColor = UIColor(red:0.03, green:0.64, blue:0.89, alpha:1.00)
    static let lightBlueBackgroundColor = UIColor(red:0.03, green:0.64, blue:0.89, alpha:1.00)
    static let darkBlueBgColorForChatTextField = UIColor(red:0.04, green:0.45, blue:0.63, alpha:1.00)
}

// Fonts

let RalewayRegular = "Raleway-Regular"
let RalewayLight = "Raleway-Light"
let RalewaySemibold = "Raleway-SemiBold"
let RobotoRegular = "Roboto-Regular"
let RobotoLight = "Roboto-Light"
let RobotoMedium = "Roboto-Medium"
