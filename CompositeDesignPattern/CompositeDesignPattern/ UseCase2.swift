//
//  UseCase2.swift
//  CompositeDesignPattern
//
//  Created by Nikunj Modi on 30/01/23.
//

import Foundation

protocol LoadData {
    func load(completion: @escaping (Result<Data, Error>)-> Void)
}

class LoadRemoteData: LoadData {
    func load(completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.failure(NSError(domain: "Any Error", code: 0)))
    }
}

class LoadLocalData: LoadData {
    func load(completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success("Local Data Load successfully".data(using: .utf8)!))
    }
}

class CompositeFallbackLoader: LoadData {
    let local: LoadData
    let remote: LoadData
    
    init(remote: LoadData, local: LoadData) {
        self.local = local
        self.remote = remote
    }
    
    func load(completion: @escaping (Result<Data, Error>) -> Void) {
        remote.load { [weak self] result in
            switch result {
            case .success:
                print("Fetch \(result) remotely successfully")
            case .failure:
                self?.retrieveLocalData()
            }
        }
    }
    
    private func retrieveLocalData() {
        local.load { localResult in
            switch localResult {
            case let .success(data):
                let myData = String(data: data, encoding: .utf8)!
                print("Fetch \(myData)")
            case let .failure(error):
                print(error)
            }
        }
    }
}
