import UIKit
import FirebaseAuth
import SVProgressHUD

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

    //MARK:- Variables
    var verifyId : String?

    //MARK:- Outlets
    @IBOutlet weak var codeTextField : UITextField!

    //MARK:- Functions
    func checkCodeMethod(_ credential : AuthCredential){
        SVProgressHUD.show()
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            let authError = error as NSError
            if (authError.code == AuthErrorCode.secondFactorRequired.rawValue) {              print(error.localizedDescription)
                Alert.show(vc: self, titleStr: "Error", messageStr: error.localizedDescription)
                SVProgressHUD.dismiss()
              return
            }
            Alert.show(vc: self, titleStr: "Error", messageStr: error.localizedDescription)
            SVProgressHUD.dismiss()
            return
          }
            print(authResult?.additionalUserInfo)
            SVProgressHUD.dismiss()
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVc, animated: true)
        }
    }

    //MARK:- Actions
    @IBAction func verifyAction(_ sender : UIButton){
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verifyId ?? "",
        verificationCode: codeTextField.text!)
        self.checkCodeMethod(credential)
    }
}

//MARK:- UITextFieldDelegate
extension AuthViewController : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            if (textField.text?.count ?? 0) >= 6 {
                self.view.endEditing(true)
            }
        }
        return newString.length <= maxLength
    }
    
}
