//
//  MTK.m
//  Gather
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import "MTK.h"


@interface MTK (private)
+(RKObjectManager*)manager;
@end


@implementation MTK

+ (MTKUser*)currentUser
{
    RKObjectManager* tMgr = [self manager];
    NSFetchRequest* tFetch = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray* tUsers = [tMgr.managedObjectStore.mainQueueManagedObjectContext executeFetchRequest:tFetch error:nil];
    if( tUsers.count>0 ) {
        return [tUsers objectAtIndex:0];
    }else{
        return nil;
    }
}

+ (BOOL)userSignedIn
{
    return [self currentUser]!=nil;
}

+ (void)createUserWithEmail:(NSString *)aEmail password:(NSString *)aPassword success:(dispatch_block_t)aSuccess failure:(StringBlock)aFailure
{
    RKObjectManager* tMgr = [self manager];
    [tMgr postObject:nil
                path:@"/users"
          parameters:@{ @"user" : @{ @"email" : aEmail, @"password" : aPassword } }
             success:^(RKObjectRequestOperation* op, RKMappingResult* aResult) {
                 aSuccess();
             }
             failure:^(RKObjectRequestOperation* op, NSError* error) {
                 NSLog(@"sent request: %@",[[NSString alloc] initWithData:op.HTTPRequestOperation.request.HTTPBody encoding:NSUTF8StringEncoding]);
                 NSLog(@"received response: %@",op.HTTPRequestOperation.responseString);
                 aFailure([NSString stringWithFormat:@"%@",[error localizedRecoverySuggestion]]);
             }];
}

+ (void)createSessionWithEmail:(NSString *)aEmail password:(NSString *)aPassword success:(StringBlock)aSuccess failure:(StringBlock)aFailure
{
    RKObjectManager* tMgr = [self manager];
    [tMgr postObject:nil
                path:@"/users/sign_in"
          parameters:@{ @"user" : @{ @"email" : aEmail, @"password" : aPassword } }
             success:^(RKObjectRequestOperation* op, RKMappingResult* aResult) {
                 MTKUser* tUser = aResult.firstObject;
                 aSuccess(tUser.authenticationToken);
             }
             failure:^(RKObjectRequestOperation* op, NSError* error) {
                 NSLog(@"sent request: %@",[[NSString alloc] initWithData:op.HTTPRequestOperation.request.HTTPBody encoding:NSUTF8StringEncoding]);
                 NSLog(@"received response: %@",op.HTTPRequestOperation.responseString);
                 aFailure([NSString stringWithFormat:@"%@",[error localizedRecoverySuggestion]]);
             }];
}

#pragma mark - private

+ (RKObjectManager*)manager
{
    static RKObjectManager* sMgr;
    if( sMgr==nil ) {
        sMgr = [self initManager];
    }
    return sMgr;
}

+ (RKObjectManager*)initManager
{
    NSError* error;
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
    if (! success) {
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    }
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"MTK.sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    if (! persistentStore) {
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    }
    [managedObjectStore createManagedObjectContexts];
    
//    RKObjectManager* tMgr = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://matryoshka-staging.herokuapp.com"]];
    RKObjectManager* tMgr = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://local:3000"]];
    tMgr.requestSerializationMIMEType = @"application/json";
    tMgr.managedObjectStore = managedObjectStore;

    // user mapping
    RKEntityMapping* tMap = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:managedObjectStore];
    tMap.identificationAttributes = @[ @"userId" ];
    [tMap addAttributeMappingsFromDictionary:@{ @"id" : @"userId" }];
    [tMap addAttributeMappingsFromArray:@[ @"email", @"latitude", @"longitude", @"discoverable" ]];
    RKResponseDescriptor* tRsp = [RKResponseDescriptor responseDescriptorWithMapping:tMap pathPattern:@"/users" keyPath:@"user" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [tMgr addResponseDescriptor:tRsp];
    
    // session mapping
    tMap = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:managedObjectStore];
    tMap.identificationAttributes = @[ @"userId" ];
    [tMap addAttributeMappingsFromDictionary:@{ @"user_id" : @"userId", @"token" : @"authenticationToken" }];
    tRsp = [RKResponseDescriptor responseDescriptorWithMapping:tMap pathPattern:@"/users/sign_in" keyPath:@"session" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [tMgr addResponseDescriptor:tRsp];
    
    return tMgr;
}

@end
