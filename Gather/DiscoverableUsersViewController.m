//
//  DiscoverableUsersViewController.m
//  Gather
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import "DiscoverableUsersViewController.h"
#import "MTK.h"


@interface DiscoverableUsersViewController ()

@end

@implementation DiscoverableUsersViewController

@synthesize users = _users;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ArrayBlock tSuccess = ^(NSArray* aUsers) {
        self.users = aUsers;
        [self.tableView reloadData];
    };
    StringBlock tFailure = ^(NSString* aMsg) {
        Alert(@"Unable to load users", aMsg);
    };

    [MTK findDiscoverableUsersSuccess:tSuccess failure:tFailure];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* sIdentifier = @"UserCell";
    UITableViewCell* tCell = [tableView dequeueReusableCellWithIdentifier:sIdentifier];

    MTKUser* tUser = [self.users objectAtIndex:indexPath.row];
    tCell.textLabel.text = tUser.email;
    
    return tCell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTKUser* tUser = [self.users objectAtIndex:indexPath.row];
    [MTK followUserId:tUser.userId
              success:^{
                  
              }
              failure:^{}];
}

@end
