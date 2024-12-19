import Foundation

extension Data {
    func prettyPrintedJSONString() -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []),
              let prettyPrintedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
              let jsonString = String(data: prettyPrintedData, encoding: .utf8) else {
            return nil
        }
        return jsonString
    }
}
