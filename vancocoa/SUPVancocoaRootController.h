//
//  SUPVancocoaRootController.h
//  vancocoa
//
//  Created by Padraig O Cinneide on 8/24/2013.
//  Copyright (c) 2013 Padraig Kennedy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUPAttendeesViewController.h"
#import "SUPVancocoaEventParser.h"

@interface SUPVancocoaRootController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic) SUPVancocoaEventParser *parser;

@end
