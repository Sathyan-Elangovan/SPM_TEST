//
//  LaunchChatViewController.swift
//  SPM MIGRATION
//
//  Created by sathyan elangovan on 03/03/22.
//

import Foundation
import UIKit
import Kommunicate
import KommunicateChatUI_iOS_SDK
class LaunchChatViewController: UIViewController, ALKCustomEventCallback {
    func eventTriggered(eventName: CustomEvent, data: [String : Any]?) {
        print("Event Name \(eventName) data \(data)")
    }
    
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let eventList = [
                 CustomEvent.attachmentClick,
                 CustomEvent.faqClick,
                 CustomEvent.locationClick,
                 CustomEvent.messageSend,
                 CustomEvent.notificationClick,
                 CustomEvent.voiceClick
                ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = CGPoint(x: view.bounds.size.width / 2,
                                           y: view.bounds.size.height / 2)
        view.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
    }

    @IBAction func launchConversation(_: Any) {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
//      
     

       
      
        Kommunicate.createAndShowConversation(from: self, completion: {
            error in
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            if error != nil {
                print("Error while launching")
            }
        })
    }

    @IBAction func logoutAction(_: Any) {
        Kommunicate.logoutUser { result in
            switch result {
            case .success:
                print("Logout success")
                self.dismiss(animated: true, completion: nil)
            case .failure:
                print("Logout failure, now registering remote notifications(if not registered)")
                if !UIApplication.shared.isRegisteredForRemoteNotifications {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { granted, _ in
                        if granted {
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

}
