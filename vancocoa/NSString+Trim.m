//
//  NSString+Trim.m
//
//  Created by Padraig O Cinneide on 8/23/2013.
//  Copyright (c) 2013 Supertop. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

-(NSString *)trim
{
    NSCharacterSet *whitespaceCharaterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    return [self stringByTrimmingCharactersInSet:whitespaceCharaterSet];
}

@end
