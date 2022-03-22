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
//        activityIndicator.startAnimating()
//        view.isUserInteractionEnabled = false
//      
       // Kommunicate.subscribeCustomEvents(events: eventList, callback: self)
        Kommunicate.showConversations(from: self)
//        let conversationId = "69976153"
//        Kommunicate.showConversationWith(groupId: "69976153", from: self, prefilledMessage: "Hi how are you doing") { (success) in
//              }
        
//        let kmConversation = KMConversationBuilder()
//            // Optional. If Agent Id is not set, then default agent will
//            // automatically get selected. AGENT_Id is the email Id used to signup
//            // on Kommunicate dashboard.
//
//            //  To add the agents to conversations directly pass the AgentId parameter
//            .withAgentIds( ["sathyan.elangovan@kommunicate.io"])
//
//            // Using BotIds parameter the bots can be added to the conversations
//            .withBotIds(["pakka-h9zut"])
//
//            // To set the conversation assignee, pass AgentId or BotId.
//            .withConversationAssignee("sathyan.elangovan@kommunicate.io")
//
//            // To pass metadata
//            .withMetaData(["key":"value"])
//
//            // To set the custom title
//            .withConversationTitle("Support query 1")
//
//            .useLastConversation(false)
//            .build()

//        Kommunicate.createConversation(conversation: kmConversation) { result in
//            switch result {
//            case .success(let conversationId):
//                print("Conversation id: ",conversationId)
//                Kommunicate.showConversationWith(
//                    groupId: conversationId,
//                    from: self,
//                    showListOnBack: false, // If true, then the conversation list will be shown on tap of the back button.
//                    completionHandler: { success in
//                    print("conversation was shown")
//                })
//            // Launch conversation
//            case .failure(let kmConversationError):
//                print("Failed to create a conversation: ", kmConversationError)
//            }
//        }
      
//        Kommunicate.createAndShowConversation(from: self, completion: {
//            error in
//            self.activityIndicator.stopAnimating()
//            self.view.isUserInteractionEnabled = true
//            if error != nil {
//                print("Error while launching")
//            }
//        })
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
