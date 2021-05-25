//
//  Database.swift
//  SpreadSheet
//
//  Created by Lucas Marques Bigh (P) on 03/05/21.
//

import Firebase
import FirebaseFirestoreSwift

class Database {

    private let db: Firestore

    private init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }

    static let `default` = Database()

    func get<T: Storable>(_ objectType: T.Type, completion: @escaping(Result<[T], Error>) -> Void) {
        let object = objectType.init()
        db.collection(object.collectionPath).getDocuments { snapshot, error in
            if let snapshot = snapshot {
                var resultObjects = [T]()

                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: T.self)
                    }
                    switch result {
                    case .success(let resultObject):
                        if let resultObject = resultObject {
                            resultObjects.append(resultObject)
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                completion(.success(resultObjects))
            }
        }
    }
    
    func get<T: Storable>(collectionPath: String, as: T.Type, completion: @escaping(Result<[T], Error>) -> Void) {
        db.collection(collectionPath).getDocuments { snapshot, error in
            if let snapshot = snapshot {
                var resultObjects = [T]()

                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: T.self)
                    }
                    switch result {
                    case .success(let resultObject):
                        if let resultObject = resultObject {
                            resultObjects.append(resultObject)
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                completion(.success(resultObjects))
            }
        }
    }

    func save<T: Storable>(_ object: T) {
        let documentReference = db.collection(object.collectionPath).document()
        var newObject = object
        newObject.id = documentReference.documentID
        do {
            try documentReference.setData(from: newObject)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func save<T: Storable>(_ object: T, atPath path: String) {
        let documentReference = db.collection(path).document()
        var newObject = object
        newObject.id = documentReference.documentID
        do {
            try documentReference.setData(from: newObject)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func updateObject<T: Storable>(_ object: T, _ handler: (T) -> Void) {
        
    }

    func delete() {

    }
}
