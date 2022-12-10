import SwiftUI
import FirebaseStorage
import Firebase

class FirebaseStorageManager: ObservableObject {
    @Published var selectedCategory: String = "거대한 공간"
    @Published var cafeList: [String: [Cafe]] = [:]
    @Published var bookmarkedCafeList: [Cafe] = []
    @Published var cafeThumbnail: [String : UIImage] = [:]
    
    //Story
    @Published var post: [Post] = []
    //Comment
    @Published var comment: [Comment3] = []
    private var db = Firestore.firestore()
    
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
    
    // Firebase에 Story 저장
    func uploadStory(userName: String, content: String, image: String) {
        
        // firesore 문서의 아이디
        let storyId = UUID().uuidString
        
        // create story object
        let story = Post(userName: userName,visitCount: 1, content: content, image: image, likeCount: 0)
        
        // Storing to DB
        let _ = db.collection("Story").document(storyId).setData(story.dictionary)
        
    }
    
    func uploadCommnet(storyId: String, userName: String, content: String) {
       
        // firesore 문서의 아이디
        let commentId = UUID().uuidString
        
        // create Comment object
        let comment = Comment3(storyId: storyId, userName: userName, content: content)
        
        // Storing to DB
        let _ = db.collection("Comment").document(commentId).setData(comment.dictionary)
    }
    
    // post 불러오기
    func fetchPost() {
        
        db.collection("Story").addSnapshotListener { [self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
           
            self.post = documents.map({ (queryDocumentSnapshot) -> Post in
                let data = queryDocumentSnapshot.data()
        
                let storyId = data["storyId"] as? String ?? "blank id"
                let userName = data["userName"] as? String ?? "blank name"
                let visitCount = data["visitCount"] as? Int ?? 1
                let content = data["content"] as? String ?? "blank content"
                let image = data["image"] as? String ?? "blank image"
                let likeCount = data["likeCount"] as? Int ?? 0
                let creatAt = data["creatAt"] as? Date ?? Date()
                
                return Post(storyId: storyId, userName: userName, visitCount: visitCount, content: content, image: image, likeCount: likeCount, creatAt: creatAt)
            })
            
            print("Debug: \n",post)
        }
    }
    
    //comment 불러오기
    
    func fetchComment() {
        
        db.collection("Comment").addSnapshotListener { [self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            
            self.comment = documents.map({ (queryDocumentSnapshot) -> Comment3 in
                let data = queryDocumentSnapshot.data()
                
                let commentId = data["commentId"] as? String ?? "blank commentId"
                let storyId = data["storyId"] as? String ?? "blank storyId"
                let userName = data["userName"] as? String ?? "blank name"
                let content = data["content"] as? String ?? "blank content"
                let creatAt = data["creatAt"] as? Date ?? Date()
                
                return Comment3(commentId: commentId, storyId: storyId, userName: userName, content: content, creatAt: creatAt)
            })
            
            print("Debug: \n",self.comment)
            
        }
    }
    
    
    // Firebase에서 Story가져오기
//    func getStory() {
//        Firestore.firestore().collection("Story").getDocuments { [weak self] (querySnapshot, err) in
//            if let err = err {
//                print("[에러] \(err.localizedDescription)")
//            } else {
//                for document in querySnapshot!.documents {
//                    let jsonData = try! JSONSerialization.data(withJSONObject: document.data())
//                    do {
//                        let decoder = JSONDecoder()
//                        let story = try decoder.decode(Story2.self, from: jsonData)
//
//                        self?.story.append(story)
//
//                    }
//                    catch let err {
//                        print("[에러] \(err.localizedDescription)")
//                    }
//                }
//            }
//        }
//    }
    
    
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
