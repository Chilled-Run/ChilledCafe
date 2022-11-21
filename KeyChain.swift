//
//  KeyChain.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/18.
//

import Foundation
import Security
import SwiftUI

class S_Keychain {
    
    
    // MARK: [키 체인 클래스 사용 방법]
    /*
    1. 디바이스 정보 저장 : S_Keychain().createDeviceID() => 리턴 값 true / false
    2. 디바이스 정보 조회 : S_Keychain().getDeviceID() => 저장된 디바이스 고유값 문자열
    3. 디바이스 정보 삭제 : S_Keychain().deleteDeviceID() => 리턴 값 true / false
    */
    
    
    
    // MARK: [키 체인 설명]
    /*
    1. Keychain 은 디바이스 안에 암호화된 데이터 저장 공간입니다
    2. Keychain 은 보안 기능이 뛰어나 사용자 정보 및 결제 정보 등 민감한 정보를 저장할 수 있습니다
    3. Keychain 은 앱 종료 및 앱 삭제 후 재설치를 진행해도 동일하게 저장된 값을 사용할 수 있습니다
       - 영구적인 데이터
       - 사용자가 삭제하지 않는 이상 유지
       - Keychain 은 사용자가 데이터를 삭제하거나, 휴대폰 공장 초기화를 진행 시 삭제됩니다
    4. 설정 패키지 : import Security
    */
    
    
    
    // MARK: [UUID 설명]
    /*
    1. uuis 는 32개의 문자+숫자로 이루어집니다
    2. iOS4까지는 iOS기기의 고유 넘버로 udid를 사용했지만, 보안 문제로 iOS5부터는 uudi(임의로 생성한 고유값)를 사용합니다
    3. uuid는 앱을 삭제하면 새롭게 생성됩니다
    4. uuid는 Vender 에 따라서 값이 달라집니다 (공급업체(벤더)가 같은 앱들은 모두 같은 고유 ID를 가집니다)
    5. uuid 외에도 ADID (IDFA) 라는 것이 있는데 이는 광고 식별자이고 기기마다 고유한 값을 가집니다
       - 앱 스토어 등록 심사 시 필수 광고 식별자 사용을 체크하고 사유를 적어야합니다 (아니면, 앱 스토어 등록 거부될 수 있습니다)
    6. 설정 패키지 : import UIKit
    */
    
    
    
    // MARK: [Keychain 생성 정보 정의]
    private let account = "ServiceSaveKey"
    private let service = Bundle.main.bundleIdentifier
    
    
    
