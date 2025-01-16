//
//  DocumentManager.swift
//  StrataPanel
//
//  Created by Gaurang on 23/08/23.
//

import Foundation

import Foundation

enum DocumentError: LocalizedError {
    case downloadFailed
    case saveFailed

    var errorDescription: String? {
        switch self {
        case .downloadFailed:
            return NSLocalizedString("Failed to download the document.", comment: "Download Error")
        case .saveFailed:
            return NSLocalizedString("Failed to save the document.", comment: "Save Error")
        }
    }
}

class DocumentManager {
    static let shared = DocumentManager() // Singleton instance
    
    private init() {}
    
    // Function to save a document to the local document directory
    func saveDocument(data: Data, fileName: String) throws -> URL {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving document: \(error)")
            throw DocumentError.saveFailed
        }
    }
    
    // Function to download a document from a remote URL and save it locally
    func downloadAndSaveDocument(
        from remoteURL: URL,
        fileName: String
    ) async throws -> URL {
        if let url = self.getLocalDocumentURL(fileName: fileName)  {
            return url
        } else {
            do {
                let (data, _) = try await URLSession.shared.data(from: remoteURL)
                return try saveDocument(data: data, fileName: fileName)
            } catch DocumentError.saveFailed{
                throw DocumentError.saveFailed
            } catch {
                throw DocumentError.downloadFailed
            }
        }
    }
    
    // Function to get a document URL from local if it exists
    func getLocalDocumentURL(fileName: String) -> URL? {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let localFileURL = documentDirectory.appendingPathComponent(fileName)
            
            if FileManager.default.fileExists(atPath: localFileURL.path) {
                return localFileURL
            } else {
                print("Local document does not exist.")
                return nil
            }
        } catch {
            print("Error getting local document URL: \(error)")
            return nil
        }
    }
}
