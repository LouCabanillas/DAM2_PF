//
//  HomeViewController.swift
//  appServiciosGeneralesJT
//
//  Created by m1 on 10/05/2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

enum ProviderType : String {
    
    case basic
    // case google
    // case facebook
    
}

class HomeViewController: UIViewController {

    private let db = Firestore.firestore()
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var providerLabel: UILabel!
    
    @IBOutlet weak var closeSessionButton: UIButton!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    private let email : String
    private let provider : ProviderType
    
    
    
    init(email: String , provider: ProviderType ){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
                
        emailLabel.text = email
        providerLabel.text = provider.rawValue
        
        
        //GUARDAMOS LOS DATOS DEL USUARIO EN uSERDEFAULTS

        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()

    }
    
    @IBAction func closeSessionButtonAction(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        switch provider {
        case .basic:
            do {
                try Auth.auth().signOut()
                
                navigationController?.popViewController(animated: true)
                
            } catch  {
                // se ha cometido un error
            }
       
        }
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        view.endEditing(true)
                
        db.collection("users").document(email).setData([
            "provider" : provider.rawValue ,
            "clave"  : addressTextField.text  ?? "" ,
            "nombre"    : phoneTextField.text ?? ""  ])
        
    }
    
    @IBAction func getButtonAction(_ sender: Any) {
        
        view.endEditing(true)

        db.collection("users").document(email).getDocument { documentSnapshot, error in
            if let document = documentSnapshot , error == nil {
                if let address = document.get("clave")   as? String {
                    
                    
                    
                    self.addressTextField.text = address
                    
                } else {
                    self.addressTextField.text = ""
                }
                
                if let phone = document.get("nombre") as? String {
                    
                    
                    self.phoneTextField.text = phone
                }else {
                    
                    self.phoneTextField.text = ""
                    
                }
                
            }else {
                
                self.addressTextField.text = ""
                self.phoneTextField.text = ""
            }
        }

        
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        
        view.endEditing(true)
        db.collection("users").document(email).delete()
        
    }
    
}
