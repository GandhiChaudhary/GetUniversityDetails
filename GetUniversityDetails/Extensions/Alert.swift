
import Foundation
import UIKit

extension UIViewController {
    func showAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true)
        alertController.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
    }
}
