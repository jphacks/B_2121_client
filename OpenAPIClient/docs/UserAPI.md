# UserAPI

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyProfile**](UserAPI.md#getmyprofile) | **GET** /user/me | Get my profile in detail
[**listUserCommunities**](UserAPI.md#listusercommunities) | **GET** /user/{id}/communities | Get communities where the specified user joins
[**newUser**](UserAPI.md#newuser) | **POST** /user | Create a new user
[**uploadProfileImage**](UserAPI.md#uploadprofileimage) | **POST** /user/profile | 
[**userIdCommunitiesCommunityIdDelete**](UserAPI.md#useridcommunitiescommunityiddelete) | **DELETE** /user/{id}/communities/{community_id} | Leave a community
[**userMeCommunitiesPost**](UserAPI.md#usermecommunitiespost) | **POST** /user/me/communities | Join a community
[**userMePut**](UserAPI.md#usermeput) | **PUT** /user/me | Update my profile


# **getMyProfile**
```swift
    open class func getMyProfile() -> Observable<UserDetail>
```

Get my profile in detail

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserDetail**](UserDetail.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listUserCommunities**
```swift
    open class func listUserCommunities(id: Int64, after: Int64? = nil) -> Observable<ListUserCommunityResponse>
```

Get communities where the specified user joins

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int64 | 
let after = 987 // Int64 |  (optional)

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int64** |  | 
 **after** | **Int64** |  | [optional] 

### Return type

[**ListUserCommunityResponse**](ListUserCommunityResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **newUser**
```swift
    open class func newUser(createUserRequest: CreateUserRequest) -> Observable<CreateUserResponse>
```

Create a new user

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let createUserRequest = createUserRequest(name: "name_example", vendor: authVendor()) // CreateUserRequest | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createUserRequest** | [**CreateUserRequest**](CreateUserRequest.md) |  | 

### Return type

[**CreateUserResponse**](CreateUserResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadProfileImage**
```swift
    open class func uploadProfileImage(body: URL? = nil) -> Observable<UploadImageProfileResponse>
```



### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let body = URL(string: "https://example.com")! // URL |  (optional)

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **URL** |  | [optional] 

### Return type

[**UploadImageProfileResponse**](UploadImageProfileResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: image/jpeg
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userIdCommunitiesCommunityIdDelete**
```swift
    open class func userIdCommunitiesCommunityIdDelete(id: Int64, communityId: Int64) -> Observable<Void>
```

Leave a community

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

# **userMeCommunitiesPost**
```swift
    open class func userMeCommunitiesPost(joinCommunityRequest: JoinCommunityRequest) -> Observable<Void>
```

Join a community

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let joinCommunityRequest = joinCommunityRequest(inviteToken: "inviteToken_example") // JoinCommunityRequest | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **joinCommunityRequest** | [**JoinCommunityRequest**](JoinCommunityRequest.md) |  | 

### Return type

Void (empty response body)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userMePut**
```swift
    open class func userMePut(putUserMeRequest: PutUserMeRequest) -> Observable<User>
```

Update my profile

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let putUserMeRequest = putUserMeRequest(name: "name_example") // PutUserMeRequest | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **putUserMeRequest** | [**PutUserMeRequest**](PutUserMeRequest.md) |  | 

### Return type

[**User**](User.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

