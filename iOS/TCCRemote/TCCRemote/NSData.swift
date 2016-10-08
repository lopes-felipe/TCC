import Foundation

extension Data {
    
    static func dataWithValue<T>(value: T) -> Data {
        var variableValue = value
        
        return Data(bytes: &variableValue, count: MemoryLayout<T>.size)
    }
    
    func int8Value() -> Int8 {
        var value: UInt8 = 0
        copyBytes(to: &value, count: MemoryLayout<UInt8>.size)
        return Int8(value)
    }
}
