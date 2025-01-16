import Razorpay
import SwiftUI
import UIKit

class RazorpayController: UIViewController, RazorpayPaymentCompletionProtocol {
    let options: [AnyHashable: Any]
    let razorpayCompletion: (_ result: RazorPayResult) -> Void
    
    init(
        options: [AnyHashable : Any],
        razorpayCompletion: @escaping (_ result: RazorPayResult) -> Void
    ) {
        self.options = options
        self.razorpayCompletion = razorpayCompletion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var razorpayObj : RazorpayCheckout? = nil

    override func viewDidLoad() {
        //navigationController?.navigationBar.isHidden = true
       openRazorpayCheckout()
    }
    
    func openRazorpayCheckout() {

        print(ClientService.shared.razorPayKey)
        razorpayObj = RazorpayCheckout.initWithKey(ClientService.shared.razorPayKey, andDelegate: self)
        razorpayObj?.open(options, displayController: self)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        self.navigationController?.popViewController(animated: false)
        razorpayCompletion(.success(paymentId: payment_id))
    }
    
    func onPaymentError(_ code: Int32, description errorMessage: String) {
        self.navigationController?.popViewController(animated: false)
        razorpayCompletion(.failure(error: errorMessage))
        
    }
}

struct RazorpayView: UIViewControllerRepresentable {
    
    let options: [AnyHashable: Any]
    let razorpayCompletion: (_ result: RazorPayResult) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func makeUIViewController(context: Context) -> RazorpayController {
        let razorpayVC = RazorpayController(options: options, razorpayCompletion: razorpayCompletion)
        return razorpayVC
    }
  
    func updateUIViewController(_ uiViewController: RazorpayController, context: Context) {
        
    }
    
    class Coordinator: NSObject, RazorpayPaymentCompletionProtocol {
        
        let parent: RazorpayView
        
        init(_ parent: RazorpayView) {
            self.parent = parent
        }
        
        func onPaymentSuccess(_ payment_id: String) {
            print("Payment ID: \(payment_id)")
        }
        
        func onPaymentError(_ code: Int32, description errorMessage: String) {
            print("Error Code: \(code)")
            print("Error Message: \(errorMessage)")
        }
    }
}
