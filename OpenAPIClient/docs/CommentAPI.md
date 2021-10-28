# CommentAPI

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getRestaurantComment**](CommentAPI.md#getrestaurantcomment) | **GET** /community/{id}/restaurants/{restaurant_id}/comments | Get private comments for a restaurant
[**updateRestaurantComment**](CommentAPI.md#updaterestaurantcomment) | **PUT** /community/{id}/restaurants/{restaurant_id}/comments | Update comment of the restaurant


# **getRestaurantComment**
```swift
    open class func getRestaurantComment(id: Int, restaurantId: Int) -> Observable<[Comment]>
```

Get private comments for a restaurant

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | 
let restaurantId = 987 // Int | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int** |  | 
 **restaurantId** | **Int** |  | 

### Return type

[**[Comment]**](Comment.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateRestaurantComment**
```swift
    open class func updateRestaurantComment(id: Int, restaurantId: Int, updateCommentRequest: UpdateCommentRequest) -> Observable<Comment>
```

Update comment of the restaurant

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | 
let restaurantId = 987 // Int | 
let updateCommentRequest = updateCommentRequest(body: "body_example") // UpdateCommentRequest | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int** |  | 
 **restaurantId** | **Int** |  | 
 **updateCommentRequest** | [**UpdateCommentRequest**](UpdateCommentRequest.md) |  | 

### Return type

[**Comment**](Comment.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

