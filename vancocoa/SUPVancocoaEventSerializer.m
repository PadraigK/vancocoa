//
//  SUPVancocoaEventSerializer.m
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import "SUPVancocoaEventSerializer.h"
#import "SUPVancocoaEventParser.h"

@implementation SUPVancocoaEventSerializer

+ (instancetype)serializer {
    SUPVancocoaEventSerializer *serializer = [[self alloc] init];
    
    return serializer;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/html", @"text/html", nil];
    
    return self;
}

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSHTTPURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    return [[SUPVancocoaEventParser alloc] initWithEventHTMLData:data];
}

@end
