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
#import "SUPEventViewController.h"
#import "SUPRSVPViewController.h"
#import "SUPSpeaker.h"

@interface SUPVancocoaRootController ()

- (SUPAttendeesViewController *)attendeesViewController;
- (SUPEventViewController *)eventViewController;
- (SUPRSVPViewController *)rsvpViewController;

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
    
    self.parser = eventParser;
    
    self.attendeesViewController.attendees = eventParser.attendees;
    
    self.eventViewController.dateLabel.text = eventParser.dateString;
    self.eventViewController.eventSummaryLabel.text = eventParser.eventSummary;
    
    __block NSString *talksText = @"";
    
    [eventParser.talks enumerateObjectsUsingBlock:^(SUPSpeaker *talk, NSUInteger idx, BOOL *stop) {
        talksText = [NSString stringWithFormat:@"%@\n%u. %@\n", talksText,idx+1, talk];
    }];
    
    self.eventViewController.speakersLabel.text =talksText;
    
    self.rsvpViewController.formContainer = eventParser.rsvpFormDetails;

    
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
    return (SUPAttendeesViewController *)[self viewControllerTitled:@"Attendees"];
}

- (SUPEventViewController *)eventViewController
{
    return (SUPEventViewController *)[self viewControllerTitled:@"Event"];
}

- (SUPRSVPViewController *)rsvpViewController
{
    return (SUPRSVPViewController *)[self viewControllerTitled:@"RSVP"];
}

- (UIViewController *)viewControllerTitled:(NSString *)title
{
    __block UIViewController *viewController;
    
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        viewController = (UIViewController *)obj;
        
        if ([viewController.title isEqualToString:title]) {
            *stop = YES;
        }
    }];
    
    return viewController;
}

@end
