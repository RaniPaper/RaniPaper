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
    var memoDirectoryPath: URL
    var diaryDirectoryPath: URL
    
    enum Folder {
        case memo, diary
    }
    
    private init() {
        print("✅ MyFileManger init")
        
        // 파일 매니저 인스턴스 생성
        self.fileManager = FileManager.default
        
        // 사용자의 문서 경로
        self.documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // 폴더 경로 지정
        // Documents/Memo
        // Documents/Diary
        self.memoDirectoryPath = documentPath.appendingPathComponent("Memo")
        self.diaryDirectoryPath = documentPath.appendingPathComponent("Diary")
        
        // 폴더 생성
        do {
            try fileManager.createDirectory(at: memoDirectoryPath, withIntermediateDirectories: false, attributes: nil)
            try fileManager.createDirectory(at: diaryDirectoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    /// CREATE : 파일을 생성(저장) 합니다.
    /// - Parameter folder: 저장할 폴더 ( Ex: Documents/RaniPaper/Memo/. )
    /// - Parameter fileName: Documents/RaniPaper/FolderName/. 에 저장 될 파일명 (확장자 지정 필요)
    /// - Parameter data: 저장할 Codable 객체
    /// - Returns: Void
    func create(at folder: Folder, fileName: String, _ data: Codable) -> Result<Void, CreateError> {
        if fileName.isEmpty { return .failure(.invalidName) }
        guard let data = try? JSONEncoder().encode(data) else { return .failure(.encodeError) }
        
        // 폴더 경로
        var directoryPath: URL
        switch folder {
        case .memo:
            directoryPath = memoDirectoryPath
        case .diary:
            directoryPath = diaryDirectoryPath
        }
        
        // 파일 경로
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // 파일 생성하기
        
        // 보조파일에 쓰기후 파일교체, 덮어쓰기 방지 옵션
        guard (try? data.write(to: filePath, options: .withoutOverwriting)) != nil else { return .failure(.unknown) }
        
        print("파일을 CREATE 합니다. 파일명:", fileName)
        return .success(())
    }
    
    /// READ : 파일을 읽어옵니다.
    /// - Parameter folder: 불러올 폴더 ( Ex: Documents/RaniPaper/Memo/. )
    /// - Parameter fileName: Documents/RaniPaper/. 에 저장 된 파일명 (확장자 지정 필요)
    /// - Returns: .success 시 Codable 객체 반환
    func read(at folder: Folder, fileName: String) -> Result<Codable, ReadError> {
        if fileName.isEmpty { return .failure(.invalidName) }
        
        // 폴더 경로
        var directoryPath: URL
        switch folder {
        case .memo:
            directoryPath = memoDirectoryPath
        case .diary:
            directoryPath = diaryDirectoryPath
        }
        
        // 파일 경로
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // path를 불러와서 Data타입으로 초기화
        guard let dataFromPath: Data = try? Data(contentsOf: filePath) else { return .failure(.unknown) }
        
        // JSON 디코딩
        var data: Codable
        switch folder {
        case .memo:
            guard let decodedData = try? JSONDecoder().decode(MemoModel.self, from: dataFromPath) else {
                return .failure(.decodeError) }
            data = decodedData
        case .diary:
            guard let decodedData = try? JSONDecoder().decode(TaskModel.self, from: dataFromPath) else {
                return .failure(.decodeError) }
            data = decodedData
        }
        
        print("파일을 READ 합니다. 내용:", data)
        return .success(data)
    }
    
    /// UPDATE : 파일을 수정 합니다.
    /// - Parameter folder: 저장할 폴더 ( Ex: Documents/RaniPaper/Memo/. )
    /// - Parameter fileName: Documents/RaniPaper/. 에 저장 될 파일명 (확장자 지정 필요)
    /// - Parameter data: 저장할 String
    /// - Returns: Void
    func update(at folder: Folder, fileName: String, _ data: Codable) -> Result<Void, UpdateError> {
        if fileName.isEmpty { return .failure(.invalidName)}
        guard let data = try? JSONEncoder().encode(data) else { return .failure(.encodeError) }
        
        // 폴더 경로
        var directoryPath: URL
        switch folder {
        case .memo:
            directoryPath = memoDirectoryPath
        case .diary:
            directoryPath = diaryDirectoryPath
        }
        
        // 파일 경로
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // 보조파일에 쓰기후 파일교체
        guard (try? data.write(to: filePath, options: .atomic)) != nil else { return .failure(.unknown) }
        
        print("파일을 UPDATE 합니다. 파일명:", fileName)
        return .success(())
    }
    
    /// DELETE : 파일을 삭제합니다.
    /// - Parameter folder: 삭제할 요소가 들어있는 폴더 ( Ex: Documents/RaniPaper/Memo/. )
    /// - Parameter fileName: Documents/RaniPaper/. 에 삭제 할 파일명 (확장자 지정 필요)
    /// - Returns: Void
    func delete(at folder: Folder, fileName: String) -> Result<Void, DeleteError> {
        if fileName.isEmpty { return .failure(.invalidName) }
        
        // 폴더 경로
        var directoryPath: URL
        switch folder {
        case .memo:
            directoryPath = memoDirectoryPath
        case .diary:
            directoryPath = diaryDirectoryPath
        }
        
        // 파일 경로
        let filePath = directoryPath.appendingPathComponent(fileName)
        
        // 파일을 삭제한다.
        guard (try? fileManager.removeItem(at: filePath)) != nil else { return .failure(.unknown) }
        
        print("파일을 DELETE 합니다. 파일명:", fileName)
        return .success(())
        
    }
    
}

extension MyFileManager {
    enum CreateError: Error {
        case invalidName // 잘못된 이름
        case encodeError // 인코딩 실패
        case alreadyExist // 이미 존재하는 파일
        case storageIsFull // 저장공간이 부족
        case unknown
        
        public var errorDescription: String {
            switch self {
            case .invalidName:
                return NSLocalizedString("🔥 invalidName exception", comment: "파일명이 잘못됨")
            case .encodeError:
                return NSLocalizedString("🔥 encodeError exception", comment: "인코딩에서 문제 발생")
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
        case decodeError // 디코딩 실패
        case unknown
        
        public var errorDescription: String {
            switch self {
            case .invalidName:
                return NSLocalizedString("🔥 invalidName exception", comment: "파일명이 잘못됨")
            case .decodeError:
                return NSLocalizedString("🔥 decodeError exception", comment: "디코딩에서 문제 발생")
            case .unknown:
                return NSLocalizedString("🔥 unknown exception", comment: "unknown")
            }
        }
    }
    
    enum UpdateError: Error {
        case invalidName // 잘못된 이름
        case encodeError // 인코딩 실패
        case storageIsFull // 저장공간이 부족
        case unknown
        
        public var errorDescription: String {
            switch self {
            case .invalidName:
                return NSLocalizedString("🔥 invalidName exception", comment: "파일명이 잘못됨")
            case .encodeError:
                return NSLocalizedString("🔥 encodeError exception", comment: "인코딩에서 문제 발생")
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
