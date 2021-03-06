# Swift5 API client for OpenAPIClient

This is the API specification of goyotashi server

## Overview
This API client was generated by the [OpenAPI Generator](https://openapi-generator.tech) project.  By using the [openapi-spec](https://github.com/OAI/OpenAPI-Specification) from a remote server, you can easily generate an API client.

- API version: 0.1.0
- Package version: 
- Build package: org.openapitools.codegen.languages.Swift5ClientCodegen

## Installation

### Carthage

Run `carthage update`

### CocoaPods

Run `pod install`

## Documentation for API Endpoints

All URIs are relative to *http://localhost:8080*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*BookmarkAPI* | [**userIdBookmarkCommunityIdDelete**](docs/BookmarkAPI.md#useridbookmarkcommunityiddelete) | **DELETE** /user/{id}/bookmark/{community_id} | Delete bookmark from the specified user
*BookmarkAPI* | [**userIdBookmarkGet**](docs/BookmarkAPI.md#useridbookmarkget) | **GET** /user/{id}/bookmark | Get bookmarking list of the specified user
*BookmarkAPI* | [**userIdBookmarkPost**](docs/BookmarkAPI.md#useridbookmarkpost) | **POST** /user/{id}/bookmark | Create a new bookmark
*CommentAPI* | [**getRestaurantComment**](docs/CommentAPI.md#getrestaurantcomment) | **GET** /community/{id}/restaurants/{restaurant_id}/comments | Get private comments for a restaurant
*CommentAPI* | [**updateRestaurantComment**](docs/CommentAPI.md#updaterestaurantcomment) | **PUT** /community/{id}/restaurants/{restaurant_id}/comments | Update comment of the restaurant
*CommunityAPI* | [**communityIdTokenGet**](docs/CommunityAPI.md#communityidtokenget) | **GET** /community/{id}/token | Get an invite token
*CommunityAPI* | [**getCommunityById**](docs/CommunityAPI.md#getcommunitybyid) | **GET** /community/{id} | Get a community by id
*CommunityAPI* | [**listUsersOfCommunity**](docs/CommunityAPI.md#listusersofcommunity) | **GET** /community/{id}/users | List users in a community
*CommunityAPI* | [**newCommunity**](docs/CommunityAPI.md#newcommunity) | **POST** /community | Create a new community
*CommunityAPI* | [**searchCommunities**](docs/CommunityAPI.md#searchcommunities) | **GET** /community/search | Search communities using keyword and location
*CommunityAPI* | [**updateCommunity**](docs/CommunityAPI.md#updatecommunity) | **PUT** /community/{id} | Update community infomation
*RestaurantAPI* | [**addRestaurantToCommunity**](docs/RestaurantAPI.md#addrestauranttocommunity) | **POST** /community/{id}/restaurants | Add a restaurant to a community
*RestaurantAPI* | [**listCommunityRestaurants**](docs/RestaurantAPI.md#listcommunityrestaurants) | **GET** /community/{id}/restaurants | List restaurants in a community
*RestaurantAPI* | [**removeRestaurantFromCommunity**](docs/RestaurantAPI.md#removerestaurantfromcommunity) | **DELETE** /community/{id}/restaurants/{restaurant_id} | Remove a restrant from the specified community
*RestaurantAPI* | [**restaurantIdGet**](docs/RestaurantAPI.md#restaurantidget) | **GET** /restaurant/{id} | Get information about the speicifed restaurant.
*RestaurantAPI* | [**restaurantIdOtherGet**](docs/RestaurantAPI.md#restaurantidotherget) | **GET** /restaurant/{id}/other | Get other communities which have the secified in thier lists
*RestaurantAPI* | [**searchRestaurants**](docs/RestaurantAPI.md#searchrestaurants) | **GET** /restaurant/search | Search restaurants using keyword and location
*UserAPI* | [**getMyProfile**](docs/UserAPI.md#getmyprofile) | **GET** /user/me | Get my profile in detail
*UserAPI* | [**listUserCommunities**](docs/UserAPI.md#listusercommunities) | **GET** /user/{id}/communities | Get communities where the specified user joins
*UserAPI* | [**newUser**](docs/UserAPI.md#newuser) | **POST** /user | Create a new user
*UserAPI* | [**uploadProfileImage**](docs/UserAPI.md#uploadprofileimage) | **POST** /user/profile | 
*UserAPI* | [**userIdCommunitiesCommunityIdDelete**](docs/UserAPI.md#useridcommunitiescommunityiddelete) | **DELETE** /user/{id}/communities/{community_id} | Leave a community
*UserAPI* | [**userMeCommunitiesPost**](docs/UserAPI.md#usermecommunitiespost) | **POST** /user/me/communities | Join a community
*UserAPI* | [**userMePut**](docs/UserAPI.md#usermeput) | **PUT** /user/me | Update my profile


## Documentation For Models

 - [AddRestaurantRequest](docs/AddRestaurantRequest.md)
 - [Affiliation](docs/Affiliation.md)
 - [AuthInfo](docs/AuthInfo.md)
 - [AuthVendor](docs/AuthVendor.md)
 - [Bookmark](docs/Bookmark.md)
 - [Comment](docs/Comment.md)
 - [Community](docs/Community.md)
 - [CreateCommunityRequest](docs/CreateCommunityRequest.md)
 - [CreateUserRequest](docs/CreateUserRequest.md)
 - [CreateUserResponse](docs/CreateUserResponse.md)
 - [GetCommunityIdTokenResponse](docs/GetCommunityIdTokenResponse.md)
 - [GetOtherCommunityResponse](docs/GetOtherCommunityResponse.md)
 - [InlineObject](docs/InlineObject.md)
 - [InlineObject1](docs/InlineObject1.md)
 - [JoinCommunityRequest](docs/JoinCommunityRequest.md)
 - [ListCommunityRestaurantsResponse](docs/ListCommunityRestaurantsResponse.md)
 - [ListCommunityRestaurantsResponseAllOf](docs/ListCommunityRestaurantsResponseAllOf.md)
 - [ListCommunityUsersResponse](docs/ListCommunityUsersResponse.md)
 - [ListCommunityUsersResponseAllOf](docs/ListCommunityUsersResponseAllOf.md)
 - [ListUserBookmarkResponse](docs/ListUserBookmarkResponse.md)
 - [ListUserCommunityResponse](docs/ListUserCommunityResponse.md)
 - [Location](docs/Location.md)
 - [PageInfo](docs/PageInfo.md)
 - [PutUserMeRequest](docs/PutUserMeRequest.md)
 - [Restaurant](docs/Restaurant.md)
 - [SearchCommunityResponse](docs/SearchCommunityResponse.md)
 - [SearchCommunityResponseAllOf](docs/SearchCommunityResponseAllOf.md)
 - [SearchRestaurantResponse](docs/SearchRestaurantResponse.md)
 - [UpdateCommentRequest](docs/UpdateCommentRequest.md)
 - [UploadImageProfileResponse](docs/UploadImageProfileResponse.md)
 - [User](docs/User.md)
 - [UserDetail](docs/UserDetail.md)
 - [UserDetailAllOf](docs/UserDetailAllOf.md)


## Documentation For Authorization


## token

- **Type**: API key
- **API key parameter name**: Authorization
- **Location**: HTTP header


## Author



