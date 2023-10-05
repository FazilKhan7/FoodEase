//
//  NetworkManager.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 04.07.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    private func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                let parsedData = self.parseData(data: data, type: T.self)
                completion(parsedData, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }

    func fetchAlbum(urlString: String, completion: @escaping (Categories?, Error?) -> Void) {
        fetchData(urlString: urlString, completion: completion)
    }

    func fetchDishes(urlString: String, completion: @escaping (Dishes?, Error?) -> Void) {
        fetchData(urlString: urlString, completion: completion)
    }

    private func parseData<T: Decodable>(data: Data, type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedData = try jsonDecoder.decode(type, from: data)
            return decodedData
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        return nil
    }
}
