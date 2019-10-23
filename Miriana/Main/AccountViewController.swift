import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    var urlImage = ""
    
    @IBOutlet weak var ivPhoto: CSMImageView!
    @IBOutlet weak var lblNick: CSMLabel!
    @IBOutlet weak var lblName: CSMLabel!
    @IBOutlet weak var lblEmail: CSMLabel!
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        getData()
    }
    
    @IBAction func btnChangePhoto(_ sender: Any) {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
//            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
//            view.window?.rootViewController = viewController
//            view.window?.makeKeyAndVisible()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
            
            let storage = Storage.storage()
            let refStorage = storage.reference()
            let imgRef = refStorage.child(Auth.auth().currentUser!.uid).child("avatar.jpeg")
            
            imgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    let image = UIImage(data: data!)
                    self.ivPhoto.image = image
                }
            }
            
            let nombre = data["firstName"] as! String
            let apellido = data["lastName"] as! String
            self.lblName.text = nombre + " " + apellido
            self.lblNick.text = data["nick"] as? String
            self.lblEmail.text = data["email"] as? String
        }
    }
}

extension AccountViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            ivPhoto.image = image
            uploadImage(uId: firebaseAuth.currentUser?.uid ?? "")
        }
        
        self.dismiss(animated: true, completion: nil)
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
                self.urlImage = url!.absoluteString
                self.updateData(uId: uId)
            }
        }
    }
    
    func updateData(uId:String){
        let data = [
            "urlImage": self.urlImage
        ]
    }
}
