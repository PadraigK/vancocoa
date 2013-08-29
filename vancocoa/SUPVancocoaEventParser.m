//
//  SUPVancocoaEventParser.m
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import "SUPVancocoaEventParser.h"
#import "HTMLParser.h"
#import "SUPSpeaker.h"
#import "SUPAttendee.h"

#import "NSString+Trim.h"

@interface SUPVancocoaEventParser()
@property (nonatomic) HTMLParser *parser;
@end

@implementation SUPVancocoaEventParser

- (id)initWithEventHTMLData:(NSData *)htmlData
{
    self = [super init];
    if (self) {
        NSError *parseError;
        _parser = [[HTMLParser alloc] initWithData:htmlData error:&parseError];
        
        if (parseError) {
            NSLog(@"Failed to parse data");
            self = nil;
        }
    }
    return self;
}

- (NSString *)dateString
{
    HTMLNode *eventDateContainer = [[self.parser body] findChildOfClass:@"event-date"];
    HTMLNode *dateElement = [eventDateContainer findChildTag:@"strong"];
    
    return [dateElement contents];
}

- (NSString *)eventSummary
{
    // Event Summary isn't clearly marked, so just look for then next non-empty
    // paragraph after the date.
    
    HTMLNode *eventDateContainer = [[self.parser body] findChildOfClass:@"event-date"];
    
    HTMLNode *nextElement = [eventDateContainer nextSibling];
    while (![[nextElement className] isEqualToString:@"speakers-list"]) {
        if ([[nextElement tagName] isEqualToString:@"p"]) {
            
            if ([nextElement contents]) {
                return [nextElement contents];
            }
        }
        nextElement = [nextElement nextSibling];
    }
    return nil;
}

- (NSArray *)talks
{
    HTMLNode *speakerListElement = [[self.parser body] findChildOfClass:@"speakers-list"];
    
    NSArray *speakerElements = [speakerListElement findChildTags:@"li"];

    __block NSMutableArray *results = [[NSMutableArray alloc] init];
    
    [speakerElements enumerateObjectsUsingBlock:^(HTMLNode *speakerNode, NSUInteger idx, BOOL *stop) {
        SUPSpeaker *speaker = [SUPSpeaker new];
        
        speaker.name = [[speakerNode findChildTag:@"a"] contents];
        speaker.talkTitle = [[speakerNode findChildTag:@"em"] contents];
        
        [results addObject:speaker];
    }];
    
    return results;
}

- (NSArray *)attendees
{
    HTMLNode *rsvpContainer = [[self.parser body] findChildOfClass:@"rsvps"];
    
    __block NSMutableArray *results = [[NSMutableArray alloc] init];
    
    [[rsvpContainer findChildTags:@"p"] enumerateObjectsUsingBlock:^(HTMLNode*attendeeNode, NSUInteger idx, BOOL *stop) {
        SUPAttendee *attendee = [SUPAttendee new];
        
        HTMLNode *imgTag = [attendeeNode findChildTag:@"img"];
        
        attendee.name = [[[imgTag nextSibling] rawContents] trim];
        
        NSString *gravatarUrlString = [imgTag getAttributeNamed:@"src"];
        
        attendee.gravatar = [NSURL URLWithString:gravatarUrlString];
        
        [results addObject:attendee];
    }];
    
    return results;
}


- (SUPFormContainer *)rsvpFormDetails
{
    NSArray *forms = [[self.parser body] findChildTags:@"form"];
    
    __block SUPFormContainer *formContainer = [[SUPFormContainer alloc] init];
    
    [forms enumerateObjectsUsingBlock:^(HTMLNode *form, NSUInteger idx, BOOL *stop) {
        if ([[form getAttributeNamed:@"name"] isEqualToString:@"email-submission"]) {
            formContainer.actionURL = [NSURL URLWithString:[form getAttributeNamed:@"action"]];

            NSArray *inputElements = [form findChildTags:@"input"];
            
            [inputElements enumerateObjectsUsingBlock:^(HTMLNode *inputNode, NSUInteger idx, BOOL *stop) {
                NSString *attributeName = [inputNode getAttributeNamed:@"name"];
                NSString *attributeValue = [inputNode getAttributeNamed:@"value"];
                
                if (!attributeValue) {
                    attributeValue = @"";
                }
                
                if (attributeName) {
                    [formContainer.fields setObject:attributeValue forKey:attributeName];
                }
            }];
        }
    }];
    
    return formContainer;
}

@end
