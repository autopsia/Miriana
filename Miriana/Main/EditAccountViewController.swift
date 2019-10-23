import UIKit
import Firebase
import FirebaseAuth

class EditAccountViewController: UIViewController {
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    @IBOutlet weak var txtFirstName: CSMTextField!
    @IBOutlet weak var txtLastName: CSMTextField!
    @IBOutlet weak var txtEmail: CSMTextField!
    @IBOutlet weak var txtNick: CSMTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    @IBAction func btnActualizar(_ sender: Any) {
        let email = txtEmail.text
        
        if firebaseAuth.currentUser?.email == email {
            updateData()
        }
        else {
            
        }
    }
    
    func updateData(){
        let firstName = txtFirstName.text
        let lastName = txtLastName.text
        let email = txtEmail.text
        let nick = txtNick.text
        let data = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "nick": nick
        ]
        
        db.collection("users").document(firebaseAuth.currentUser?.uid ?? "").updateData(data as [AnyHashable : Any]) {
            err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func getData(){
        db.collection("users").document(firebaseAuth.currentUser?.uid ?? "").addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
        
            self.txtFirstName.text = data["firstName"] as? String
            self.txtLastName.text = data["lastName"] as? String
            self.txtEmail.text = data["email"] as? String
            self.txtNick.text = data["nick"] as? String
        }
    }
}
