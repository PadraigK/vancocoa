//
//  SUPVancocoaEventParser.h
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPFormContainer.h"

@interface SUPVancocoaEventParser : NSObject

- (id)initWithEventHTMLData:(NSData *)htmlData;

- (NSString *)dateString;
- (NSString *)eventSummary;
- (NSArray *)talks;
- (NSArray *)attendees;
- (SUPFormContainer *)rsvpFormDetails;

@end
