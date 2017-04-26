//
//import Foundation
//import XCTest
//
////////////////////////////////////////////////////////////////////
//// Preferences
//protocol userDefault {
//    func stringForKey(key: String) -> String
//}
//
//class Preferences {
//    let userDefault: userDefault
//    
//    init(userDefault: userDefault) {
//        self.userDefault = userDefault
//    }
//    
//    var username: String {
//        return userDefault.stringForKey(key: "Username")
//    }
//}
//
//class PreferencesTests: XCTestCase {
//    func testGetsUsernameFromuserDefault() {
//        let userDefaultSpy = userDefaultSpy()
//        userDefaultSpy.stringForKeyResult = "john"
//        let preferences = Preferences(userDefault: userDefaultSpy)
//        
//        let username = preferences.username
//        
//        XCTAssertTrue(userDefaultSpy.didCallStringForKey)
//        XCTAssertEqual(userDefaultSpy.keyPassedToStringForKey, "Username")
//        XCTAssertEqual(username, "john")
//    }
//}
//
////////////////////////////////////////////////////////////////////
//// Preferences logger
//protocol LogOutput {
//    func logMessage(message: String)
//}
//
//class PreferencesLogger {
//    let preferences: Preferences
//    let output: LogOutput
//    
//    init(preferences: Preferences, output: LogOutput) {
//        self.preferences = preferences
//        self.output = output
//    }
//    
//    func log() {
//        output.logMessage(message: "Username: \(preferences.username)")
//    }
//}
//
//class PreferencesLoggerTests: XCTestCase {
//    func testLogsUsername() {
//        let userDefaultStub = userDefaultSpy()
//        userDefaultStub.stringForKeyResult = "john"
//        let preferences = Preferences(userDefault: userDefaultStub)
//        let logOutputSpy = LogOutputSpy()
//        let preferencesLogger = PreferencesLogger(preferences: preferences, output: logOutputSpy)
//        
//        preferencesLogger.log()
//        
//        XCTAssertEqual(logOutputSpy.loggedMessage, "Username: john")
//    }
//}
//
////////////////////////////////////////////////////////////////////
//// Test doubles
//class userDefaultSpy: userDefault {
//    var stringForKeyResult = ""
//    private(set) var didCallStringForKey = false
//    private(set) var keyPassedToStringForKey = ""
//    
//    func stringForKey(key: String) -> String {
//        didCallStringForKey = true
//        keyPassedToStringForKey = key
//        return stringForKeyResult
//    }
//}
//
//class LogOutputSpy: LogOutput {
//    private(set) var loggedMessage = ""
//    
//    func logMessage(message: String) {
//        loggedMessage = message
//    }
//}
//
////////////////////////////////////////////////////////////////////
//// userDefault implementation
//class SystemuserDefaultAdapter: userDefault {
//    let systemUserDefault: UserDefaults
//    
//    init(systemUserDefault: UserDefaults) {
//        self.systemuserDefault = systemUserDefault
//    }
//    
//    func stringForKey(key: String) -> String {
//        if let string = systemUserDefault.stringForKey(key) {
//            return string
//        } else {
//            fatalError("Could not find string for key: \(key)")
//        }
//    }
//}
//
//// LogOutput implementation
//class SystemConsoleOutput: LogOutput {
//    func logMessage(message: String) {
//        print(message)
//    }
//}
//
////////////////////////////////////////////////////////////////////
//// Usage
//UserDefaults.standardUserDefault().setObject("john", forKey: "Username")
//
//let userDefault = SystemuserDefaultAdapter(systemuserDefault: UserDefaults.standardUserDefault())
//let preferences = Preferences(userDefault: userDefault)
//let preferencesLogger = PreferencesLogger(preferences: preferences, output: SystemConsoleOutput())
//preferencesLogger.log()
//
//UserDefaults.standardUserDefault().removeObjectForKey("Username")
