import UIKit
import Alamofire
import SwiftyJSON
class ObjectsViewController: UIViewController {
    
    
    var objectData : [ObjectModel] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.+
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.register(UINib(nibName: "ObjectsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "objectsCell")
        
        fetchObjectsData()
        
    }
    
    func fetchObjectsData(){
        
        DispatchQueue.main.async {
            AF.request("https://private-b84f1f-cibertecapi.apiary-mock.com/listado").responseJSON { (response) in
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value )
                    let data = json["data"]
                    data["users"].array?.forEach({ (object) in
                        let object = ObjectModel(name: object["name"].stringValue, email: object["email"].stringValue)
                        self.objectData.append(object)
                    })
                    self.tableView.reloadData()
                    print(json)
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
        
    }
    
    
}
extension ObjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.objectData.count)
        return self.objectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "objectsCell", for: indexPath) as! ObjectsTableViewCell
        print(cell)
        cell.nameLabel.text = self.objectData[indexPath.row ].name
        cell.emailLabel.text = self.objectData[indexPath.row ].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected = objectData[indexPath.row].email
        navigationController?.pushViewController(DetalleObjectsViewCellViewController(email: selected), animated: true)
    }
    
}



