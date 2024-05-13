//
//  ViewController.swift
//  appServiciosGeneralesJT
//
//  Created by m1 on 10/05/2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import SafariServices
import FBSDKLoginKit

class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var authStackView: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authStackView.isHidden = false
    }
        
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //comprobamos la sesión del usuari autenticado
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String ,
           let provider = defaults.value(forKey: "provider") as? String {
            
            
            authStackView.isHidden = true
            
            
            navigationController?.pushViewController(HomeViewController(email: email, provider: ProviderType.init(rawValue: provider)!), animated: false)
            
        }

        
    }
    

    @IBAction func signUpButtonAction(_ sender: Any) {
        
        //self.navigationController?.pushViewController(RegistrarViewController(), animated: true)
        
        /*if let email = emailTextField.text   , let password = passwordTextField.text {
            
            
                    
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if   let result = result , error == nil {
                    
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                    
                    
                }else {
                    
                    let alertController = UIAlertController(title: "Aceptar", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion:  nil )
                    
                }
            }
            
            
        }*/
        
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text   , let password = passwordTextField.text {
                    
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if   let result = result , error == nil {
                    
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                    
                    
                }else {
                    
                    let alertController = UIAlertController(title: "Aceptar", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion:  nil )
                    
                }
            }
            
            
        }
        
    }
    
    @IBAction func listadoObjectsButtonAction(_ sender: Any) {
        navigationController?.pushViewController(ObjectsViewController(), animated: true)
    }
    
    @IBAction func loginGoogleButtonAction(_ sender: Any) {
        
        if let url = URL(string: "https://accounts.google.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func loginFacebookButtonAction(_ sender: Any) {
        
        if let url = URL(string: "https://www.facebook.com/login.php") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
}
