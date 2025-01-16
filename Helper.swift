//
//  Helper.swift
//  AlarmtekDemo
//
//  Created by Pratik Zora on 11/10/24.
//

import CoreFoundation
import UIKit

class Helper {
    
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }
    
    static var topSafeAreaHeight: CGFloat {
        return window?.safeAreaInsets.top ?? 0
    }
    
    static var bottomSafeAreaHeight: CGFloat {
        return window?.safeAreaInsets.bottom ?? 0
    }
    
    static var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return version ?? ""
    }
    
    static var apiLogEnabled = true
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0 ..< length).map { _ in letters.randomElement()! })
    }
    
    static var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    static let isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    static var topController: UIViewController? {
        if var topController = window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
    
    static func openAlert(
        title: String? = nil,
        message: String? = nil,
        actions: [UIAlertAction] = [.dismissAction]
    ) {
        topController?.openAlert(
            title: title,
            message: message,
            actions: actions)
    }

    static func loadJson<T: Codable>(fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    static var timezones: [Timezone] {
        loadJson(fileName: "timezones", type: [Timezone].self) ?? []
    }
}
