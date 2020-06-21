//
//  CustomError.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case urlError
    case apiResponseError
    case dataNotFoundError
    case dataParsingError
    case unexpectedData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlError:
            return NSLocalizedString("URL error!", comment: "Invalid URL")
        case .dataNotFoundError:
            return NSLocalizedString("Data not found!", comment: "Data not found")
        case .dataParsingError:
            return NSLocalizedString("Not expected data!", comment: "Data error")
        case .apiResponseError:
            return NSLocalizedString("Found error in api response!", comment: "API error")
        case .unexpectedData:
            return NSLocalizedString("Unexpected data found", comment: "API error")
        }
    }
}
