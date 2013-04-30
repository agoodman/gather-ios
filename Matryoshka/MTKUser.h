//
//  MTKUser.h
//  Matryoshka
//
//  Created by Aubrey Goodman on 4/29/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MTKUser : NSManagedObject

@property (strong) NSNumber* userId;
@property (strong) NSString* email;
@property (strong) NSString* password;
@property (strong) NSNumber* latitude;
@property (strong) NSNumber* longitude;
@property BOOL discoverable;
@property (strong) NSString* authenticationToken;
@property (strong) NSSet* devices;
@property (strong) NSSet* followers;

@end
