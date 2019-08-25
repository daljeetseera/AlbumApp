//
//  ViewController.swift
//  AlbumApp
//
//  Created by Amish on 25/08/19.
//  Copyright © 2019 Amish. All rights reserved.
//

import UIKit

class customCell : UITableViewCell
{
    var album : Album! {
        didSet {
            
            if let imageUrlStr = album.artworkUrl100
            {
                albumImage.loadImageUsingCache(withUrl: imageUrlStr)
            }
            else
            {
                albumImage.image = UIImage(named: "PlaceHolder.png")
            }
            albumNameLabel.text = album.name
            albumDescriptionLabel.text = album.artistName
        }
    }
    
    private let albumImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let albumNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let albumDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(albumImage)
        addSubview(albumNameLabel)
        addSubview(albumDescriptionLabel)
        
        albumImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        albumNameLabel.anchor(top: topAnchor, left: albumImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        albumDescriptionLabel.anchor(top: albumNameLabel.bottomAnchor, left: albumImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let albumListTable = UITableView()
    let cellID = "CustomCell"
    var albums = [Album]()
    
    override func viewDidLoad()
    {
        self.createTableView()
        fetchAlbums()
        self.navigationItem.title = "Albums"
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func fetchAlbums() {
        
        let loader = AppLoader(frame: self.view.bounds)
        self.view.addSubview(loader)
        loader.showLoaderWithMessage("Loading...")
        ApiManager().getAlbums()
            { (status, result, error) in
                if status {
                    AppLoader.hideLoaderIn(self.view)
                    print("final result \(status)")
                    if let albumList = result {
                        self.albums = albumList
                    }
                    DispatchQueue.main.async  {
                        self.albumListTable.reloadData()
                    }
                } else {
                    AppLoader.showErrorIn(view: self.view, withMessage: "Could not fetch details at the moment. Please try again later...")
                }
        }
    }
    
    func createTableView()
    {
        albumListTable.register(customCell.self, forCellReuseIdentifier: cellID)
        albumListTable.delegate = self
        albumListTable.dataSource = self
        albumListTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(albumListTable)
        
        albumListTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        albumListTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        albumListTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        albumListTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        albumListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath) as! customCell
        let currentLastItem = albums[indexPath.row]
        cell.album = currentLastItem
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailController()
        vc.albumDetail = albums[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
            
        
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
