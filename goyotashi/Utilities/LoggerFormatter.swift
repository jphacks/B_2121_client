//
//  LoggerFormatter.swift
//  goyotashi
//
//  Created by Akihiro Kokubo on 2021/10/29.
//

import LoggerKit
import RxSwift

final class LoggerFormatter: LogFormatterProtocol {
    func format(message: Any, level: LogLevel, context: LogContextProtocol) -> String {
        guard let messages = message as? [Any] else {
            return "\(emoji(level)) \(message)"
        }

        let message = messages.reduce("") { result, any in
            "\(result) \(String(describing: any))"
        }
        return "\(emoji(level)) \(message)"
    }

    func emoji(_ level: LogLevel) -> String {
        switch level {
        case .verbose:
            return "🤖"
        case .debug:
            return "🐛"
        case .info:
            return "ℹ️"
        case .warning:
            return "⚠️"
        case .error:
            return "🛑"
        }
    }
}

public typealias LoggerEvent = (level: LogLevel, message: Any, context: LogContextProtocol)

public final class CustomLogger: Logger {
    fileprivate let sendSubject = PublishSubject<LoggerEvent>()

    public override func willSend(level: LogLevel, message: Any, context: LogContextProtocol) {
        sendSubject.onNext((level: level, message: message, context: context))
    }
}

extension CustomLogger: ReactiveCompatible {}

public extension Reactive where Base: CustomLogger {
    var willSend: Observable<LoggerEvent> {
        base.sendSubject.asObserver()
    }
}

public let logger: CustomLogger = {
    let logger = CustomLogger()
    let stdout = StandardOut()
    stdout.formatter = LoggerFormatter()
    logger.register(destination: stdout)
    return logger
}()
