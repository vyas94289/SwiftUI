//
//  Toast.swift

import Foundation
import UIKit

enum MessageAlertState {

    case success, warning, failure, info

    var backgroundColor: UIColor {
        switch self {
        case .success:
            return #colorLiteral(red: 0.1958795544, green: 0.5833533554, blue: 0, alpha: 1)
        case .failure:
            return #colorLiteral(red: 0.6951127825, green: 0, blue: 0, alpha: 1)
        case .info:
            return #colorLiteral(red: 0, green: 0, blue: 0.7278106876, alpha: 1)
        case .warning:
            return #colorLiteral(red: 0.701996657, green: 0.6433976133, blue: 0.07563231699, alpha: 1)
        }
    }

    var icon: UIImage {
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.circle")!
        case .failure:
            return UIImage(systemName: "multiply.circle")!
        case .info:
            return UIImage(systemName: "info.circle")!
        case .warning:
            return UIImage(systemName: "exclamationmark.circle")!
        }
    }
}

class Toast {
    
    static func show(with message: String, state: MessageAlertState) {
        guard let window = Helper.window else { return }
        
        let toastContainer = UIView(frame: CGRect())
       
        let toastLabel = UILabel(frame: CGRect())
        let statusImage = UIImageView(frame: CGRect())
        statusImage.contentMode = .scaleAspectFit
        toastContainer.backgroundColor = state.backgroundColor
        statusImage.image = state.icon
        statusImage.layer.cornerRadius = 15
        statusImage.tintColor = .white
        statusImage.clipsToBounds = true
        
        toastContainer.alpha = 1.0
        toastContainer.layer.cornerRadius = 15
        toastContainer.clipsToBounds = true
        
        toastLabel.textAlignment = .left
        
        toastLabel.text = message
        toastLabel.font = UIFont.systemFont(ofSize: 17)
        toastLabel.textColor = .white
        
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(statusImage)
        toastContainer.addSubview(toastLabel)
        
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let image1 = NSLayoutConstraint(item: statusImage, attribute: .leading, relatedBy: .equal,
                                        toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        statusImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        statusImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let image4 = NSLayoutConstraint(item: statusImage, attribute: .centerY, relatedBy: .equal,
                                        toItem: toastContainer, attribute: .centerY, multiplier: 1, constant: 0)
        toastContainer.addConstraints([image1, image4])
        
        let toastLabel1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal,
                                             toItem: statusImage, attribute: .trailing, multiplier: 1, constant: 15)
        let toastLabel2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal,
                                             toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let toastLabel3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal,
                                             toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let toastLabel4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal,
                                             toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([toastLabel1, toastLabel2, toastLabel3, toastLabel4])
        
        window.addSubview(toastContainer)
        
        let container1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal,
                                            toItem: window, attribute: .leading, multiplier: 1, constant: 20)
        let container2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal,
                                            toItem: window, attribute: .trailing, multiplier: 1, constant: -20)
        let container3 = NSLayoutConstraint(item: toastContainer, attribute: .top, relatedBy: .equal,
                                            toItem: window, attribute: .top, multiplier: 1, constant: 0)
        window.addConstraints([container1, container2, container3])
        
        DispatchQueue.main.async {
            container3.constant = 50
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                options: .allowUserInteraction,
                animations: {
                    window.layoutIfNeeded()
                }, completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        container3.constant = 0
                        UIView.animate(withDuration: 0.1) {
                            window.layoutIfNeeded()
                        } completion: { _ in
                            toastContainer.removeFromSuperview()
                        }
                    }
                })
        }
        
        let button = UIButton(type: .custom)
        toastContainer.addSubview(button)
        button.frame = toastContainer.bounds
        let action = UIAction { _ in
            container3.constant = 0
            UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction) {
                window.layoutIfNeeded()
            } completion: { _ in
                toastContainer.removeFromSuperview()
            }
        }
        if #available(iOS 14.0, *) {
            button.addAction(action, for: .touchUpInside)
        }
    }
}
