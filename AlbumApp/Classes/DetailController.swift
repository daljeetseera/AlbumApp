//
//  DetailController.swift
//  AlbumApp
//
//  Created by Daljeet Singh on 25/08/19.
//  Copyright © 2019 Amish. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    let productDetail : Product? = nil
    override func viewDidLoad()
    {
        designView()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func designView()
    {
        let biggerImage = UIImageView()
        biggerImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        
        if let imageUrlStr = productDetail?.productImageURL
        {
            biggerImage.loadImageUsingCache(withUrl: imageUrlStr)
        }
        else
        {
            biggerImage.image = UIImage(named: "PlaceHolder.png")
        }
        self.view.addSubview(biggerImage)
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
