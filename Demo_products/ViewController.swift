//
//  ViewController.swift
//  Demo_products
//
//  Created by Anand on 07/01/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var minusLbl: UIButton!
    @IBOutlet weak var plusLbl: UIButton!
    @IBOutlet weak var textQuenty: UITextField!
    @IBOutlet weak var priceLbl: UILabel!
    
}

struct ViewKey {
    static let cellIdentifier = "cell"
    static let productKey = "car"
    static let productPrice = 1000
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var productArray = [["image":"Car1", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car2", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car3", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car4", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car5", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car6", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car7", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car8", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car9", "name": "Tesla", "qty": "0", "price": "Price $ 0"],
                        ["image":"Car10","name": "Tesla", "qty": "0","price": "Price $ 0"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    @IBAction func decrementBtn(_ sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: index) as! PhotoCell
        guard let currentQty = Int(cell.textQuenty.text ?? "0"), currentQty != 0 else {
            return
        }
        let finalQty = currentQty - 1
        cell.textQuenty.text = String(finalQty)
        cell.priceLbl.text = total(qty: finalQty)
        priceChanger(total(qty: finalQty), index: index, qty: finalQty)
    }
    
    
    @IBAction func incrementBtn(_ sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: index) as! PhotoCell
        let currentQty = Int(cell.textQuenty.text ?? "0") ?? 0
        let finalQty = currentQty + 1
        cell.textQuenty.text = String(finalQty)
        cell.priceLbl.text = total(qty: finalQty)
        priceChanger(total(qty: finalQty), index: index, qty: finalQty)
    }
    
    func total(qty: Int)-> String{
        let price = qty * ViewKey.productPrice
        return String(format: "Price $ %d", price)
    }
    
    func priceChanger(_ price: String, index: IndexPath, qty: Int) {
        var json = productArray[index.row]
        json["qty"] = String(qty)
        json["price"] = price
        productArray[index.row] = json
    }
}

extension ViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewKey.cellIdentifier, for: indexPath) as? PhotoCell
        let json = productArray[indexPath.row]
        cell?.productImage.image = UIImage(named: json["image"] ?? "")
        cell?.productLbl.text = json["name"] ?? ""
        cell?.textQuenty.text = json["qty"] ?? ""
        cell?.plusLbl.tag = indexPath.row
        cell?.minusLbl.tag = indexPath.row
        cell?.priceLbl.text = json["price"] ?? ""
        return cell!
    }
}


















