import UIKit
import FirebaseAuth

class InicioController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.performSegue(withIdentifier: "TabBarController", sender: nil)
                //                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                //                self.view.window?.rootViewController = viewController
                //                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}
