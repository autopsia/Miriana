import UIKit
import FirebaseAuth

class RecoverViewController: UIViewController {
    @IBOutlet weak var txtEmail: CSMTextField!
    @IBOutlet weak var lblMessage: CSMLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSend(_ sender: Any) {
        guard let email = self.txtEmail.text?.trim() else { return }
        self.sendEmail(email: email)
    }
    
    func sendEmail(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (err) in
            if err == nil {
                self.dismiss(animated: true)
            }
            else {
                self.lblMessage.text = "Error al enviar correo de recuperación"
            }
        }
    }
}
