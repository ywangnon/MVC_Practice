//
//  ViewController.swift
//  MVC_1
//
//  Created by Hansub Yoo on 2022/06/28.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var responeArray = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    
    func callAPI() {
        AF.request(URL(string: "https://jsonplaceholder.typicode.com/posts")!,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .response { (response) in
            if let responseData = response.data {
                do {
                    let decodedJson = JSONDecoder()
                    decodedJson.keyDecodingStrategy = .convertFromSnakeCase
                    // 데이터를 읽어와서 데이터모델에 채워 넣는다.
                    self.responeArray = try decodedJson.decode([DataModel].self, from: responseData)
                    self.tableView.reloadData()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 데이터모델로부터 데이터를 얻고 있다.
        cell.textLabel?.text = String(responeArray[indexPath.row].id ?? 0)
        cell.detailTextLabel?.text = responeArray[indexPath.row].title
        return cell
    }
}
