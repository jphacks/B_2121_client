//
// CommunityAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import RxSwift
#if canImport(AnyCodable)
import AnyCodable
#endif

open class CommunityAPI {

    /**
     Get an invite token
     
     - parameter id: (path)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: Observable<GetCommunityIdTokenResponse>
     */
    open class func communityIdTokenGet(id: Int, apiResponseQueue: DispatchQueue = OpenAPIClient.apiResponseQueue) -> Observable<GetCommunityIdTokenResponse> {
        return Observable.create { observer -> Disposable in
            communityIdTokenGetWithRequestBuilder(id: id).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    observer.onNext(response.body!)
                case let .failure(error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    /**
     Get an invite token
     - GET /community/{id}/token
     - API Key:
       - type: apiKey Authorization 
       - name: token
     - parameter id: (path)  
     - returns: RequestBuilder<GetCommunityIdTokenResponse> 
     */
    open class func communityIdTokenGetWithRequestBuilder(id: Int) -> RequestBuilder<GetCommunityIdTokenResponse> {
        var localVariablePath = "/community/{id}/token"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<GetCommunityIdTokenResponse>.Type = OpenAPIClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

    /**
     Get a community by id
     
     - parameter id: (path)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: Observable<Community>
     */
    open class func getCommunityById(id: Int, apiResponseQueue: DispatchQueue = OpenAPIClient.apiResponseQueue) -> Observable<Community> {
        return Observable.create { observer -> Disposable in
            getCommunityByIdWithRequestBuilder(id: id).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    observer.onNext(response.body!)
                case let .failure(error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    /**
     Get a community by id
     - GET /community/{id}
     - API Key:
       - type: apiKey Authorization 
       - name: token
     - parameter id: (path)  
     - returns: RequestBuilder<Community> 
     */
    open class func getCommunityByIdWithRequestBuilder(id: Int) -> RequestBuilder<Community> {
        var localVariablePath = "/community/{id}"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Community>.Type = OpenAPIClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

    /**
     List users in a community
     
     - parameter id: (path)  
     - parameter after: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: Observable<ListCommunityUsersResponse>
     */
    open class func listUsersOfCommunity(id: Int, after: Int64? = nil, apiResponseQueue: DispatchQueue = OpenAPIClient.apiResponseQueue) -> Observable<ListCommunityUsersResponse> {
        return Observable.create { observer -> Disposable in
            listUsersOfCommunityWithRequestBuilder(id: id, after: after).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    observer.onNext(response.body!)
                case let .failure(error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    /**
     List users in a community
     - GET /community/{id}/users
     - API Key:
       - type: apiKey Authorization 
       - name: token
     - parameter id: (path)  
     - parameter after: (query)  (optional)
     - returns: RequestBuilder<ListCommunityUsersResponse> 
     */
    open class func listUsersOfCommunityWithRequestBuilder(id: Int, after: Int64? = nil) -> RequestBuilder<ListCommunityUsersResponse> {
        var localVariablePath = "/community/{id}/users"
        let idPreEscape = "\(APIHelper.mapValueToPathItem(id))"
        let idPostEscape = idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{id}", with: idPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "after": after?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<ListCommunityUsersResponse>.Type = OpenAPIClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

    /**
     Create a new community
     
     - parameter createCommunityRequest: (body)  
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: Observable<Community>
     */
    open class func newCommunity(createCommunityRequest: CreateCommunityRequest, apiResponseQueue: DispatchQueue = OpenAPIClient.apiResponseQueue) -> Observable<Community> {
        return Observable.create { observer -> Disposable in
            newCommunityWithRequestBuilder(createCommunityRequest: createCommunityRequest).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    observer.onNext(response.body!)
                case let .failure(error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    /**
     Create a new community
     - POST /community
     - API Key:
       - type: apiKey Authorization 
       - name: token
     - parameter createCommunityRequest: (body)  
     - returns: RequestBuilder<Community> 
     */
    open class func newCommunityWithRequestBuilder(createCommunityRequest: CreateCommunityRequest) -> RequestBuilder<Community> {
        let localVariablePath = "/community"
        let localVariableURLString = OpenAPIClient.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: createCommunityRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Community>.Type = OpenAPIClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }

    /**
     Search communities using keyword and location
     
     - parameter keyword: (query)  
     - parameter after: (query)  (optional)
     - parameter centerLat: (query)  (optional)
     - parameter centerLng: (query)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - returns: Observable<SearchCommunityResponse>
     */
    open class func searchCommunities(keyword: String, after: Int64? = nil, centerLat: Double? = nil, centerLng: Double? = nil, apiResponseQueue: DispatchQueue = OpenAPIClient.apiResponseQueue) -> Observable<SearchCommunityResponse> {
        return Observable.create { observer -> Disposable in
            searchCommunitiesWithRequestBuilder(keyword: keyword, after: after, centerLat: centerLat, centerLng: centerLng).execute(apiResponseQueue) { result -> Void in
                switch result {
                case let .success(response):
                    observer.onNext(response.body!)
                case let .failure(error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    /**
     Search communities using keyword and location
     - GET /community/search
     - API Key:
       - type: apiKey Authorization 
       - name: token
     - parameter keyword: (query)  
     - parameter after: (query)  (optional)
     - parameter centerLat: (query)  (optional)
     - parameter centerLng: (query)  (optional)
     - returns: RequestBuilder<SearchCommunityResponse> 
     */
    open class func searchCommunitiesWithRequestBuilder(keyword: String, after: Int64? = nil, centerLat: Double? = nil, centerLng: Double? = nil) -> RequestBuilder<SearchCommunityResponse> {
        let localVariablePath = "/community/search"
        let localVariableURLString = OpenAPIClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "after": after?.encodeToJSON(),
            "keyword": keyword.encodeToJSON(),
            "center_lat": centerLat?.encodeToJSON(),
            "center_lng": centerLng?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<SearchCommunityResponse>.Type = OpenAPIClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }
}
