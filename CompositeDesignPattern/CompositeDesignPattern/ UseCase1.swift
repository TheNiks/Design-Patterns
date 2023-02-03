//
//  UseCase1.swift
//  CompositeDesignPattern
//
//  Created by Nikunj Modi on 30/01/23.
//

import Foundation

protocol StorageService {
    func upload()
}

class GoogleDriveStorage: StorageService {
    func upload() {
        // Here is need to implement business logic.
        print("GoogleDriveStorage")
    }
}

class DropBoxStorage: StorageService {
    func upload() {
        // Here is need to implement business logic.
        print("DropBoxStorage")
    }
}

class AmazonS3Storage: StorageService {
    func upload() {
        // Here is need to implement business logic.
        print("AmazonS3Storage")
    }
}

class StorageComposite: StorageService {
    let service: [StorageService]
    
    init(services: [StorageService]) {
        self.service = services
    }
    
    func upload() {
        print("StorageComposite")
        for service in service {
            service.upload()
        }
    }
}

class ExampleViewModel {
    let service: StorageService
    
    init(service: StorageService) {
        self.service = service
    }
    
    func finishedCreatingFile(file: File) {
        self.service.upload()
    }
}
