//
//  FireBaseStorageManager.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/21.
//
import SwiftUI
import FirebaseStorage
import Firebase

class FirebaseStorageManager: ObservableObject {
    @Published var hotPlace: [HotPlace] = []

    
    @Published var cafes: [Cafe] = [] {
        didSet(newVal) {
     //       print("new value \(newVal)")
        }
    }
    
    @Published var cafeClassification: [String: [Cafe]] = [:] {
        didSet(newVal) {
          //  print("new value \(newVal)")
        }
    }
   
    init() {
        getHotPlace()
    }
    
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
    
    func getHotPlace(){
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
            self.hotPlace = documents.compactMap {
                doc -> HotPlace? in
                let data = try! JSONSerialization.data(withJSONObject: doc.data(), options: [])
                do {
                    let decoder = JSONDecoder()
                    let hotPlaces = try decoder.decode(HotPlace.self, from: data)
                    return hotPlaces
                    
                } catch let error {
                    print("decoding 실패 \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }
    func getCafes(spot: String){
        cafeClassification = [:]
        var ref : DatabaseReference!{
            Database.database().reference()
        }
        let firestoreDB = Firestore.firestore()
        
        
        firestoreDB.collection("Cafe").whereField("spot", isEqualTo: spot).addSnapshotListener
        {
            snapshot, error in
            guard let documents = snapshot?.documents else{
                print("error")
                return
            }
            self.cafes = documents.compactMap {
                doc
                in
                let data = try! JSONSerialization.data(withJSONObject: doc.data(), options: [])
                do {
                    let decoder = JSONDecoder()
                    let cafe = try decoder.decode(Cafe.self, from: data)
                    let tagedCafes = self.cafeClassification[cafe.tag]
                    
                    if let temp = tagedCafes{
                        var tempCafes = temp
                        tempCafes.append(cafe)
                        self.cafeClassification.updateValue(tempCafes, forKey: cafe.tag)
                    }
                    else{
                        self.cafeClassification[cafe.tag] = [cafe]
                    }
                    return cafe
                    
                }
                catch let error {
                    print("decoding 실패 \(error.localizedDescription)")
                    return nil
                }
            }
            print(self.cafeClassification)
        }
    }
    
    
}
