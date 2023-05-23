//
//  ContentError.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 27.04.2022.
//

struct ContentError: Error {
    enum Code {
        case notContent
    }

    let code: Code
    let underlyingError: Error?

    init(_ code: Code, underlyingError: Error? = nil) {
        self.code = code
        self.underlyingError = underlyingError
    }
}
