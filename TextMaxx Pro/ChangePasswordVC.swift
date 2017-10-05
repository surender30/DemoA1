//
//  ChangePasswordVC.swift
//  TextMaxx Pro
//
//  Created by surender on 14/11/16.
//  Copyright © 2016 Trigma. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupMenuBarButtonItems()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Menu Items
    
    func setupMenuBarButtonItems () {
        self.navigationItem.leftBarButtonItem = self.leftMenuBarButtonItem()
        self.navigationItem.rightBarButtonItem = self.rightMenuBarButtonItem()
    }
    
    func leftMenuBarButtonItem () -> UIBarButtonItem {
        let leftMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "left-icon"), style: .plain, target: self, action: #selector(ChangePasswordVC.btnLeftMenuClicked))
        
        leftMenu.tintColor = UIColor.white
        return leftMenu
    }
    
    func btnLeftMenuClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightMenuBarButtonItem () -> UIBarButtonItem {
        let rightMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "check"), style: .plain, target: self, action: #selector(ChangePasswordVC.btnRightMenuClicked))
        rightMenu.tintColor = UIColor.white
        return rightMenu
    }
    
    func btnRightMenuClicked() {
        self.view .endEditing(true)
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "FindUserVC")as! FindUserVC
        self.navigationController?.pushViewController(VC, animated: true)
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
