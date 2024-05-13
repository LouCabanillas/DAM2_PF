//
//  DetalleObjectsViewCellViewController.swift
//  appServiciosGeneralesJT
//
//  Created by m1 on 12/05/2024.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


class DetalleObjectsViewCellViewController: UIViewController {

    private let email : String
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblGenero: UILabel!
    
    @IBOutlet weak var lblCelular: UILabel!
    
    @IBOutlet weak var lblCorreo: UILabel!
    
    var datos = [[String : Any]]()
    
    init(email: String){
        self.email = email
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSONData()


        // Do any additional setup after loading the view.
    }
    
    func getJSONData(){
           
        let urlFile = "https://private-b84f1f-cibertecapi.apiary-mock.com/buscar?correo=" + self.email

        AF.request(urlFile).responseJSON { response in
            
            print(response)
            
            switch response.result {
            case .success(let value):
                if let jsondata = value as? [String: Any] {
                    self.datos = [jsondata]
                    if let name = jsondata["name"] as? String,
                       let mail = jsondata["email"] as? String,
                       let mobile = jsondata["mobile"] as? String,
                       let gender = jsondata["gender"] as? String,
                       let imageURL = jsondata["image"] as? String{
                        
                        print(name)
                        print(mail)
                        print(mobile)
                        print(gender)
                        print(imageURL)
                        
                        self.lblNombre.text = name
                        self.lblCorreo.text = mail
                        self.lblCelular.text = mobile
                        self.lblGenero.text = gender
                        
                        AF.request(imageURL).responseImage { response in
                            switch response.result {
                            case .success(let image):
                                DispatchQueue.main.async {
                                    self.imagen.image = image
                                }
                            case .failure(let error):
                                print("Error al cargar la imagen: \(error.localizedDescription)")
                            }
                        }


                        
                        
                        
                    } else {
                        print("No se pudo obtener el nombre del elemento.")
                    }
                } else {
                    print("Los datos no están en el formato esperado.")
                }
            case .failure(let error):
                print("Ocurrió un error en \(error.localizedDescription)")
            }
        }


       
       
   }


}
