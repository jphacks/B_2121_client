# BookmarkAPI

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**userIdBookmarkCommunityIdDelete**](BookmarkAPI.md#useridbookmarkcommunityiddelete) | **DELETE** /user/{id}/bookmark/{community_id} | Delete bookmark from the specified user
[**userIdBookmarkGet**](BookmarkAPI.md#useridbookmarkget) | **GET** /user/{id}/bookmark | Get bookmarking list of the specified user
[**userIdBookmarkPost**](BookmarkAPI.md#useridbookmarkpost) | **POST** /user/{id}/bookmark | Create a new bookmark


# **userIdBookmarkCommunityIdDelete**
```swift
    open class func userIdBookmarkCommunityIdDelete(id: Int64, communityId: Int64) -> Observable<Void>
```

Delete bookmark from the specified user

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int64 | 
let communityId = 987 // Int64 | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int64** |  | 
 **communityId** | **Int64** |  | 

### Return type

Void (empty response body)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userIdBookmarkGet**
```swift
    open class func userIdBookmarkGet(id: Int64) -> Observable<PageInfo>
```

Get bookmarking list of the specified user

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int64 | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int64** |  | 

### Return type

[**PageInfo**](PageInfo.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userIdBookmarkPost**
```swift
    open class func userIdBookmarkPost(id: Int64, inlineObject: InlineObject) -> Observable<Void>
```

Create a new bookmark

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int64 | 
let inlineObject = inline_object(communityId: 123) // InlineObject | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int64** |  | 
 **inlineObject** | [**InlineObject**](InlineObject.md) |  | 

### Return type

Void (empty response body)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

