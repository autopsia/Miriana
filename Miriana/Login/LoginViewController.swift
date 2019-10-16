import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: CSMTextField!
    @IBOutlet weak var txtPassword: CSMTextField!
    @IBOutlet weak var lblMessage: CSMLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnLogIn(_ sender: Any) {
        guard let email = self.txtEmail.text?.trim() else { return }
        guard let password = self.txtPassword.text?.trim() else { return }
        
        logIn(email: email, password: password)
    }
    
    func logIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if user != nil {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
            }
            else {
                self.lblMessage.text = "Email y/o contraseña incorrecta"
            }
        }
    }
}
