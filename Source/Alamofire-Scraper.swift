//
//  Alamofire-Scraper.swift
//  Alamofire-Scraper
//
//  Created by Aaron Lee on 2017-09-30.
//  Copyright (c) 2017 Aaron Lee. All rights reserved.
//

import Foundation

import Alamofire
import Kanna

// MARK: - Request for HTML

extension DataRequest {
    
    /// Creates a response serializer that returns a result string type initialized from the response data with
    /// the specified string encoding.
    ///
    /// - parameter encoding: The string encoding. If `nil`, the string encoding will be determined from the server
    ///                       response, falling back to the default HTTP default character set, ISO-8859-1.
    ///
    /// - returns: A string response serializer.
    public static func htmlResponseScrapper(_ css: String, encoding: String.Encoding? = nil) -> DataResponseSerializer<[String]> {
        return DataResponseSerializer { _, response, data, error in
            let request = Request.serializeResponseString(encoding: encoding, response: response, data: data, error: error)
            if case .failure = request {
                return .failure(request.error!)
            }

            if let html = request.value, let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                return .success(doc.css(css).flatMap {$0.text})
            } else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
            }
        }
    }
    
    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter encoding:          The string encoding. If `nil`, the string encoding will be determined from the
    ///                                server response, falling back to the default HTTP default character set,
    ///                                ISO-8859-1.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseHTML(
        scrapeBy css: String,
        queue: DispatchQueue? = nil,
        encoding: String.Encoding? = nil,
        completionHandler: @escaping (DataResponse<[String]>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: DataRequest.htmlResponseScrapper(css, encoding: encoding),
            completionHandler: completionHandler
        )
    }
}
