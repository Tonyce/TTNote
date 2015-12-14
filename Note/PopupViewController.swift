


import UIKit

class PopupViewController: UIViewController {
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: 100, height: 150)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
}