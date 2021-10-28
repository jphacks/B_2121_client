# RestaurantAPI

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addRestaurantToCommunity**](RestaurantAPI.md#addrestauranttocommunity) | **POST** /community/{id}/restaurants | Add a restaurant to a community
[**listCommunityRestaurants**](RestaurantAPI.md#listcommunityrestaurants) | **GET** /community/{id}/restaurants | List restaurants in a community
[**removeRestaurantFromCommunity**](RestaurantAPI.md#removerestaurantfromcommunity) | **DELETE** /community/{id}/restaurants/{restaurant_id} | Remove a restrant from the specified community
[**restaurantIdGet**](RestaurantAPI.md#restaurantidget) | **GET** /restaurant/{id} | Get information about the speicifed restaurant.
[**searchRestaurants**](RestaurantAPI.md#searchrestaurants) | **GET** /restaurant/search | Search restaurants using keyword and location


# **addRestaurantToCommunity**
```swift
    open class func addRestaurantToCommunity(id: Int, addRestaurantRequest: AddRestaurantRequest) -> Observable<Void>
```

Add a restaurant to a community

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int | 
let addRestaurantRequest = addRestaurantRequest(restaurantId: 123) // AddRestaurantRequest | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int** |  | 
 **addRestaurantRequest** | [**AddRestaurantRequest**](AddRestaurantRequest.md) |  | 

### Return type

Void (empty response body)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listCommunityRestaurants**
```swift
    open class func listCommunityRestaurants(id: Int, after: Int64? = nil) -> Observable<ListCommunityRestaurantsResponse>
```

List restaurants in a community

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

[**ListCommunityRestaurantsResponse**](ListCommunityRestaurantsResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeRestaurantFromCommunity**
```swift
    open class func removeRestaurantFromCommunity(id: Int64, restaurantId: Int64) -> Observable<Void>
```

Remove a restrant from the specified community

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Int64 | 
let restaurantId = 987 // Int64 | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Int64** |  | 
 **restaurantId** | **Int64** |  | 

### Return type

Void (empty response body)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restaurantIdGet**
```swift
    open class func restaurantIdGet(id: Int64) -> Observable<Restaurant>
```

Get information about the speicifed restaurant.

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

[**Restaurant**](Restaurant.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchRestaurants**
```swift
    open class func searchRestaurants(keyword: String, after: Int64? = nil, centerLat: Double? = nil, centerLng: Double? = nil) -> Observable<SearchRestaurantResponse>
```

Search restaurants using keyword and location

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

[**SearchRestaurantResponse**](SearchRestaurantResponse.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

