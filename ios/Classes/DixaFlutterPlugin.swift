import Flutter
import UIKit
import DixaMessenger

public class DixaFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "dixa_flutter", binaryMessenger: registrar.messenger())
        let instance: DixaFlutterPlugin = DixaFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)    
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        case "configure":
            let arguments = call.arguments as! [String: String]
            let config = DixaConfiguration(token: arguments["apiKey"] as! String, logLevel: .error, pushEnvironment: .production)
            Messenger.configure(config)
        case "setPushToken":
            let arguments = call.arguments as! [String: String]
            let token = arguments["token"] as? String
            if let token {
                let encodedToken: Data = self.createData(withHexString: token) as Data
                Messenger.pushNotification.register(deviceToken: encodedToken)
            }
        case "updateUserCredentials":
            let arguments = call.arguments as! [String: String]
            Messenger.updateUserCredentials(username: arguments["username"] as! String, email: arguments["email"] as! String)
            result(true)
        case "clearUserCredentials":
            Messenger.clearUserCredentials()
            result(true)
        case "openMessenger":
            Messenger.openMessenger(from: UIApplication.shared.windows.first!.rootViewController!)
        default:
            result("Method not implemented")
        }
    }
    
    func createData(withHexString inputString: String) -> Data {
        let inLength = inputString.count
        
        let inCharacters = Array(inputString.utf16)
        
        var outBytes = [UInt8](repeating: 0, count: (inLength / 2) + 1)
        
        var i = 0
        var o = 0
        var outByte: UInt8 = 0
        
        while i < inLength {
            let c = inCharacters[i]
            var value: Int8 = -1
            
            switch c {
            case 48...57: // 0...9
                value = Int8(c - 48)
            case 65...70: // A...F
                value = Int8(c - 65 + 10)
            case 97...102: // a...f
                value = Int8(c - 97 + 10)
            default:
                break
            }
            
            if value >= 0 {
                if i % 2 == 1 {
                    outBytes[o] = (outByte << 4) | UInt8(value)
                    o += 1
                    outByte = 0
                } else {
                    outByte = UInt8(value)
                }
            } else {
                if o != 0 {
                    break
                }
            }
            
            i += 1
        }
        
        return Data(bytes: outBytes, count: o)
    }
    
}
