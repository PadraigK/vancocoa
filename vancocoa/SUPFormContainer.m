//
//  SUPFormContainer.m
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/29/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import "SUPFormContainer.h"

@implementation SUPFormContainer

- (id)init
{
    self = [super init];
    if (self) {
        _fields = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
