//
//  StartViewController.m
//  Gather
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import "StartViewController.h"
#import "MTK.h"


@interface StartViewController ()

@end

@implementation StartViewController

- (IBAction)startGathering:(id)sender
{
    Alert(@"TODO", @"start tracking group");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if( ![MTK userSignedIn] ) {
        [self performSegueWithIdentifier:@"ShowSignIn" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
