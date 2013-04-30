//
//  MTK.h
//  Gather
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTKUser.h"
#import "MTKFollower.h"


typedef void(^StringBlock)(NSString*);

@interface MTK : NSObject

+(BOOL)userSignedIn;
+(void)createUserWithEmail:(NSString*)aEmail password:(NSString*)aPassword success:(dispatch_block_t)aSuccess failure:(StringBlock)aFailure;
+(void)createSessionWithEmail:(NSString*)aEmail password:(NSString*)aPassword success:(StringBlock)aSuccess failure:(StringBlock)aFailure;

@end
