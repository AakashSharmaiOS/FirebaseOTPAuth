import UIKit
import FirebaseAuth
import SVProgressHUD
import Toast_Swift

class ViewController: UIViewController, AuthUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
        
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        phoneNumberTextField.text = ""
    }

    //MARK:- Variables
    

    //MARK:- Outlets
    @IBOutlet weak var phoneNumberTextField : UITextField!
    

    //MARK:- Functions
    func verifyMethod(){
        SVProgressHUD.show()
        PhoneAuthProvider.provider().verifyPhoneNumber("+91\(phoneNumberTextField.text!)", uiDelegate: self) { (verificationID, error) in
          if let error = error {
            print(error.localizedDescription)
            self.view.makeToast(error.localizedDescription)
            SVProgressHUD.dismiss()
            return
          }
            print(verificationID ?? "")
            SVProgressHUD.dismiss()
            let authVc =  self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
            authVc.verifyId = verificationID
            self.navigationController?.pushViewController(authVc, animated: true)
        }
    }

    //MARK:- Actions
    @IBAction func authAction(_ sender : UIButton){
        if phoneNumberTextField.text?.isEmpty == true {
            view.makeToast("Enter mobile number")
        }
        else {
        verifyMethod()
        }
     
    }

}

//MARK:-  UITextFieldDelegate
extension ViewController : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
}
