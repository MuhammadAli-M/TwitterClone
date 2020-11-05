//
//  RegistrationDelegate.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 10/3/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit

protocol RegistrationDelegate {
    func didCompleteRegistartionSuccessfully()
}

extension RegistrationDelegate where Self:UIViewController{
    
    func didCompleteRegistartionSuccessfully(){
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        
        guard let tab = window.rootViewController as? MainTabController else {return}
        
        tab.authenticateUserAndConfigureUI()
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

