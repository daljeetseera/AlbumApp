//
//  DetailController.swift
//  AlbumApp
//
//  Created by Amish on 25/08/19.
//  Copyright © 2019 Amish. All rights reserved.
//

import UIKit
import Foundation
class DetailController: UIViewController {
    
    var albumDetail : Album!
    let biggerImage = UIImageView()
    let albumBtn = UIButton(type: .custom)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func designView()
    {
        
        biggerImage.contentMode = .scaleAspectFill
        biggerImage.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageUrlStr = albumDetail.artworkUrl100
        {
            biggerImage.loadImageUsingCache(withUrl: imageUrlStr)
        }
        else
        {
            biggerImage.image = UIImage(named: "PlaceHolder.png")
        }
        self.view.addSubview(biggerImage)
        
        albumBtn.setTitle("View Album", for: .normal)
        albumBtn.translatesAutoresizingMaskIntoConstraints = false
        albumBtn.backgroundColor = .black
        albumBtn.layer.cornerRadius = 5
        albumBtn.addTarget(self, action: #selector(viewAlbumBtnClicked), for: .touchUpInside)
        self.view.addSubview(albumBtn)
        
        let guide = view.safeAreaLayoutGuide
        
        biggerImage.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20).isActive = true
        biggerImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        biggerImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        biggerImage.heightAnchor.constraint(equalToConstant: self.view.frame.size.height/2).isActive = true

        albumBtn.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20).isActive = true
        albumBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        albumBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        albumBtn.heightAnchor.constraint(equalToConstant: 40)
        
        
        
        self.perform(#selector(setScrollView), with: nil, afterDelay: 1)
        
        
        
        
    }
    
    @objc func setScrollView() {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: self.biggerImage.bottomAnchor, constant: 10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: albumBtn.topAnchor, constant: -10).isActive = true
        
        var bottomAnchor : NSLayoutYAxisAnchor!
        
        for i in 0...4
        {
            let detailsLbl = UILabel()
            detailsLbl.textAlignment = .center
            detailsLbl.sizeToFit()
            
            switch i {
            case 0:
                detailsLbl.text = "Album : \(albumDetail.name ?? "")"
            case 1:
                detailsLbl.text = "Artist : \(albumDetail.artistName ?? "")"
            case 2:
                detailsLbl.text = "Genre : \(albumDetail.genres?.getCommaSeparatedValues() ?? "")"
            case 3:
                detailsLbl.text = "Release Date : \(albumDetail.releaseDate ?? "")"
            case 4:
                detailsLbl.text = "Copyright : \(albumDetail.copyright ?? "")"
            default:
                print("do nothing")
            }
            
            detailsLbl.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(detailsLbl)
            
            
            if i == 0
            {
                NSLayoutConstraint.activate([
                    detailsLbl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
                    detailsLbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    detailsLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    detailsLbl.heightAnchor.constraint(equalToConstant: 25)
                    ])
            }
            else
            {
                NSLayoutConstraint.activate([
                    detailsLbl.topAnchor.constraint(equalTo: bottomAnchor, constant: 10),
                    detailsLbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    detailsLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    detailsLbl.heightAnchor.constraint(equalToConstant: 25)
                    ])
            }
            
            bottomAnchor = detailsLbl.bottomAnchor
            scrollView.contentSize = CGSize(width: scrollView.bounds.size.width, height: detailsLbl.frame.origin.y + detailsLbl.frame.size.height)
            
        }
    }
    
    @objc func viewAlbumBtnClicked() {
        if let url = URL(string: albumDetail.url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
