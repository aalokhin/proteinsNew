//
//  ViewController.swift
//  proteins
//
//  Created by ANASTASIA on 7/19/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//





/*
 
 Here’s what you must do :
 Before begining the core of the projet add an icon to your application AND a Launchscreen
 and make sure the launchscreen stays some time so we can appreciate it !
 Login View Controller:
 • A user must be able to login with Touch ID using a button
 
 • If login fails you must display a popup warning authentication failed ✅
 
 • If the iPhone is not compatible the Touch ID login button should be hidden
 
 • The LoginViewController should ALWAYS be displayed when launching the app meaning
 if you press the Home button and relaunch the app whitout quitting it, it should show
 the LoginViewController ! ✅
 
 Protein List View Controller:
 • You must list all the ligands provided in ligands.txt (see resources) ✅
 • You should be able to search a ligand through the list ✅
 • If you cannot load the ligand through the website display a warning popup ✅
 • When loading the ligand you should display the spinning wheel of the activity monitor
 
 Protein View Controller:
 • Display the ligand model in 3D ✅
 • You must use CPK coloring ✅
 • You should at least represent the ligand using Balls and Sticks model ✅
 • When clicking on an atom display the atom type (C, H, O, etc.)
 • Share your modelisation through a ‘Share‘ button ✅
 • You should be able to ‘play‘ (zoom, rotate...) with the ligand in Scene Kit ✅
 */
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
        self.evokeVC()

       //authenticateUser()
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
        performSegue(withIdentifier: "ListProteinsSegue", sender: self)
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


