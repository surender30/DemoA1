//
//  SocialVC.swift
//  TextMaxx Pro
//
//  Created by surender on 18/01/17.
//  Copyright © 2017 Trigma. All rights reserved.
//

import UIKit

class SocialVC: UIViewController,UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    var navigationTitle = String()
    var webURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupMenuBarButtonItems()

        let urlWEB = (NSURL (string: webURL))!
        let requestObj = NSURLRequest(url: urlWEB as URL)
        webView.loadRequest(requestObj as URLRequest)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Menu Items
    
    func setupMenuBarButtonItems () {
        self.navigationItem.leftBarButtonItem = self.leftMenuBarButtonItem()
    }
    
    func leftMenuBarButtonItem () -> UIBarButtonItem {
        let leftMenu: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "left-icon"), style: .plain, target: self, action: #selector(SocialVC.btnLeftMenuClicked))
        
        leftMenu.tintColor = UIColor.white
        return leftMenu
    }
    
    func btnLeftMenuClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationItem.title = navigationTitle
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        CommonFunctions.sharedCommonFunctions.inactivateView(self.view, loaderText: loading)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
         CommonFunctions.sharedCommonFunctions.activateView(self.view)
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
