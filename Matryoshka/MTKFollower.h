//
//  MTKFollower.h
//  Gather
//
//  Created by Aubrey Goodman on 4/29/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MTKFollower : NSManagedObject

@property (strong) NSNumber* followerId;
@property (strong) NSNumber* consumerId;
@property (strong) NSNumber* producerId;

@end
