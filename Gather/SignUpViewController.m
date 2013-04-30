//
//  SignUpViewController.m
//  Gather
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import "SignUpViewController.h"
#import "MTK.h"


@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize emailText, passwordText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.emailText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if( textField==self.emailText ) {
        [self.emailText resignFirstResponder];
        [self.passwordText becomeFirstResponder];
    }else{
        dispatch_block_t tUserCreated = ^{
            [MTK createSessionWithEmail:self.emailText.text
                               password:self.passwordText.text
                                success:^(NSString* aToken) {
                                    NSLog(@"session created: %@",aToken);
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }
                                failure:^(NSString* aMsg) {
                                    NSLog(@"error creating session: %@",aMsg);
                                }];
        };
        [MTK createUserWithEmail:self.emailText.text
                        password:self.passwordText.text
                         success:tUserCreated
                         failure:^(NSString* aMsg) {
                             NSLog(@"%@",aMsg);
                             Alert(@"Unable to create user", aMsg);
                         }];
    }
    return YES;
}

@end
