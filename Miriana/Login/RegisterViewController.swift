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
    var objUser = User()
    
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
        objUser.firstName = txtFirstName.text?.trim() ?? ""
        objUser.lastName = txtLastName.text?.trim() ?? ""
        objUser.nick = txtNick.text?.trim() ?? ""
        objUser.email = txtEmail.text?.trim() ?? ""
        objUser.password = txtPassword.text?.trim() ?? ""
        signIn()
    }
    
    func signIn(){
        Auth.auth().createUser(withEmail: objUser.email, password: objUser.password) { (result, err) in
            guard let uId = Auth.auth().currentUser?.uid else { return }
            self.uploadImage(uId: uId)
        }
    }
    
    func uploadImage(uId: String){
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
                self.objUser.urlImage = url!.absoluteString
                self.sigInFireStore(uId: uId)
            }
        }
    }
    
    func sigInFireStore(uId:String){
        let data = [
            "firstName": objUser.firstName,
            "lastName": objUser.lastName,
            "email": objUser.email,
            "nick": objUser.nick,
            "password": objUser.password,
            "urlImage": objUser.urlImage
        ]
        Firestore.firestore().collection("users").document(uId).setData(data) { err in
            if err != nil {
                self.lblMessage.text = "Error al registrarse"
            } else {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
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
