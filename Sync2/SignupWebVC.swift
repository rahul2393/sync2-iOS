//
//  SignupWebVC.swift
//  Sync2
//
//  Created by Ricky Kirkendall on 4/13/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class SignupWebVC: UIViewController{
    
    private var webView: WKWebView?
    
    override func loadView(){
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        
        if let url = URL(string:"https://www.sixgill.com/sign-up-dev/"){
            let req = URLRequest(url:url)
            webView?.load(req)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SignupWebVC.dismiss as (SignupWebVC) -> () -> ()))
        doneButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = doneButton
    }
    
    func dismiss(){
        self.dismiss(animated: true) {
            
        }
    }
    
    
}
