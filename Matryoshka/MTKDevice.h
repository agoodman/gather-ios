//
//  MTKDevice.h
//  Matryoshka
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MTKUser.h"


@interface MTKDevice : NSManagedObject

@property (strong) NSNumber* deviceId;
@property (strong) NSNumber* userId;
@property (strong) NSString* token;
@property (strong) MTKUser* user;

@end
