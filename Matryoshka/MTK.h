//
//  MTK.h
//  Matryoshka
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTKUser.h"
#import "MTKFollower.h"


typedef void(^StringBlock)(NSString*);
typedef void(^ArrayBlock)(NSArray*);

@interface MTK : NSObject

+(MTKUser*)currentUser;
+(BOOL)userSignedIn;
+(void)createUserWithEmail:(NSString*)aEmail password:(NSString*)aPassword success:(dispatch_block_t)aSuccess failure:(StringBlock)aFailure;
+(void)createSessionWithEmail:(NSString*)aEmail password:(NSString*)aPassword success:(StringBlock)aSuccess failure:(StringBlock)aFailure;
+(void)registerDeviceToken:(NSString*)aToken success:(dispatch_block_t)aSuccess failure:(dispatch_block_t)aFailure;
+(void)findDiscoverableUsersSuccess:(ArrayBlock)aSuccess failure:(StringBlock)aFailure;
+(void)followUserId:(NSNumber*)aUserId success:(dispatch_block_t)aSuccess failure:(dispatch_block_t)aFailure;


@end
