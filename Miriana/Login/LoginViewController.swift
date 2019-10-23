import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: CSMTextField!
    @IBOutlet weak var txtPassword: CSMTextField!
    @IBOutlet weak var lblMessage: CSMLabel!
    @IBOutlet weak var buttonLogin: CSMButton!
    
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
        buttonLogin.isUserInteractionEnabled = false
        buttonLogin.isEnabled = false
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if user != nil {
                self.performSegue(withIdentifier: "TabBarController", sender: nil)
            }
            else {
                self.lblMessage.text = "Email y/o contraseña incorrecta"
            }
            self.buttonLogin.isEnabled = true
        }
    }
}
