//
//  RegistrarViewController.swift
//  appServiciosGeneralesJT
//
//  Created by m1 on 11/05/2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import SafariServices
import FBSDKLoginKit

class RegistrarViewController: UIViewController {
    
    private let db = Firestore.firestore()
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtClave: UITextField!
    
    @IBOutlet weak var txtxClave2: UITextField!
    
    @IBOutlet weak var opcTipoUsuario: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnCrearCuenta(_ sender: Any) {
        
        if let name = txtName.text   , let correo = txtCorreo.text, let clave = txtClave.text , let clave2 = txtxClave2.text  {
            
            let tipoUsuarioIndex = opcTipoUsuario.selectedSegmentIndex
            
            // Declarar una variable para guardar el tipo de usuario seleccionado
            var tipoUsuario: String
            
            // Determinar el tipo de usuario seleccionado y asignarlo a la variable
            switch tipoUsuarioIndex {
            case 0:
                tipoUsuario = "Cliente"
            case 1:
                tipoUsuario = "Adminitrador"
            default:
                tipoUsuario = "Opción no definida"
            }
            
            if(clave != clave2){
                let alertController = UIAlertController(title: "Aceptar", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion:  nil )
            } else {
                
                Auth.auth().createUser(withEmail: correo, password: clave) { result, error in
                    if   let result = result , error == nil {
                        
                        self.db.collection("users").document(correo).setData([
                            "nombre"  : name,
                            "tipo"  : tipoUsuario,
                            "clave"    : clave])
                        
                        self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                        
                        
                    }else {
                        
                        let alertController = UIAlertController(title: "Aceptar", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true, completion:  nil )
                        
                    }
                }
                
            }
            
            
            
        }
        
        
    }
}
