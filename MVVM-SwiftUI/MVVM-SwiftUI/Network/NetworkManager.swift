//
//  NetworkManager.swift
//  MVVM-SwiftUI
//
//  Created by Jasminy Duarte on 18/06/24.
//

import UIKit

class NetworkManager: NSObject {
    static let shared           = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    
    static let baseURL          = "https://developer.marvel.com/"
    private let appetizerURL    = baseURL + "v1/public/characters?limit=3&apikey=63c18d6d436c0344e31a7538749ddc54"
    
    private override init() {}
    
    
    func getCharacters(completed: @escaping (Result<[Marvel], APIError>) -> Void) {
        guard let url = URL(string: appetizerURL) else {
            completed(.failure(.invalidURL))
            return
        }
               
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MarvelResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}


