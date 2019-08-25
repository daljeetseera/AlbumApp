//
//  ViewController.swift
//  AlbumApp
//
//  Created by Daljeet Singh on 25/08/19.
//  Copyright © 2019 Amish. All rights reserved.
//

import UIKit

class customCell:UITableViewCell
{
    var product : Product? {
        didSet {
            productImage.image = product?.albumImage
            productNameLabel.text = product?.albumName
            productDescriptionLabel.text = product?.albumDesc
        }
    }
 
    private let productImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "img4.png"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
    
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        
        productImage.
        
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        
    }

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var mainViewFrame = CGRect()
    let albumListTable = UITableView()
    let cellID = "CustomCell"
    var products:[Product] = [Product]()
    
    override func viewDidLoad()
    {
        mainViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        createTableView()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createProductArray() {
        products.append(Product(albumName: "Glasses", albumImage: UIImage(named: "img4.png")  , albumDesc: "This is best Glasses I've ever seen"))
        products.append(Product(albumName: "Desert", albumImage: UIImage(named: "img4.png"), albumDesc: "This is so yummy"))
        products.append(Product(albumName: "Camera Lens", albumImage: UIImage(named: "img4.png"), albumDesc: "I wish I had this camera lens"))
    }
    
    func createTableView()
    {
        albumListTable.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        albumListTable.rowHeight = UITableView.automaticDimension
        albumListTable.estimatedRowHeight = 60
        albumListTable.delegate = self
        albumListTable.dataSource = self
        albumListTable.frame = mainViewFrame
        self.view.addSubview(albumListTable)
        albumListTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! customCell
        //   let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "CustomCell")
        
        cell.albumName?.frame = CGRect(x: 0, y: 0, width: 100, height: 25)
        cell.albumName?.text = "Album \(indexPath.row)"

       /*
        cell.textLabel?.text = "Album \(indexPath.row)"
        cell.detailTextLabel?.text = "Details \(indexPath.row)"
        
        // cell.imageView?.image = UIImage(named: "front.jpg")
        cell.imageView?.loadImageUsingCache(withUrl: "https://unsplash.com/photos/HUBofEFQ6CA/download?force=true")
        
       */
        
        //      if let url = URL(string: "https://unsplash.com/photos/HUBofEFQ6CA/download?force=true")
        //        {
        ////            DispatchQueue.global().async {
        //                if let data = try? Data(contentsOf: url)
        //                {
        //                    DispatchQueue.main.async {
        //                        cell.imageView?.image = UIImage(data: data)
        //                        print("image \(data.count)")
        //                    }
        //                }
        //            }
        ////        }
        
        return cell
    }
    
}

