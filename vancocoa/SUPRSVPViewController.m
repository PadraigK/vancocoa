//
//  SUPRSVPViewController
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import "SUPRSVPViewController.h"
#import "AFNetworking.h"

@interface SUPRSVPViewController ()

@end

@implementation SUPRSVPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)subscribe:(id)sender
{
    [self.emailTextField resignFirstResponder];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.vancocoa.com/"]];
    
    self.formContainer.fields[@"name"] = self.nameTextField.text;
    self.formContainer.fields[@"email"] = self.emailTextField.text;
    
    [client POST:self.formContainer.actionURL.absoluteString parameters:self.formContainer.fields success:^(NSHTTPURLResponse *response, id responseObject) {
        
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        self.doneLabel.hidden = NO;
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

-(IBAction)nextField:(id)sender
{
    if ([sender isEqual:self.nameTextField]) {
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.nameTextField]) {
        [self.emailTextField becomeFirstResponder];
        return YES;
    } else {
        [self subscribe:textField];
        return YES;
    }
}


@end
