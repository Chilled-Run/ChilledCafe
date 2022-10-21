//
//  FireBaseStorageManager.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/21.
//
import SwiftUI
import FirebaseStorage
import Firebase

class FirebaseStorageManager {
   
    
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
    
    static func getHotPlace() -> [HotPlace]?{
        var ref : DatabaseReference!{
            Database.database().reference()
        }
        let firestoreDB = Firestore.firestore()
        
        
        firestoreDB.collection("HotPlace").addSnapshotListener
        {
            snapshot, error in
            guard let documents = snapshot?.documents else{
                print("error")
                return
            }
            let temp = documents.compactMap {
                doc -> HotPlace? in
                let data = try! JSONSerialization.data(withJSONObject: doc.data(), options: [])
                print("debuging",data)
                do{
                    let decoder = JSONDecoder()
                    let hotPlaces = try decoder.decode(HotPlace.self, from: data)
                    print("debuging",hotPlaces)
                    return hotPlaces
                   
                }catch let error {
                    print("decoding 실패 \(error.localizedDescription)")
                    return nil
                }
            }
        }
    
        return nil

    }
}
