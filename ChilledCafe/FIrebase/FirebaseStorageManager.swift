import SwiftUI
import FirebaseStorage
import Firebase

class FirebaseStorageManager: ObservableObject {
    @Published var selectedCategory: String = "AR 경험"
    @Published var cafeList: [String: [Cafe]] = [:]
    @Published var bookmarkedCafeList: [Cafe] = []
    @Published var cafeThumbnail: [String : UIImage] = [:]
    
    // MARK: - Storage에서 이미지 가져오기
    func downloadImage(dispatchGroup: DispatchGroup, urlString: String, completion: @escaping (UIImage?) -> Void) {
            let storageReference = Storage.storage().reference(forURL: urlString)
            let megaByte = Int64(1 * 1024 * 1024)
            
            storageReference.getData(maxSize: megaByte) { data, error in
                if let error = error {
                    print("[사진 다운 에러] \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                guard let imageData = data else {
                    completion(nil)
                    return
                }
                completion(UIImage(data: imageData))
            }
        }
    
    // MARK: - Firestore에서 카페 데이터 가져오기
    func getCafes(dispatchGroup: DispatchGroup) {
        Firestore.firestore().collection("Cafes").getDocuments { [weak self] (querySnapshot, err) in
            if let err = err {
                print("[에러] \(err.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    let jsonData = try! JSONSerialization.data(withJSONObject: document.data())
                    do {
                        let decoder = JSONDecoder()
                        let cafe = try decoder.decode(Cafe.self, from: jsonData)
                        
                        // MARK: - Thumbnail loading
                        dispatchGroup.enter()
                        DispatchQueue.global().async {
                            self?.downloadImage(dispatchGroup: dispatchGroup, urlString: cafe.thumbnail) { uiImage in
                                self?.cafeThumbnail[cafe.name] = uiImage
                                dispatchGroup.leave()
                            }
                        }
                        
                        // MARK: - Bookmark
                        if cafe.bookmark {
                            self?.bookmarkedCafeList.append(cafe)
                        }
                        
                        // MARK: - CafeList
                        for tag in cafe.tag {
                            if let tagedCafes = self?.cafeList[tag] {
                                var tagedCafes = tagedCafes
                                tagedCafes.append(cafe)
                                self?.cafeList.updateValue(tagedCafes, forKey: tag)
                            }
                            else {
                                self?.cafeList[tag] = [cafe]
                            }
                        }
                    }
                    catch let err {
                        print("[에러] \(err.localizedDescription)")
                    }
                }
                dispatchGroup.leave()
            }
        }
    }
}
