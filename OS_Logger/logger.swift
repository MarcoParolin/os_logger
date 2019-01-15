//
//  logger.swift
//  OS_Logger
//
//  Created by Marco Parolin on 15/01/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import os

public enum LoggerCategory: String {
    // Generic category
    case general = "General"
    // Networking category
    case network = "Network"
    // Authentication category -> Should hide sensible informations
    case auth = "Authentication"
    
    var log: OSLog {
        // The subsystem of your app ("com.google.app")
        let subsystem = "enter.your.subsystem"
        return OSLog(subsystem: subsystem, category: self.rawValue)
    }
}

public enum LoggerType {
    // Default log level
    case info
    // Debug log level. This logs will not be emitted when the app is buid for release
    case debug
    // Warning log level. Will be displayer with a yellow dot in the console
    case warning
    // Error log level. Will be displayer with a yellow dot in the console
    case error
    
    var type: OSLogType {
        switch self {
        case .info:
            return .default
        case .debug:
            return .debug
        case .warning:
            return .error
        case .error:
            return .fault
        }
    }
    
}

/**
 Display log into macOS system console (/Applications/Utilities/Console)
 - parameter string: The message that will be displayed
 - parameter logCategory: Category used to group the logs (logs will be in the .general category by default)
 - parameter logType: Type of the log (logs will be of .info type by default)
 - parameter shouldBePrivate: if true the log will be obfuscated (logs will be public by default)
 - parameter callerFile: The file where the log is calles from (You should not insert it manually)
 - parameter callerLine: The line where the log is calles from (You should not insert it manually)
 - parameter callerFunc: The function where the log is calles from (You should not insert it manually)
 */
public func logger(_ string: String,
                   _ logCategory: LoggerCategory = .general,
                   _ logType: LoggerType = .info,
                   shouldBePrivate: Bool = false,
                   callerFile: String = #file,
                   callerLine: Int = #line,
                   callerFunc: String = #function) {
    let callerFile = callerFile.components(separatedBy: "/").last ?? "Unknown File"
    
    if (logType == .debug) && !isDebuggerAttached() {
        // return if the app is not in debug and the log level is "debug"
        return
    }
    
    switch logCategory {
    case .auth:
        os_log("[AUTH]: %{private}@", log: logCategory.log, type: logType.type, string)
    default:
        
        let staticString: StaticString = shouldBePrivate ? "[%{private}@]:%{private}@ .%{private}@ -> %{private}@" : "[%{public}@]:%{public}@ .%{public}@ -> %{public}@"
            os_log(staticString, log: logCategory.log, type: logType.type, callerFile, String(callerLine), callerFunc, string)
    }
    
}

private func isDebuggerAttached() -> Bool {
    // Method that checks if the app is currently built for debug or release
    return _isDebugAssertConfiguration()
}
