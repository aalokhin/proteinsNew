//
//  ViewController.swift
//  proteins
//
//  Created by ANASTASIA on 7/19/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import UIKit
import LocalAuthentication


class LoginViewController: UIViewController {
    var authenticated : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fingerPrintAuthenticationTapped(_ sender: UIButton) {
        authenticateUser()
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        print("success")
                        
                        
                        
                        self.evokeVC()
                        
                        
                        
                        
                        //self.runSecretCode()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func evokeVC(){
        
//                                    let storyboard = UIStoryboard.init(name: "ListProteins", bundle: nil)
//                                    let vc = storyboard.instantiateViewController(withIdentifier : "ListProteinsVC")
        
        performSegue(withIdentifier: "ListProteinsSegue", sender: self)
                                 //  self.navigationController?.pushViewController(vc, animated: true)
        

    }
}



extension LoginViewController {
    
    func showAlertController(_ message: String) {
        
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: UIAlertController.Style.alert
        );
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


