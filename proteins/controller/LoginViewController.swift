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
 • A user must be able to login with Touch ID using a button ☑️
 
 • If login fails you must display a popup warning authentication failed ✅
 
 • If the iPhone is not compatible the Touch ID login button should be hidden ✅
 
 • The LoginViewController should ALWAYS be displayed when launching the app meaning
 if you press the Home button and relaunch the app whitout quitting it, it should show
 the LoginViewController ! ✅
 
 Protein List View Controller:
 • You must list all the ligands provided in ligands.txt (see resources) ✅
 • You should be able to search a ligand through the list ✅
 • If you cannot load the ligand through the website display a warning popup ✅
 • When loading the ligand you should display the spinning wheel of the activity monitor ☑️ ===> too fast to understand what's happening:c
 
 Protein View Controller:
 • Display the ligand model in 3D ✅ ==== > still need to fix connection and all the staff
 • You must use CPK coloring ✅
 • You should at least represent the ligand using Balls and Sticks model ✅
 • When clicking on an atom display the atom type (C, H, O, etc.)  // almost --- > ✅
 • Share your modelisation through a ‘Share‘ button ✅
 • You should be able to ‘play‘ (zoom, rotate...) with the ligand in Scene Kit ✅
 */
import UIKit
import LocalAuthentication


class LoginViewController: UIViewController {
    var authenticated : Bool = false
     var error: NSError?
    var authenticationContext = LAContext()
    var buttonImage : UIImage?
    
    @IBOutlet weak var touchIdButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let backgroundImg = UIImage(named: "dark"){
//            self.view.backgroundColor = UIColor(patternImage: backgroundImg)
//        }
        touchIdButton.isHidden = true
        print("hello")
        setUpLoginButton()
        
    }
    
    @IBAction func fingerPrintAuthenticationTapped(_ sender: UIButton) {
       // self.evokeVC()
        authenticateUser() // this thing is supposed to allow authentication
    }
    
    func authenticateUser() {
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        print("success")
                        self.evokeVC()
                    }
                    else {
                        //when user cancels or chooses not to use face id
                        if let error = authenticationError {
                            print(">>>>",  error.localizedDescription)
                            if (self.authCancelledOrFallbackSelected(error) == false){
                                self.callErrorWithCustomMessage("Authentication failed")
                            }
                            if(error.localizedDescription == "Fallback authentication mechanism selected."){
                                
                            }
                        }
                    }
                    
                    self.authenticationContext = LAContext()
                }

            }
        }  else {
           // self.evokeVC()
            print("we'll get back some day")
            
            touchIdButton.isHidden =  true
            self.callErrorWithCustomMessage("Your hardware doesn't support biometric authentication")
        }
    }
    
    func authCancelledOrFallbackSelected(_ authenticationError : Error)-> Bool {
        if (authenticationError.localizedDescription == "Canceled by user."){
            return true
        } else if (authenticationError.localizedDescription == "Fallback authentication mechanism selected.") {
            return true
            
        } else {
            return false
        }
        
    }
    func evokeVC(){
        performSegue(withIdentifier: "ListProteinsSegue", sender: self)
    }
}



extension LoginViewController {
    
    func setUpLoginButton(){
        if (authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
//            else {
//            print("Authentication not supported")
//            callErrorWithCustomMessage("Biometric authentication not supported")
//
//            return
//        }
            switch authenticationContext.biometryType {
            case .faceID:
                buttonImage = UIImage(named: "facewhite")
                touchIdButton.setImage(buttonImage, for: .normal)
                touchIdButton.isHidden = false
                print("can authenticate with Face id")
            case .touchID:
                buttonImage = UIImage(named: "whitetouch2")
                touchIdButton.setImage(buttonImage, for: .normal)
                touchIdButton.isHidden = false
                print("can authenticate with touch id")
            case .none:
                touchIdButton.isHidden = true
                print("can't authenticate neither with touch id nor with face id")
                //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if (authenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)){
                    print("no biometry but we can use passcode")
                }
                //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            @unknown default:
                print("unknown default")
                return
            }
        } else {
            print("user didn't set any authentication.")
            evokeVC()
        }
    }
 
    
}


