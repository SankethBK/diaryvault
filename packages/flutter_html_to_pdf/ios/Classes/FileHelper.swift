import UIKit

class FileHelper {
    
    /**
     Creates string with content of provided file
     */
    class func getContent(from filePath: String) -> String {
        let fileURL = URL(fileURLWithPath: filePath)
        return try! String(contentsOf: fileURL, encoding: String.Encoding.utf8)
    }
}
