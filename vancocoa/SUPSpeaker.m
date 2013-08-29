//
//  SUPSpeaker.m
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import "SUPSpeaker.h"

@implementation SUPSpeaker

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.name, self.talkTitle];
}

@end
