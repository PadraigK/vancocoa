//
//  SUPVancocoaRootController.m
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import "SUPVancocoaRootController.h"
#import "AFNetworking.h"
#import "SUPVancocoaEventSerializer.h"
#import "SUPVancocoaEventParser.h"

@interface SUPVancocoaRootController ()

@end

@implementation SUPVancocoaRootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.vancocoa.com"]];

client.responseSerializer = [SUPVancocoaEventSerializer serializer];

[client GET:@"events/1" parameters:nil success:^(NSHTTPURLResponse *response, SUPVancocoaEventParser *eventParser) {
    
    [self attendeesViewController].attendees = eventParser.attendees;
} failure:^(NSError *error) {
    NSLog(@"Error getting event HTML: %@", error);
}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SUPAttendeesViewController *)attendeesViewController
{
    __block UIViewController *viewController;
    
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        viewController = (UIViewController *)obj;
        
        if ([viewController.title isEqualToString:@"Attendees"]) {
            *stop = YES;
        }
    }];
    
    return (SUPAttendeesViewController *)viewController;
}


@end
