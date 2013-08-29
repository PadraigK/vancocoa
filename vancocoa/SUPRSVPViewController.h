//
//  SUPRSVPViewController.h
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUPFormContainer.h"

@interface SUPRSVPViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) IBOutlet UITextField *emailTextField;
@property (nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) IBOutlet UIButton *subscribeButton;
@property (nonatomic) IBOutlet UILabel *doneLabel;

@property (nonatomic) SUPFormContainer *formContainer;

-(IBAction)subscribe:(id)sender;
-(IBAction)nextField:(id)sender;

@end
