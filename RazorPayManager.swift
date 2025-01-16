//
//  RazorPayManager.swift
//  StrataPanel
//
//  Created by Gaurang on 17/11/23.
//

import Razorpay
import Foundation

enum RazorPayResult {
    case success(paymentId: String)
    case failure(error: String)
}

class RazorPayManager: NSObject, RazorpayPaymentCompletionProtocol {
    
    let callBack: (_ result: RazorPayResult) -> Void
    
    private lazy var checkout = RazorpayCheckout.initWithKey(
        ClientService.shared.razorPayKey,
        andDelegate: self
    )
    
    init(callBack: @escaping (_ result: RazorPayResult) -> Void) {
        self.callBack = callBack
        super.init()
    }
    
    func pay(
        razorPayOptions: RazorPayOptions
    ) {
        checkout.open(razorPayOptions.options)
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        callBack(.failure(error: str))
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        callBack(.success(paymentId: payment_id))
    }
    
}

struct RazorPayOptions {
    let orderID, phone, email, image, name: String
    let currency: String = ClientService.shared.currency
    let amount: Double
    
    var options: [AnyHashable:Any] {
        [
            "prefill": [
                "contact": phone,
                "email": email
            ],
            "order_id": orderID,
            "image": "",
            "amount" : amount,
            "currency": currency,
            "name": name,
            "theme": [
                "color": "#1A2E89"
            ]
        ]
    }
}

