//
//  DetailController.swift
//  AlbumApp
//
//  Created by Daljeet Singh on 25/08/19.
//  Copyright © 2019 Amish. All rights reserved.
//

import UIKit
import Foundation
class DetailController: UIViewController {
    
    var productDetail : Product? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func designView()
    {
        let biggerImage = UIImageView()
        biggerImage.contentMode = .scaleAspectFill
        biggerImage.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageUrlStr = productDetail?.productImageURL
        {
            biggerImage.loadImageUsingCache(withUrl: imageUrlStr)
        }
        else
        {
            biggerImage.image = UIImage(named: "PlaceHolder.png")
        }
        self.view.addSubview(biggerImage)
        
        let albumBtn = UIButton(type: .custom)
        albumBtn.setTitle("View Album", for: .normal)
        albumBtn.translatesAutoresizingMaskIntoConstraints = false
        albumBtn.backgroundColor = .black
        albumBtn.layer.cornerRadius = 5
        self.view.addSubview(albumBtn)
        
        let guide = view.safeAreaLayoutGuide
        
        biggerImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        biggerImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        biggerImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        biggerImage.heightAnchor.constraint(equalToConstant: self.view.bounds.size.width * 9/16).isActive = true

        albumBtn.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20).isActive = true
        albumBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        albumBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        albumBtn.heightAnchor.constraint(equalToConstant: 40)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        designView()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
