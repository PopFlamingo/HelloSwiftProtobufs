import Foundation

let object1 = """
{
"id": { "a": "923932IDABCD839##@" },
"Field_X": "abcdefghijklmnopqrstuvwxyz1234567890@&'(§è!çà)",
"fieldY": true,
"fieldZ": 3.1415
}
"""

let object2 = """
{
"id": { "d": 2 },
"Field_X": "abcdefghijklmnopqrstuvwxyz1234567890@&'(§è!çà)",
"fieldY": true,
"fieldZ": 3.1415
}
"""

let data1 = object1.data(using: .utf8)!
let data2 = object2.data(using: .utf8)!

func measurePerformance(label: String, _ closure: () throws -> ()) rethrows {
    let start = Date()
    try closure()
    print("\(label) took \(Date().timeIntervalSince(start))s to execute")
}

let repetitions = 1_000_000
var globalCounter = 0.0

try measurePerformance(label: "Protobufs") {
    for _ in 0..<repetitions {
        let value1 = try Bar(jsonUTF8Data: data1)
        let value2 = try Bar(jsonUTF8Data: data2)
        globalCounter += value1.fieldZ
        globalCounter += value2.fieldZ
    }
}
