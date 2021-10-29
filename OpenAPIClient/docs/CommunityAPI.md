# CommunityAPI

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**communityIdTokenGet**](CommunityAPI.md#communityidtokenget) | **GET** /community/{id}/token | Get an invite token
[**getCommunityById**](CommunityAPI.md#getcommunitybyid) | **GET** /community/{id} | Get a community by id
[**listUsersOfCommunity**](CommunityAPI.md#listusersofcommunity) | **GET** /community/{id}/users | List users in a community
[**newCommunity**](CommunityAPI.md#newcommunity) | **POST** /community | Create a new community
[**searchCommunities**](CommunityAPI.md#searchcommunities) | **GET** /community/search | Search communities using keyword and location
[**updateCommunity**](CommunityAPI.md#updatecommunity) | **PUT** /community/{id} | Update community infomation


# **communityIdTokenGet**
```swift
    open class func communityIdTokenGet(id: Int) -> Observable<GetCommunityIdTokenResponse>
```

Get an invite token

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int** |  | 

### Return type

[**GetCommunityIdTokenResponse**](GetCommunityIdTokenResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCommunityById**
```swift
    open class func getCommunityById(id: Int) -> Observable<Community>
```

Get a community by id

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int** |  | 

### Return type

[**Community**](Community.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listUsersOfCommunity**
```swift
    open class func listUsersOfCommunity(id: Int, after: Int64? = nil) -> Observable<ListCommunityUsersResponse>
```

List users in a community

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | 
let after = 987 // Int64 |  (optional)

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int** |  | 
 **after** | **Int64** |  | [optional] 

### Return type

[**ListCommunityUsersResponse**](ListCommunityUsersResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **newCommunity**
```swift
    open class func newCommunity(createCommunityRequest: CreateCommunityRequest) -> Observable<Community>
```

Create a new community

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let createCommunityRequest = createCommunityRequest(name: "name_example", description: "description_example", location: location(lat: 123, lng: 123)) // CreateCommunityRequest | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createCommunityRequest** | [**CreateCommunityRequest**](CreateCommunityRequest.md) |  | 

### Return type

[**Community**](Community.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchCommunities**
```swift
    open class func searchCommunities(keyword: String, after: Int64? = nil, centerLat: Double? = nil, centerLng: Double? = nil) -> Observable<SearchCommunityResponse>
```

Search communities using keyword and location

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let keyword = "keyword_example" // String | 
let after = 987 // Int64 |  (optional)
let centerLat = 987 // Double |  (optional)
let centerLng = 987 // Double |  (optional)

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String** |  | 
 **after** | **Int64** |  | [optional] 
 **centerLat** | **Double** |  | [optional] 
 **centerLng** | **Double** |  | [optional] 

### Return type

[**SearchCommunityResponse**](SearchCommunityResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCommunity**
```swift
    open class func updateCommunity(id: Int64, inlineObject: InlineObject? = nil) -> Observable<Community>
```

Update community infomation

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int64 | 
let inlineObject = inline_object(name: "name_example", description: "description_example", location: location(lat: 123, lng: 123)) // InlineObject |  (optional)

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int64** |  | 
 **inlineObject** | [**InlineObject**](InlineObject.md) |  | [optional] 

### Return type

[**Community**](Community.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

