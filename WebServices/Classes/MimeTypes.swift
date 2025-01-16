//
//  MimeTypes.swift
//  Populaw
//
//  Created by Gaurang on 02/12/21.
//

import Foundation
import UIKit

final class MimeTypes {
    var data: Data
    var mimeType: String
    var fileName: String
    var key: String
    var sizeInMB: Double

    init?(_ file: Any, key: String, maxSize: Int = 500) {
        self.key = key
        var mimeType: String?
        var fileData: Data?
        var fileName = ""
        if let image = file as? UIImage {
            if let data = image.getData(inKb: maxSize) {
                fileData = data
                mimeType = "image/jpeg"
                fileName = "\(Helper.randomString(length: 10)).jpeg"
                sizeInMB = Double(data.count) / (1024.0 * 1024.0)
            } else {
                return nil
            }
        }
        if let unwrappedData = fileData, let unwrappedMimeType = mimeType {
            data = unwrappedData
            self.mimeType = unwrappedMimeType
            self.fileName = fileName
            sizeInMB = Double(data.count) / (1024.0 * 1024.0)
        } else {
            return nil
        }
    }
}

extension UIImage {
    // MARK: - UIImage+Resize

    func compressTo(kb expectedSizeInKb: Int) -> UIImage? {
        if let data = getData(inKb: expectedSizeInKb) {
            return UIImage(data: data)
        }
        return nil
    }

    func getData(inKb expectedSizeInKb: Int) -> Data? {
        let sizeInBytes = expectedSizeInKb * 1024
        var needCompress = true
        var imgData: Data?
        var compressingValue: CGFloat = 1.0
        while needCompress && compressingValue > 0.0 {
            if let data: Data = jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                    if compressingValue < 0 {
                        imgData = data
                        needCompress = false
                    }
                }
            }
        }
        return imgData
    }
}

extension Data {
    var sizeInMb: Double {
        Double(self.count) / (1024.0 * 1024.0)
    }
}
