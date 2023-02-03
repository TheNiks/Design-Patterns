//
//  ViewController.swift
//  CompositeDesignPattern
//
//  Created by Nikunj Modi on 08/11/22.
//

import UIKit

struct File {
    var name: String
    var data: Data
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let vm = ExampleViewModel(service: StorageComposite(services: [
            GoogleDriveStorage(),
            AmazonS3Storage(),
            DropBoxStorage()
        ]))
        vm.finishedCreatingFile(file: File(name: "test", data: Data()))
        
        /// Use case 2 client
        let composite = CompositeFallbackLoader(remote: LoadRemoteData(), local: LoadLocalData())
        composite.load{ result in
             switch result{
             case let .success(data):
                 print("Fetch \(data)")
             case let .failure(error):
                 print(error)
             }
         }
    }
}
