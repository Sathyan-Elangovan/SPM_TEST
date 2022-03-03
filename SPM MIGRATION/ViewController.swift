//
//  ViewController.swift
//  SPM MIGRATION
//
//  Created by sathyan elangovan on 03/03/22.
//

import UIKit
import Kommunicate

class ViewController: UIViewController {

   
    let appid = "18ae6ce9d4f469f95c9c095fb5b0bda44"
    let activityIndicator = UIActivityIndicatorView(style: .gray)


    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = CGPoint(x: view.bounds.size.width / 2,
                                           y: view.bounds.size.height / 2)
        view.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
        // Do any additional setup after loading the view.
    }
    
    private func setupApplicationKey(_ applicationId: String) {
        guard !applicationId.isEmpty else {
            fatalError("Please pass your AppId in the AppDelegate file.")
        }
        Kommunicate.setup(applicationId: applicationId)
    }
    
    
    private func userWithUserId(
        _ userId: String,
        andApplicationId applicationId: String
    ) -> KMUser {
        let kmUser = KMUser()
        kmUser.userId = userId
        kmUser.applicationId = applicationId
        return kmUser
    }

    
    private func registerUser(_ kmUser: KMUser) {
        activityIndicator.startAnimating()
        Kommunicate.registerUser(kmUser, completion: {
            response, error in
            self.activityIndicator.stopAnimating()
            guard error == nil else {
                print("[REGISTRATION] Kommunicate user registration error: %@", error.debugDescription)
                return
            }
            self.activityIndicator.startAnimating()

            Kommunicate.createAndShowConversation(from: self, completion: {
                error in
                self.activityIndicator.stopAnimating()
                if error != nil {
                    print("Error while launching")
                }
            })
        })
    }

    @IBAction func tapped(_ sender: Any){
        print("tapped")
        setupApplicationKey(appid)
//        Kommunicate.showConversations(from: self)

        let kmUser = userWithUserId(Kommunicate.randomId(), andApplicationId: appid)
        registerUser(kmUser)

    }

    
    @IBAction func logoutTapped(_ sender: Any){
        activityIndicator.startAnimating()
        print("logout tapped")
        Kommunicate.logoutUser(completion: {_ in
            self.activityIndicator.stopAnimating()
            print("user logged out")
        })

    }

}

