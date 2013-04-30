//
//  SignUpViewController.h
//  Gather
//
//  Created by Aubrey Goodman on 4/30/13.
//  Copyright (c) 2013 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

@property (strong) IBOutlet UITextField* emailText;
@property (strong) IBOutlet UITextField* passwordText;

@end
