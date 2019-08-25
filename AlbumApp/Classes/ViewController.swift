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
            
            if let imageUrlStr = product?.productImageURL
            {
                productImage.loadImageUsingCache(withUrl: imageUrlStr)
            }
            else
            {
                productImage.image = UIImage(named: "PlaceHolder.png")
            }
            productNameLabel.text = product?.productName
            productDescriptionLabel.text = product?.productDesc
        }
    }
    
    private let productImage : UIImageView = {
        let imgView = UIImageView()
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
        
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        self.createTableView()
        createProductArray()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createProductArray() {
        
        
        /*  let img:UIImage = UIImage(named: "PlaceHolder")!
         
         products.append(Product(productName: "Glasses", productImage: img , productDesc: "This is best Glasses I've ever seen"))
         products.append(Product(productName: "Desert", productImage: img, productDesc: "This is so yummy"))
         products.append(Product(productName: "Camera Lens", productImage: img, productDesc: "I wish I had this camera lens"))
         */
        
        ApiManager().postApi()
            { (status, result, error) in
                
                print("final result \(status)")
                
                if status
                {
                    if let productArray = result?.results
                    {
                        for item in productArray
                        {
                            self.products.append(Product(productName: item.artistName ?? "", productImageURL: item.artworkUrl100 ?? "" , productDesc: item.name ?? ""))
                        }
                    }
                    DispatchQueue.main.async  {
                             self.albumListTable.reloadData()
                    }
           
                }
            }
        
    }
    
    func createTableView()
    {
        albumListTable.register(customCell.self, forCellReuseIdentifier: cellID)
        albumListTable.delegate = self
        albumListTable.dataSource = self
        albumListTable.frame = mainViewFrame
        self.view.addSubview(albumListTable)
        albumListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //  let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! customCell
        //   let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "CustomCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath) as! customCell
        let currentLastItem = products[indexPath.row]
        cell.product = currentLastItem
        //  cell.detailTextLabel?.text = currentLastItem.albumDesc
        //   cell.imageView?.image = currentLastItem.albumImage
        
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

extension UIView {
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            //   print("Top: \(topInset)”)
            //     print("bottom: \(bottomInset)”)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}
