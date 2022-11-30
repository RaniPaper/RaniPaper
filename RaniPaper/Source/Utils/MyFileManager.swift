//
//  MyFileManager.swift
//  RaniPaper
//
//  Created by YoungK on 2022/11/30.
//

import Foundation

final class MyFileManager {
    static let shared = MyFileManager()
    var fileManager: FileManager
    var documentPath: URL
    var directoryPath: URL
    
    private init() {
        print("✅ MyFileManger init")
        
        // 파일 매니저 인스턴스 생성
        self.fileManager = FileManager.default
        
        // 사용자의 문서 경로
        self.documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // 폴더 경로 지정
        // Documents/Memo
        self.directoryPath = documentPath.appendingPathComponent("Memo")
        
        // 폴더 생성
        do {
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    /// CREATE : 파일을 생성(저장) 합니다.
    /// - Parameter fileName: Documents/RaniPaper/. 에 저장 될 파일명 (확장자 지정 필요)
    /// - Parameter data: 저장할 String
    /// - Returns: Void
    func create(on fileName: String, _ data: String) -> Result<Void, CreateError> {
        if fileName.isEmpty { return .failure(.invalidName) }
        guard let data = data.data(using: .utf8) else { // String to Data
            return .failure(.unknown)
        }
        
        // 파일 경로
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // 파일 생성하기
        do {
            // 보조파일에 쓰기후 파일교체, 덮어쓰기 방지 옵션
            try data.write(to: filePath, options: .withoutOverwriting)
            print("파일을 CREATE 합니다. 파일명:", fileName)
            return .success(())
        } catch {
            return .failure(.unknown)
        }
        
    }
    
    /// READ : 파일을 읽어옵니다.
    /// - Parameter fileName: Documents/RaniPaper/. 에 저장 된 파일명 (확장자 지정 필요)
    /// - Returns: .success 시 string
    func read(fileName: String) -> Result<String, ReadError> {
        if fileName.isEmpty { return .failure(.invalidName) }
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // 불러와서 읽기
        do {
            // path를 불러와서 Data타입으로 초기화
            let dataFromPath: Data = try Data(contentsOf: filePath)
            // Data to String
            guard let text: String = String(data: dataFromPath, encoding: .utf8) else {
                return .failure(.unknown)
            }
            print("파일을 READ 합니다. 내용:", text)
            return .success(text)
        } catch {
            return .failure(.unknown)
        }
    }
    
    /// UPDATE : 파일을 수정 합니다.
    /// - Parameter fileName: Documents/RaniPaper/. 에 저장 될 파일명 (확장자 지정 필요)
    /// - Parameter data: 저장할 String
    /// - Returns: Void
    func update(on fileName: String, _ data: String) -> Result<Void, UpdateError> {
        if fileName.isEmpty { return .failure(.invalidName)}
        guard let data = data.data(using: .utf8) else { // String to Data
            return .failure(.unknown)
        }
        
        // 파일 경로
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // 파일 생성하기
        do {
            // 보조파일에 쓰기후 파일교체
            try data.write(to: filePath, options: .atomic)
            print("파일을 UPDATE 합니다. 파일명:", fileName)
            return .success(())
        } catch {
            return .failure(.unknown)
        }
        
    }
    
    /// DELETE : 파일을 삭제합니다.
    /// - Parameter fileName: Documents/RaniPaper/. 에 삭제 할 파일명 (확장자 지정 필요)
    /// - Returns: Void
    func delete(fileName: String) -> Result<Void, DeleteError> {
        if fileName.isEmpty { return .failure(.invalidName) }
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // 파일을 삭제한다.
        do {
            try fileManager.removeItem(at: filePath)
            print("파일을 DELETE 합니다. 파일명:", fileName)
            return .success(())
        } catch {
            return .failure(.unknown)
        }
    }
    
}

extension MyFileManager {
    enum CreateError: Error {
        case invalidName // 잘못된 이름
        case alreadyExist // 이미 존재하는 파일
        case storageIsFull // 저장공간이 부족
        case unknown
        
        public var errorDescription: String {
            switch self {
            case .invalidName:
                return NSLocalizedString("🔥 invalidName exception", comment: "파일명이 잘못됨")
            case .alreadyExist:
                return NSLocalizedString("🔥 alreadyExist exception", comment: "이미 존재하는 파일")
            case .storageIsFull:
                return NSLocalizedString("🔥 storageIsFull exception", comment: "저장공간이 부족")
            case .unknown:
                return NSLocalizedString("🔥 unknown exception", comment: "unknown")
            }
        }
    }
    
    enum ReadError: Error {
        case invalidName // 잘못된 이름
        case unknown
        
        public var errorDescription: String {
            switch self {
            case .invalidName:
                return NSLocalizedString("🔥 invalidName exception", comment: "파일명이 잘못됨")
            case .unknown:
                return NSLocalizedString("🔥 unknown exception", comment: "unknown")
            }
        }
    }
    
    enum UpdateError: Error {
        case invalidName // 잘못된 이름
        case storageIsFull // 저장공간이 부족
        case unknown
        
        public var errorDescription: String {
            switch self {
            case .invalidName:
                return NSLocalizedString("🔥 invalidName exception", comment: "파일명이 잘못됨")
            case .storageIsFull:
                return NSLocalizedString("🔥 storageIsFull exception", comment: "storageIsFull")
            case .unknown:
                return NSLocalizedString("🔥 unknown exception", comment: "unknown")
            }
        }
    }
    
    enum DeleteError: Error {
        case invalidName // 잘못된 이름
        case unknown
        
        public var errorDescription: String {
            switch self {
            case .invalidName:
                return NSLocalizedString("🔥 invalidName exception", comment: "파일명이 잘못됨")
            case .unknown:
                return NSLocalizedString("🔥 unknown exception", comment: "unknown")
            }
        }
    }
    
}
