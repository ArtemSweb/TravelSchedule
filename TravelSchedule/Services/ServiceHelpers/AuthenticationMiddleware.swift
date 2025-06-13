//
//  AuthenticationMiddleware.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 13.06.2025.
//
import Foundation
import HTTPTypes
import OpenAPIRuntime

struct AuthenticationMiddleware: ClientMiddleware {
    private let value: String

    init(authorizationHeaderFieldValue value: String) {
        self.value = value
    }

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = value
        return try await next(request, body, baseURL)
    }
}
