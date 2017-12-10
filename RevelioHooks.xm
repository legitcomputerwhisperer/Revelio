//
//  RevelioHooks.xm
//
//  Revelio | BETA version | Build 1.0.0b | 12/10/2017
//
//  Copyright © 2015-2017 TheComputerWhisperer
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#define PREFSplist @"/var/mobile/Library/Preferences/com.thecomputerwhisperer.Revelio.plist"

static UIView *sbIconView;
static BOOL inEditMode;

inline BOOL RevelioPrefBool(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PREFSplist] valueForKey:key] boolValue];
}

inline double RevelioPrefDuration(NSString *key) {
       return [[[NSDictionary dictionaryWithContentsOfFile:PREFSplist] valueForKey:key] doubleValue];
}

@interface SBIconContentView : UIView
- (void)fadeInAnimation;
@end

@interface SBLockToAppStatusBarAnimator : NSObject
- (void)animateStatusBarFromLockToHome;
@end

@interface SBIconController : NSObject
+ (id)sharedInstance;
- (BOOL)isEditing;
- (UIView *)SBIconContentView;
- (void)closeFolderAnimated:(BOOL)arg1 withCompletion:(id)arg2;
@end

// Static unlock fade animation
static void performFadeIn() 
{
	UIWindow *sbWin = [UIApplication sharedApplication].keyWindow;

	sbWin.alpha = 0.f;
	
	[UIView animateWithDuration:RevelioPrefDuration(@"kSpeedLS")
						  delay:0 
	                    options:UIViewAnimationOptionAllowUserInteraction // This option allows touch during animations
	                 animations:^{sbWin.alpha = 1.0f;}
	                 completion:nil];
}

// Static folder close fade animation
static void performFolderFadeIn() 
{
	UIWindow *sbWin = [UIApplication sharedApplication].keyWindow;

	sbWin.alpha = 0.f;
	
	[UIView animateWithDuration:RevelioPrefDuration(@"kSpeedFolder")
						  delay:0 
	                    options:UIViewAnimationOptionAllowUserInteraction // This option allows touch during animations
	                 animations:^{sbWin.alpha = 1.0f;}
	                 completion:nil];
}

// SpringBoard hook used for app exit animation
%hook SBIconContentView

- (void)layoutSubviews 
{
	%orig;
	
	// Check if icons are in "jiggle" editing mode
    if ([[%c(SBIconController) sharedInstance] isEditing]) {
       inEditMode = YES;
    } else {
       inEditMode = NO;
    }
    
    // Enable the animation ONLY when tweak is enabled, trigger is enabled AND not in jiggle edit mode   
    if (RevelioPrefBool(@"kEnabled") && RevelioPrefBool(@"kFromApp") && !inEditMode) {
        sbIconView = (UIView *)self;
        sbIconView.alpha = 0.f;
    
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                   				   selector:@selector(fadeInAnimation)
                                   userInfo:nil
                                    repeats:NO];
    }
}

// New method added to SBIconContentView which performs the animation
%new
- (void)fadeInAnimation
{
	[UIView animateWithDuration:RevelioPrefDuration(@"kSpeedApp") 
						  delay:0
	                    options:UIViewAnimationOptionAllowUserInteraction // This option allows touch during animations
	                 animations:^{sbIconView.alpha = 1.0f;}
	                 completion:nil];
}

%end

// SpringBoard hook used for unlock animation trigger
%hook SBLockToAppStatusBarAnimator

- (void)animateStatusBarFromLockToHome
{
    %orig;

	// Check if Revelio user prefs plist exists and if it doesn't then dynamically instantiate it with defaults
    BOOL hasPrefs = [[NSFileManager defaultManager] fileExistsAtPath:PREFSplist];
	if (!hasPrefs) {
		NSMutableDictionary *createPrefsDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@YES, @"kEnabled", @YES, @"kFromLS", @YES, @"kFromApp", @YES, @"kFromFolder", @5, @"kSpeedLS", @5, @"kSpeedApp", @5, @"kSpeedFolder", nil];
		[createPrefsDict writeToFile:PREFSplist atomically:YES];
		[createPrefsDict release];
	}
	
	// Check if tweak and trigger are enabled & perform animation if they are
    if (RevelioPrefBool(@"kEnabled") && RevelioPrefBool(@"kFromLS")) {
        performFadeIn();
    }
}
%end

// SpringBoard hook used for folder close animation
%hook SBIconController
- (void)closeFolderAnimated:(BOOL)arg1 withCompletion:(id)arg2
{
    %orig;

	// Check if icons are in "jiggle" editing mode
	if (self.isEditing) {
		inEditMode = YES;
    } else {
        inEditMode = NO;
    }

	// Enable the animation ONLY when tweak is enabled, trigger is enabled AND not in jiggle edit mode 
    if (RevelioPrefBool(@"kEnabled") && RevelioPrefBool(@"kFromFolder") && !inEditMode) {
		performFolderFadeIn();
    }
}
%end