    // MARK: [Keychain 사용해 디바이스 고유값 저장 실시]
    func createDeviceID() -> Bool {
        guard let service = self.service
        else {
            print("")
            print("[S_Keychain >> createDeviceID() : Service Check : false]")
            print("")
            return false
        }
        
        // 디바이스 고유값 생성 실시
        let deviceID = self.getDeviceID()
        print("")
        print("[S_Keychain >> createDeviceID() : account : \(account)]")
        print("[S_Keychain >> createDeviceID() : service : \(service)]")
        print("[S_Keychain >> createDeviceID() : deviceID : \(deviceID)]")
        print("")
        
        // 키 체인 쿼리 생성
        let query:[CFString: Any]=[kSecClass: kSecClassGenericPassword, // 보안 데이터 저장
                                   kSecAttrService: service, // 키 체인에서 해당 앱을 식별하는 값 (앱만의 고유한 값)
                                   kSecAttrAccount: account, // 앱 내에서 데이터를 식별하기 위한 키에 해당하는 값 (사용자 계정)
                                   kSecValueData: deviceID.data(using: .utf8, allowLossyConversion: false)!] // 키값에 디바이스 고유값 저장
        
        // keychain 에 저장을 수행한 결과 값 반환 (true / false)
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("")
            print("[S_Keychain >> createDeviceID() : Success Status : \(status)]")
            print("")
            return true
        }
        else {
            print("")
            print("[S_Keychain >> createDeviceID() : Fail Status : \(status)]")
            print("")
            return false
        }
    }
    
    
    
    // MARK: [Keychain 사용해 디바이스 고유값 호출 실시]
    func getDeviceID() -> String {
        guard let service = self.service
        else {
            print("")
            print("[S_Keychain >> getDeviceID() : Service Check : false]")
            print("")
            return ""
        }
        
        print("")
        print("[S_Keychain >> getDeviceID() : account : \(account)]")
        print("[S_Keychain >> getDeviceID() : service : \(service)]")
        print("")
        
        // 키 체인 쿼리 정의
        let query:[CFString: Any]=[kSecClass: kSecClassGenericPassword, // 보안 데이터 저장
                                   kSecAttrService: service, // 키 체인에서 해당 앱을 식별하는 값 (앱만의 고유한 값)
                                   kSecAttrAccount : account, // 앱 내에서 데이터를 식별하기 위한 키에 해당하는 값 (사용자 계정)
                                   kSecReturnData : true, // kSecReturnData에 true를 리턴시켜 값을 불러옵니다
                                   kSecReturnAttributes: true, // kSecReturnAttributes에 true를 리턴시켜 값을 불러옵니다
                                   kSecMatchLimit : kSecMatchLimitOne] // 값이 일치하는 것을 찾습니다
        
        // 키 체인에 저장된 값을 읽어옵니다
        var dataTypeRef : CFTypeRef?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        // 처리 결과가 성공인 경우 >> 키 체인에서 읽어온 값을 Data 타입으로 변환 >> 다시 String 타입으로 변환
        if status == errSecSuccess {
            guard let existingItem = dataTypeRef as? [String: Any]
            else {
                print("")
                print("[S_Keychain >> getDeviceID() : Type Check : false]")
                print("")
                return ""
            }
            let deviceData = existingItem[kSecValueData as String] as? Data
            let uuidData = String(data: deviceData!, encoding: .utf8)!
            
            print("")
            print("[S_Keychain >> getDeviceID() : Success Status : \(status)]")
            print("")
            return uuidData
        }
        else if status == errSecItemNotFound || status == -25300 {
            print("")
            print("[S_Keychain >> getDeviceID() : Fail Status : 저장된 데이터가 없습니다]")
            print("")
            return ""
        }
        else {
            // 처리결과가 실패라면 nil을 반환
            print("")
            print("[S_Keychain >> getDeviceID() : Fail Status : \(status)]")
            print("")
            return ""
        }
    }
    
    
    
    // MARK: [Keychain 에 저장된 값 삭제 수행]
    func deleteDeviceID() -> Bool {
        guard let service = self.service
        else {
            print("")
            print("[S_Keychain >> deleteDeviceID() : Service Check : false]")
            print("")
            return false
        }
        
        print("")
        print("[S_Keychain >> deleteDeviceID() : account : \(account)]")
        print("[S_Keychain >> deleteDeviceID() : service : \(service)]")
        print("")
        
        // 키 체인 쿼리 정의
        let query:[CFString: Any]=[kSecClass: kSecClassGenericPassword, // 보안 데이터 저장
                                   kSecAttrService: service, // 키 체인에서 해당 앱을 식별하는 값 (앱만의 고유한 값)
                                   kSecAttrAccount : account] // 앱 내에서 데이터를 식별하기 위한 키에 해당하는 값 (사용자 계정)
        
        // 현재 저장되어 있는 값 삭제
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("")
            print("[S_Keychain >> deleteDeviceID() : Success Status : \(status)]")
            print("")
            return true
        }
        else {
            print("")
            print("[S_Keychain >> deleteDeviceID() : Fail Status : \(status)]")
            print("")
            return false
        }
    }

    
    
    // MARK: [디바이스 고유 값 추출 메소드]
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
