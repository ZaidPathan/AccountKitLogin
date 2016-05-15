//
//  ViewController.swift
//  AccountKitLogin
//
//  Created by Zaid Pathan on 14/05/16.
//  Copyright © 2016 BeMyApp. All rights reserved.
//

import UIKit
import AccountKit

class ViewController: UIViewController {

    let ACCOUNT_KIT = AKFAccountKit(responseType: .AccessToken)
    
    @IBOutlet weak var IBlblLoggedInState: UILabel!
    
    @IBAction func IBActionLoginWithPhoneNumber(sender: UIButton) {
        if let accountKitPhoneLoginVC = ACCOUNT_KIT.viewControllerForPhoneLoginWithPhoneNumber(nil, state: nil) as? AKFViewController{
            accountKitPhoneLoginVC.enableSendToFacebook = true
            accountKitPhoneLoginVC.delegate = self
            presentViewController(accountKitPhoneLoginVC as! UIViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func IBActionLoginWithEmail(sender: UIButton) {
        if let accountKitEmailLoginVC = ACCOUNT_KIT.viewControllerForEmailLoginWithEmail(nil, state: nil) as? AKFViewController{
            accountKitEmailLoginVC.enableSendToFacebook = true
            accountKitEmailLoginVC.delegate = self
            presentViewController(accountKitEmailLoginVC as! UIViewController, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//-------------------------------------------------------------------------
//MARK:- AKFViewControllerDelegate
//-------------------------------------------------------------------------
extension ViewController:AKFViewControllerDelegate{
    
    //Delegate 1
    func viewController(viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("didCompleteLoginWithAuthorizationCode")
    }
    
    //Delegate 2
    func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
            ACCOUNT_KIT.requestAccount({ (account:AKFAccount?, error:NSError?) in
                if let phoneNumber = account?.phoneNumber?.stringRepresentation(){
                   print(phoneNumber)
                    self.IBlblLoggedInState.text = "LoggedIn with \(phoneNumber)"
                }
                
                if let emailAddress = account?.emailAddress{
                   print(emailAddress)
                    self.IBlblLoggedInState.text = "LoggedIn with \(emailAddress)"
                }
                
                if let accountID = account?.accountID{
                   print(accountID)
                }
                
            })
    }
    
    //Delegate 3
    func viewController(viewController: UIViewController!, didFailWithError error: NSError!) {
        print("didFailWithError: \(error)")
    }
    
    //Delegate 4
    func viewControllerDidCancel(viewController: UIViewController!) {
        print("viewControllerDidCancel")
    }
    
}