//
//  ApiModel.swift
//  AlbumApp
//
//  Created by Daljeet Singh on 25/08/19.
//  Copyright © 2019 Amish. All rights reserved.
//

import Foundation
import UIKit

class albumModel: NSObject, Codable
{
    var feed: resultFeeds?
}

class resultFeeds: NSObject, Codable
{
    var results: [resultDetails]?
}

class resultDetails: NSObject, Codable
{
    var artistName: String?
    var name: String?
    var artworkUrl100: String?
    
}
