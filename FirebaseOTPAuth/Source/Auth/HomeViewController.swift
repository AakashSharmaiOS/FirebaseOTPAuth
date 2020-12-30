import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(self.logOutAction(_:)))
        self.navigationItem.leftBarButtonItem = leftButton
    }

    
    @IBAction func logOutAction(_ sender : UIBarButtonItem){
        if let viewController = self.navigationController?.viewControllers.first(where: {$0 is ViewController}) {
            self.navigationController?.popToViewController(viewController, animated: true)
        }
    }

}
