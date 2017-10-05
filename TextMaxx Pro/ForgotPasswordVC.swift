//
//  ForgotPasswordVC.swift
//  TextMaxx Pro
//
//  Created by surender on 18/10/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    
    
    @IBOutlet var btnForgotPassword: UIButton!
    @IBOutlet var txtField_emailAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let someFrame = CGRect(x: 0.0, y: 0.0, width: 10, height: 10)
        let text = UITextField(frame: someFrame)
        let view = UIView(frame: someFrame)
        view.addSubview(text)
        txtField_emailAddress.leftView = view
        txtField_emailAddress.leftViewMode = UITextFieldViewMode.always
        
        btnForgotPassword.layer.borderColor = UIColor.black.cgColor
        btnForgotPassword.layer.borderWidth = 1.0

        // Do any additional setup after loading the view.
    }

    @IBAction func submitAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
