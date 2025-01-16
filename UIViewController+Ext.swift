//
//  UIViewController+Ext.swift
//  Lyronel
//
//  Created by Pratik Zora on 19/12/22.
//

import UIKit

extension UIViewController {
    func openAlert(title: String? = nil,
                   message: String? = nil,
                   actions: [UIAlertAction] = [.dismissAction]
    ) {
        let alertCtr = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertCtr.addAction($0) }
        present(alertCtr, animated: true)
    }

    func configNavigation(title: String, largeTitle: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = largeTitle
        navigationItem.title = title
    }
}

extension UIAlertAction {
    
    static func okAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        UIAlertAction(title: "Okay", style: .default, handler: handler)
    }
 
    static var dismissAction: UIAlertAction {
        UIAlertAction(title: "Dismiss", style: .default)
    }

    static var cancelAction: UIAlertAction {
        UIAlertAction(title: "Cancel", style: .cancel)
    }
}
