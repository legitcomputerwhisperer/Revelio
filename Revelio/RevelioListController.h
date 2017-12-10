//
//  RevelioListController.h
//
//  Revelio | BETA version | Build 1.0.0b | 12/10/2017
//
//  Copyright © 2015-2017 TheComputerWhisperer
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSViewController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSControlTableCell.h>
#import <Preferences/PSSliderTableCell.h>

#define PREFSplist @"/var/mobile/Library/Preferences/com.thecomputerwhisperer.Revelio.plist"

@interface RevelioListController : PSListController
- (instancetype)init;
- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled;
- (void)respringPrompt;
- (void)TitleHeader;
- (void)emailSupport;
- (void)increaseAlpha;
@end

@interface RevelioRespringButton : PSTableCell
@end
