//
//  RestApiManager.swift
//  AlbumApp
//
//  Created by Daljeet Singh on 25/08/19.
//  Copyright © 2019 Amish. All rights reserved.
//

import Foundation
public typealias completionHandler = (_ success : Bool, _ response : Array<Any>?, _ error : Error?) -> ()

func postApi()//(completion : @escaping completionHandler)
{
    guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json") else {return}
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
            error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
        do{
            
            if let httpResponse = response as? HTTPURLResponse
            {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200
                {
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        dataResponse, options: []) as! NSDictionary
                    print(jsonResponse) //Response result
                    
                    let dataNew:Data = try NSKeyedArchiver.archivedData(withRootObject: jsonResponse, requiringSecureCoding: true)
                    let user = try JSONDecoder().decode(albumModel.self, from: data!)
                    print("user \(user)")
                    completion(true, response.result)
                }
                else
                {
                    completion(false, httpRes)
                }
            }
            //here dataResponse received from a network request
        
            
       
          
        } catch let parsingError
        {
            print("Error", parsingError)
        }
    }
    task.resume()
}
