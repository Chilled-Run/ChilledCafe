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
    @Published var selectedPost: Post = Post()
    @Published var storyId: String = ""
    
    //Comment
    @Published var comment: [Comment3] = []
    @Published var relatedComments: [Comment3] = []
    private var db = Firestore.firestore()
    
    //Color
    @Published var pawForegroundColor: Color = Color.white
    @Published var pawBackgroundColor: Color = Color.white
    
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
    
    func getColor() {
        self.pawForegroundColor = getForegroundColor(foot: selectedPost.image)
        self.pawBackgroundColor = getBackgroundColor(foot: selectedPost.image)
    }
    
    // 관련 댓글 수
    func getCommentNumber(storyId: String) -> Int {
        var relatedComment = self.comment.filter {
            $0.storyId == storyId
        }
        return relatedComment.count
    }
    
    // 최근순으로 post 정렬
    func getFirstStroy() {
        self.post.sort {
            $0.createAt > $1.createAt
        }
        self.selectedPost = self.post[0]
        self.storyId = selectedPost.storyId
        getColor()
    }
    
    // index의 post를 선택하고 storyId 값을 리턴
    func getStoryId(index: Int) -> String {
        self.selectedPost = self.post[index]
        self.storyId = self.post[index].storyId
        getColor()
        return self.post[index].storyId
    }
    
    //스토리아이디로 스토리 찾기
    func getStory(storyId: String) {
        for story in self.post {
            if story.storyId == storyId {
                self.selectedPost = story
                break
            }
        }
    }
    
    //스토리와 관련된 댓글 가져오기
    func fetchRelatedComment(storyId: String) {
        var relatedComment = self.comment.filter {
            $0.storyId == storyId
        }
        self.relatedComments = relatedComment.sorted {
            $0.createAt > $1.createAt
        }
    }
    
    
    // Firebase에 Story 저장
    func uploadStory(userName: String, content: String, image: String) {
        
        // firesore 문서의 아이디
        let storyId = UUID().uuidString
        
        // create story object
        let story = Post(userName: userName,visitCount: 1, content: content, image: image, likeCount: 0, createAt: "\(Date())")
        
        // Storing to DB
        let _ = db.collection("Story").document(storyId).setData(story.dictionary)
        
    }
    
    func uploadCommnet(storyId: String, userName: String, content: String) {
        
        let document = db.collection("Comment")
            .document("1")
            .collection("content")
            .document()
        
        // firesore 문서의 아이디
        let commentId = storyId
        
        // create Comment object
        let comment = Comment3(storyId: storyId, userName: userName, content: content, createAt: "\(Date())")
        
        // Storing to DB
        document.setData(comment.dictionary) { error in
            if let error = error {
                print(error)
                return
            }
            print("Success save")
        }
    }
    
    // post 불러오기
    func fetchPost() {
        
        db.collection("Story").addSnapshotListener { [self] (querySnapshot, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                
                if change.type == . added {
                    let data = change.document.data()
                    
                    let storyId = data["storyId"] as? String ?? "blank id"
                    let userName = data["userName"] as? String ?? "blank name"
                    let visitCount = data["visitCount"] as? Int ?? 1
                    let content = data["content"] as? String ?? "blank content"
                    let image = data["image"] as? String ?? "blank image"
                    let likeCount = data["likeCount"] as? Int ?? 0
                    let createAt = data["createAt"] as? String ?? "\(Date())"
                    
                    print("Debug: time check \n", createAt)
                    self.post.append(.init(storyId: storyId, userName: userName, visitCount: visitCount, content: content, image: image, likeCount: likeCount, createAt: createAt))
                    //최근 작성순으로 sort
                    getFirstStroy()
                    //첫 번째 post에 관련된 댓글 모음
                    fetchRelatedComment(storyId: self.storyId)
                }
            })
            print("Debug: \n",post)
        }
    }
    
    //comment 불러오기
    
    func fetchComment() {
        
        db.collection("Comment")
            .document("1")
            .collection("content")
            .addSnapshotListener { [self] (querySnapshot, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    
                    if change.type == . added {
                        let data = change.document.data()
                        let commentId = data["commentId"] as? String ?? "blank commentId"
                        let storyId = data["storyId"] as? String ?? "blank storyId"
                        let userName = data["userName"] as? String ?? "blank name"
                        let content = data["content"] as? String ?? "blank content"
                        let createAt = data["createAt"] as? String ?? "\(Date())"
                        
                        self.comment.append(.init(commentId: commentId, storyId: storyId, userName: userName, content: content, createAt: createAt))
                        if storyId == self.storyId {
                            fetchRelatedComment(storyId: self.storyId)
                        }
                    }
                })
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
    
    // TODO: 추후 리팩필요
    //발자국 종류에 따른 색 변경
    func getForegroundColor(foot: String) -> Color {
        switch foot {
            //return mainColor
        case "leftFoot":
            return Color("MainColor")
        case "bearPaw":
            return Color("MainColor")
        case "birdFoot":
            return Color("MainColor")
        case "rightFoot":
            return Color("MainColor")
            
            //return CustomGreen
        case "catPaw":
            return Color("customGreen")
        case "dogFoot":
            return Color("customGreen")
        case "duckFoot":
            return Color("customGreen")
            //horsePaw
        default:
            return Color("customGreen")
        }
    }
    
    func getBackgroundColor(foot: String) -> Color {
        switch foot {
            //return pastelBlue
        case "leftFoot":
            return Color("pastelBlue")
        case "bearPaw":
            return Color("pastelBlue")
        case "birdFoot":
            return Color("pastelBlue")
        case "rightFoot":
            return Color("pastelBlue")
            
            //return pastelGreen
        case "catPaw":
            return Color("pastelGreen")
        case "dogFoot":
            return Color("pastelGreen")
        case "duckFoot":
            return Color("pastelGreen")
            //horsePaw
        default:
            return Color("pastelGreen")
        }
    }
    
    
}
