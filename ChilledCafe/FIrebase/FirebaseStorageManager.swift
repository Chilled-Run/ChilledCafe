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
    @Published var cafes: [Cafe] = []
    @Published var cafeClassification: [String: [Cafe]] = [:]
    
    @Published var cafeList: [Cafes] = []
    @Published var cafeListClassification: [String: [Cafes]] = [:]
    @Published var selectedCategory: String = "AR 경험"
    @Published var bookmarkedCafeList: [Cafes] = []
    @Published var user: User = User(uuid: "", cafe: [])
    
    init() {
        getCafeList()
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
        var ref : DatabaseReference! {
            Database.database().reference()
        }
        let firestoreDB = Firestore.firestore()
        
        
        firestoreDB.collection("HotPlace").addSnapshotListener {
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
        
        
        firestoreDB.collection("Cafe").whereField("spot", isEqualTo: spot).addSnapshotListener {
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
                    
                    if let temp = tagedCafes {
                        var tempCafes = temp
                        tempCafes.append(cafe)
                        self.cafeClassification.updateValue(tempCafes, forKey: cafe.tag)
                    }
                    else {
                        self.cafeClassification[cafe.tag] = [cafe]
                    }
                    return cafe
                    
                }
                catch let error {
                    print("decoding 실패")
                    return nil
                }
            }
        }
    }
    //-----------------------------------------------------
    // 북마크 눌렸는지 확인
    // cafe id로 바꿔야함
    func checkBookmark(cafeName: String) -> Bool {
        for bookmarkedCafe in self.user.cafe {
            if bookmarkedCafe == cafeName {
                return true
            }
        }
        return false
    }
    
    
    // 북마크된 카페 리스트 받기
    func getBookmarkedCafes() {
        self.bookmarkedCafeList = []

        // 구조 바꿔야함
        for bookmarkedCafe in self.user.cafe {
            for cafe in self.cafeList {
                if cafe.name == bookmarkedCafe {
                    self.bookmarkedCafeList.append(cafe)
                }
            }
        }
    }
    
    
    //bookmark 클릭 후 유저struct에 카페 리스트 추가, 서버에 올리기
    func updateUser(userUUID: String , cafeID: String) {
        // bookmark 삭제도 구현 해야함
        
        //토글한 cafe의 bookmark 여부를 확인
        let checkBookmark = self.checkBookmark(cafeName: cafeID)
        
        if checkBookmark {
            // 북마크 삭제
            // 업데이트 속도가 느리면 오류 생김?
            if let index = self.user.cafe.firstIndex(of: cafeID) {
                self.user.cafe.remove(at: index)
            }
        }
        else {
            // 북마크 생성
            // 중복 체크 ????
            self.user.cafe.append(cafeID)
        }
        // 북마크 리스트 갱신
        self.getBookmarkedCafes()
        
        let userRef =  Firestore.firestore().collection("User").document(userUUID)
        userRef.updateData([
            "cafe": self.user.cafe
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    // 서버에 user 데이터 올리기
    func addUser(userUUID: String) {
        
        print("Debuging addUser", userUUID)
        //user에 현재 기기 uuid와 북마크된 카페 등록
        self.user = User(uuid: userUUID, cafe: [])
        let docData: [String: Any] = [
            "uuid": userUUID,
            "cafe": []
        ]
        
        let firestoreDB = Firestore.firestore()
        //firebase 서버에 새로운 user 데이터 등록
        firestoreDB.collection("User").document(userUUID).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document User successfully written!")
            }
        }
    }
    
    
    
    // 유저가 있으면 받아오고 아니면 유저데이터 올리기
    func getUser() {
        var ref : DatabaseReference!{
            Database.database().reference()
        }
        let firestoreDB = Firestore.firestore()
        let userUUID = S_Keychain.getDeviceUUID()
        print("Debuging getUser", userUUID)
        
        //파이어베이스 디비에서 User 컬렉션에서 uuid 항목에 일치하는 값을 가져온다
        firestoreDB.collection("User").whereField("uuid", isEqualTo: userUUID).getDocuments() {
            (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else {
                print("error")
                return
            }
            if documents == [] {
                // 서버에 현재 기기의 데이터가 없으면 User 데이터 전송
                self.addUser(userUUID: userUUID)
            }
            else {
                // 서버에 현재 기기의 데이터가 있으면 documents에서 user struct로 변환
                documents.compactMap { doc in
                    let data = try! JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    do {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: data)
                        self.user = user
                        print("Debuging ~~",user)
                        return user
                    }
                    catch let error {
                        print("decoding 실패")
                        return nil
                    }
                }
            }
        }
        
    }
    
   
    
    func getCafeList() {
        self.cafeListClassification = [:]
      
        var ref : DatabaseReference!{
            Database.database().reference()
        }
        let firestoreDB = Firestore.firestore()
        
        
        firestoreDB.collection("Cafes").addSnapshotListener {
            snapshot, error in
            guard let documents = snapshot?.documents else {
                print("error")
                return
            }
            self.cafeList = documents.compactMap {
                doc
                in
                let data = try! JSONSerialization.data(withJSONObject: doc.data(), options: [])
                do {
                    let decoder = JSONDecoder()
                    let cafe = try decoder.decode(Cafes.self, from: data)
                    
                    for tag in cafe.tag {
                        let tagedCafes = self.cafeListClassification[tag]
                        
                        if let temp = tagedCafes {
                            var tempCafes = temp
                            tempCafes.append(cafe)
                            self.cafeListClassification.updateValue(tempCafes, forKey: tag)
                        }
                        else {
                            self.cafeListClassification[tag] = [cafe]
                        }
                    }
                    return cafe
                }
                catch let error {
                    print("decoding 실패")
                    return nil
                }
            }
        }
        
    }
    
}
