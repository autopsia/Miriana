import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    @IBOutlet weak var txtFirstName: CSMTextField!
    @IBOutlet weak var txtLastName: CSMTextField!
    @IBOutlet weak var txtEmail: CSMTextField!
    @IBOutlet weak var txtNick: CSMTextField!
    @IBOutlet weak var txtPassword: CSMTextField!
    @IBOutlet weak var txtRePassword: CSMTextField!
    @IBOutlet weak var lblMessage: CSMLabel!
    @IBOutlet weak var ivPhoto: CSMImageView!
    
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openGallery(tapGestureRecognizer:)))
        ivPhoto.isUserInteractionEnabled = true
        ivPhoto.addGestureRecognizer(tapGestureRecognizer)
        
        picker.delegate = self
    }
    
    @objc func openGallery(tapGestureRecognizer: UITapGestureRecognizer)
    {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        let objUser = User()
        objUser.firstName = txtFirstName.text?.trim() ?? ""
        objUser.lastName = txtLastName.text?.trim() ?? ""
        objUser.nick = txtNick.text?.trim() ?? ""
        objUser.email = txtEmail.text?.trim() ?? ""
        objUser.password = txtPassword.text?.trim() ?? ""
        signIn(user: objUser)
    }
    
    func signIn(user: User){
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, err) in
            guard let uId = Auth.auth().currentUser?.uid else { return }
            self.uploadImage(uId: uId, user: user)
        }
    }
    
    func uploadImage(uId: String, user: User){
        guard let data = ivPhoto.image?.jpegData(compressionQuality: 0.75) else { return }
        let userRef = Storage.storage().reference().child(uId).child("avatar")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = userRef.putData(data, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                return
            }
            
            userRef.downloadURL { (url, error) in
                guard url != nil else {
                    return
                }
                user.urlImage = url?.absoluteString ?? ""
                self.sigInFireStore(uId: uId, user: user)
            }
        }
    }
    
    func sigInFireStore(uId:String, user: User){
        let data = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "nick": user.nick,
            "password": user.password,
            "urlImage": user.urlImage
        ]
        Firestore.firestore().collection("users").document(uId).setData(data) { err in
            if err != nil {
                self.lblMessage.text = "Error al registrarse"
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            ivPhoto.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
