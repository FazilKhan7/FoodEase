//
//  NetworkRequest.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 04.07.2023.
//

import Foundation
import UIKit

final class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Failed to download image: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func requestData(urlString: String, comletion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    comletion(.failure(error))
                }
                
                if let data = data {
                    comletion(.success(data))
                }
            }
        }.resume()
    }
}
