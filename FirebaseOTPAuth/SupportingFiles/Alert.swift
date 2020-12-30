import UIKit
import Toast_Swift

class Alert {
    
    static func show(vc:UIViewController,titleStr:String, messageStr:String) -> Void
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
