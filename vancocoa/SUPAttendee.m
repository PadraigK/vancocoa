//
//  SUPAttendee.m
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import "SUPAttendee.h"

@implementation SUPAttendee

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.name, self.gravatar];
}

@end
