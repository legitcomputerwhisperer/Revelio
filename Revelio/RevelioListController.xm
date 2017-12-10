//
//  RevelioListController.xm
//
//  Revelio | BETA version | Build 1.0.0b | 12/10/2017
//
//  Copyright © 2015-2017 TheComputerWhisperer
//

#include "RevelioListController.h"
#import <Preferences/NSTask.h>

static NSString *getEnabled;
static NSString *getUnlock;
static NSString *getApps;
static NSString *getFolder;
static NSString *getVersion;

inline BOOL RevelioPrefBool(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PREFSplist] valueForKey:key] boolValue];
}

@implementation RevelioListController {
	UILabel* titleLabel;
	UILabel* subTitleLabel;
	UILabel* copyrightLabel;
}

- (instancetype)init 
{
	if (self = [super init]) {
		[self setTitle:@"Revelio"];
	}
	
	return self;
}

- (id)specifiers
{
	if (!_specifiers) {
		NSMutableArray* specifiers = [NSMutableArray array];
		PSSpecifier *spec;
		
		spec = [PSSpecifier emptyGroupSpecifier];
		[spec setProperty:@"EMPTY_SPACE_ONE" forKey:@"id"];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier	preferenceSpecifierNamed:[NSString stringWithFormat:@"%@", [self getEnabled]]
											  target:self
												 set:@selector(setRevelioEnabled:specifier:)
												 get:@selector(readPreferenceValue:)
											  detail:nil
												cell:PSSwitchCell
												edit:nil];
		[spec setProperty:@"DYNAMIC_INDICATOR" forKey:@"id"];
		[spec setProperty:@YES forKey:@"default"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio" forKey:@"defaults"];
		[spec setProperty:@"kEnabled" forKey:@"key"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio/ReloadPrefs" forKey:@"PostNotification"];
		[spec setProperty:@YES forKey:@"hasIcon"];
		[spec setProperty:[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:[NSString stringWithFormat:@"%@", [self getEnabled]] ofType:@"png"]] forKey:@"iconImage"];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier emptyGroupSpecifier];
		[spec setProperty:@"EMPTY_SPACE_TWO" forKey:@"id"];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier	preferenceSpecifierNamed:@"Unlock Animation"
											  target:self
												 set:@selector(setLSEnabled:specifier:)
												 get:@selector(readPreferenceValue:)
											  detail:nil
												cell:PSSwitchCell
												edit:nil];
		[spec setProperty:@"DI_UNLOCKED" forKey:@"id"];
		[spec setProperty:@YES forKey:@"default"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio" forKey:@"defaults"];
		[spec setProperty:@"kFromLS" forKey:@"key"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio/ReloadPrefs" forKey:@"PostNotification"];
		[spec setProperty:@YES forKey:@"hasIcon"];
		[spec setProperty:[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:[NSString stringWithFormat:@"%@", [self getUnlock]] ofType:@"png"]] forKey:@"iconImage"];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier preferenceSpecifierNamed:@"kSpeedLS"
											  target:self
												 set:@selector(setPreferenceValue:specifier:)
												 get:@selector(readPreferenceValue:)
											  detail:nil
												cell:PSSliderCell
												edit:nil];
		[spec setProperty:[NSNumber numberWithBool:RevelioPrefBool(@"kFromLS")] forKey:@"enabled"];
		[spec setProperty:[NSNumber numberWithInt:1] forKey:@"min"];
		[spec setProperty:[NSNumber numberWithInt:15] forKey:@"max"];
		[spec setProperty:[NSNumber numberWithInt:5] forKey:@"default"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio" forKey:@"defaults"];
		[spec setProperty:@YES forKey:@"showValue"];
		[spec setProperty:@"kSpeedLS" forKey:@"key"];
		[spec setProperty:@YES forKey:@"isContinuous"];
		[spec setProperty:[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:@"timeSliderImage" ofType:@"png"]] forKey:@"leftImage"];
		[spec setProperty:@"LSSPEED_SLIDER" forKey:@"id"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio/ReloadPrefs" forKey:@"PostNotification"];
		[specifiers addObject:spec];

		spec = [PSSpecifier emptyGroupSpecifier];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier	preferenceSpecifierNamed:@"App Animation"
											  target:self
												 set:@selector(setAppsEnabled:specifier:)
												 get:@selector(readPreferenceValue:)
											  detail:nil
												cell:PSSwitchCell
												edit:nil];
		[spec setProperty:@"DI_APPS" forKey:@"id"];
		[spec setProperty:@YES forKey:@"default"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio" forKey:@"defaults"];
		[spec setProperty:@"kFromApp" forKey:@"key"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio/ReloadPrefs" forKey:@"PostNotification"];
		[spec setProperty:@YES forKey:@"hasIcon"];
		[spec setProperty:[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:[NSString stringWithFormat:@"%@", [self getApps]] ofType:@"png"]] forKey:@"iconImage"];
		[specifiers addObject:spec];
	
		spec = [PSSpecifier preferenceSpecifierNamed:@"kSpeedApp"
											 target:self
											    set:@selector(setPreferenceValue:specifier:)
											    get:@selector(readPreferenceValue:)
										     detail:nil
											   cell:PSSliderCell
											   edit:nil];
		[spec setProperty:[NSNumber numberWithBool:RevelioPrefBool(@"kFromApp")] forKey:@"enabled"];
		[spec setProperty:[NSNumber numberWithInt:1] forKey:@"min"];
		[spec setProperty:[NSNumber numberWithInt:15] forKey:@"max"];
		[spec setProperty:[NSNumber numberWithInt:5] forKey:@"default"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio" forKey:@"defaults"];
		[spec setProperty:@YES forKey:@"showValue"];
		[spec setProperty:@"kSpeedApp" forKey:@"key"];
		[spec setProperty:@YES forKey:@"isContinuous"];
		[spec setProperty:[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:@"timeSliderImage" ofType:@"png"]] forKey:@"leftImage"];
		[spec setProperty:@"APPSPEED_SLIDER" forKey:@"id"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio/ReloadPrefs" forKey:@"PostNotification"];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier emptyGroupSpecifier];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier	preferenceSpecifierNamed:@"Close Folder Animation"
											  target:self
												 set:@selector(setFolderEnabled:specifier:)
												 get:@selector(readPreferenceValue:)
											  detail:nil
												cell:PSSwitchCell
												edit:nil];
		[spec setProperty:@"DI_FOLDER" forKey:@"id"];
		[spec setProperty:@YES forKey:@"default"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio" forKey:@"defaults"];
		[spec setProperty:@"kFromFolder" forKey:@"key"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio/ReloadPrefs" forKey:@"PostNotification"];
		[spec setProperty:@YES forKey:@"hasIcon"];
		[spec setProperty:[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:[NSString stringWithFormat:@"%@", [self getFolder]] ofType:@"png"]] forKey:@"iconImage"];
		[specifiers addObject:spec];

		spec = [PSSpecifier preferenceSpecifierNamed:@"kSpeedFolder"
											 target:self
											    set:@selector(setPreferenceValue:specifier:)
											    get:@selector(readPreferenceValue:)
										     detail:nil
											   cell:PSSliderCell
											   edit:nil];
		[spec setProperty:[NSNumber numberWithBool:RevelioPrefBool(@"kFromFolder")] forKey:@"enabled"];
		[spec setProperty:[NSNumber numberWithInt:1] forKey:@"min"];
		[spec setProperty:[NSNumber numberWithInt:15] forKey:@"max"];
		[spec setProperty:[NSNumber numberWithInt:5] forKey:@"default"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio" forKey:@"defaults"];
		[spec setProperty:@YES forKey:@"showValue"];
		[spec setProperty:@"kSpeedFolder" forKey:@"key"];
		[spec setProperty:@YES forKey:@"isContinuous"];
		[spec setProperty:[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:@"timeSliderImage" ofType:@"png"]] forKey:@"leftImage"];
		[spec setProperty:@"FOLDERSPEED_SLIDER" forKey:@"id"];
		[spec setProperty:@"com.thecomputerwhisperer.Revelio/ReloadPrefs" forKey:@"PostNotification"];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier emptyGroupSpecifier];
		[spec setProperty:@"EMPTY_SPACE_FIVE" forKey:@"id"];
		[specifiers addObject:spec];
		
		spec = [PSSpecifier preferenceSpecifierNamed:@"Respring"
											  target:self
												 set:NULL
												 get:NULL
											  detail:nil
												cell:PSGiantCell
												edit:nil];
		spec->action = @selector(respringPrompt);
		[spec setProperty:@"Respring" forKey:@"label"];
		[spec setProperty:%c(RevelioRespringButton) forKey:@"cellClass"];
		[spec setProperty:@"RESPRING_BUTTON" forKey:@"id"];
		[specifiers addObject:spec];
		
		_specifiers = [specifiers copy];
	}
	
	return _specifiers;
}

- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled 
{
    UITableViewCell *cell = [self tableView:self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    if (cell) {
        cell.userInteractionEnabled = enabled;
        cell.textLabel.enabled = enabled;
        cell.detailTextLabel.enabled = enabled;
        
        if ([cell isKindOfClass:[PSControlTableCell class]]) {
            PSControlTableCell *controlCell = (PSControlTableCell *)cell;
            if (controlCell.control) {
                controlCell.control.enabled = enabled;
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated 
{
	[super viewWillDisappear:animated];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = (UITableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
	[cell.textLabel setAdjustsFontSizeToFitWidth:YES];

	return cell;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier 
{
	@autoreleasepool {
		NSString *key = [specifier propertyForKey:@"key"];
		NSMutableDictionary *revelioSettingsDict = [NSMutableDictionary dictionary];
		[revelioSettingsDict addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:PREFSplist]];
		[revelioSettingsDict setObject:value forKey:key];
		[revelioSettingsDict writeToFile:PREFSplist atomically:YES];
		
		if ([key isEqualToString:@"kFromLS"]) {
			BOOL enableCell = [value boolValue];
			[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] enabled:enableCell];
		}
		
		if ([key isEqualToString:@"kFromApp"]) {
			BOOL enableCell = [value boolValue];
			[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2] enabled:enableCell];
		}
		
		if ([key isEqualToString:@"kFromFolder"]) {
			BOOL enableCell = [value boolValue];
			[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3] enabled:enableCell];
		}
		
		CFStringRef notificationValue = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
		if (notificationValue) {
			CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationValue, NULL, NULL, YES);
		}
	}
}

- (id)readPreferenceValue:(PSSpecifier *)specifier 
{
	@autoreleasepool {
		NSString *key = [specifier propertyForKey:@"key"];
		id defaultValue = [specifier propertyForKey:@"default"];
		NSDictionary *revelioSettingsDict = [NSDictionary dictionaryWithContentsOfFile:PREFSplist];
		id plistValue = [revelioSettingsDict objectForKey:key];
		if (!plistValue) plistValue = defaultValue;
	
		if ([key isEqualToString:@"kFromLS"]) {
			BOOL enableCell = plistValue && [plistValue boolValue];
			[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] enabled:enableCell];
		}
		
		if ([key isEqualToString:@"kFromApp"]) {
			BOOL enableCell = plistValue && [plistValue boolValue];
			[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2] enabled:enableCell];
		}
		
		if ([key isEqualToString:@"kFromFolder"]) {
			BOOL enableCell = plistValue && [plistValue boolValue];
			[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3] enabled:enableCell];
		}
		
		return plistValue;
	}
}


- (void)respringPrompt
{
	UIAlertController* respringAlert = [UIAlertController alertControllerWithTitle:@"Ready to Respring?"
																		   message:@"A respring may be required to apply your settings. Would you like to respring now?"
																	preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* confirmRespring = [UIAlertAction actionWithTitle:@"Respring"
															  style:UIAlertActionStyleDestructive
															handler:^(UIAlertAction * respringAction){
																[UIView animateWithDuration:4.0 animations:^{
																	[UIApplication sharedApplication].keyWindow.alpha = 0.f;
																}completion:nil];
																
																dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 4.1 * NSEC_PER_SEC);
																dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
																	#pragma clang diagnostic push
																	#pragma clang diagnostic ignored "-Wdeprecated-declarations"
																	system("killall -9 SpringBoard backboardd");
																	#pragma clang diagnostic pop
																});
															}];
	
	[respringAlert addAction:confirmRespring];
	
	UIAlertAction* cancelRespring = [UIAlertAction actionWithTitle:@"Cancel"
															 style:UIAlertActionStyleDefault
														   handler:^(UIAlertAction * cancelAction){
															   [respringAlert dismissViewControllerAnimated:YES completion:nil];
														   }];
	
	[respringAlert addAction:cancelRespring];
	
	[self presentViewController:respringAlert animated:YES completion:nil];
}

- (void)setRevelioEnabled:(id)value specifier:(id)specifier
{
	[self setPreferenceValue:value specifier:specifier];
	[self reloadSpecifiers];
}

- (void)setLSEnabled:(id)value specifier:(id)specifier
{
	if ([value boolValue] == YES) {
		PSSpecifier *lsSliderSpec = [self specifierForID:@"LSSPEED_SLIDER"];
		[lsSliderSpec setProperty:@YES forKey:@"enabled"];
	}
	
	if ([value boolValue] == NO) {
		PSSpecifier *lsSliderSpec = [self specifierForID:@"LSSPEED_SLIDER"];
		[lsSliderSpec setProperty:@NO forKey:@"enabled"];
	}
	
	[self setPreferenceValue:value specifier:specifier];
	[self reloadSpecifiers];
}

- (void)setAppsEnabled:(id)value specifier:(id)specifier
{
	if ([value boolValue] == YES) {
		PSSpecifier *appSliderSpec = [self specifierForID:@"APPSPEED_SLIDER"];
		[appSliderSpec setProperty:@YES forKey:@"enabled"];
	}
	
	if ([value boolValue] == NO) {
		PSSpecifier *appSliderSpec = [self specifierForID:@"APPSPEED_SLIDER"];
		[appSliderSpec setProperty:@NO forKey:@"enabled"];
	}
	
	[self setPreferenceValue:value specifier:specifier];
	[self reloadSpecifiers];
}

- (void)setFolderEnabled:(id)value specifier:(id)specifier
{
	if ([value boolValue] == YES) {
		PSSpecifier *folderSliderSpec = [self specifierForID:@"FOLDERSPEED_SLIDER"];
		[folderSliderSpec setProperty:@YES forKey:@"enabled"];
	}
	
	if ([value boolValue] == NO) {
		PSSpecifier *folderSliderSpec = [self specifierForID:@"FOLDERSPEED_SLIDER"];
		[folderSliderSpec setProperty:@NO forKey:@"enabled"];
	}
	
	[self setPreferenceValue:value specifier:specifier];
	[self reloadSpecifiers];
}

- (NSString *)getEnabled
{
	BOOL isMainOn = [[[[NSDictionary alloc] initWithContentsOfFile:PREFSplist] valueForKey:@"kEnabled"] boolValue];
	
	if(isMainOn) {
		getEnabled = @"Enabled";
	} else {
		getEnabled = @"Disabled";
	}
	
	return getEnabled;
}

- (NSString *)getUnlock
{
    BOOL isFromLSOn = [[[[NSDictionary alloc] initWithContentsOfFile:PREFSplist] valueForKey:@"kFromLS"] boolValue];
	
	if(isFromLSOn) {
		getUnlock = @"Enabled";
	} else {
		getUnlock = @"Disabled";
	}
	
	return getUnlock;
}

- (NSString *)getApps
{
    BOOL isFromAppsOn = [[[[NSDictionary alloc] initWithContentsOfFile:PREFSplist] valueForKey:@"kFromApp"] boolValue];
	
	if(isFromAppsOn) {
		getApps = @"Enabled";
	} else {
		getApps = @"Disabled";
	}
	
	return getApps;
}

- (NSString *)getFolder
{
    BOOL isFromFolderOn = [[[[NSDictionary alloc] initWithContentsOfFile:PREFSplist] valueForKey:@"kFromFolder"] boolValue];
	
	if(isFromFolderOn) {
		getFolder = @"Enabled";
	} else {
		getFolder = @"Disabled";
	}
	
	return getFolder;
}

- (void)TitleHeader
{
	@autoreleasepool {
		UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 120)];
		int width = [[UIScreen mainScreen] bounds].size.width;
		CGRect frame = CGRectMake(0, 20, width, 60);
		CGRect botFrame = CGRectMake(0, 55, width, 60);
		titleLabel = [[UILabel alloc] initWithFrame:frame];
		[titleLabel setNumberOfLines:1];
		titleLabel.font = [UIFont fontWithName:@"Papyrus" size:48];
		[titleLabel setText:@"Revelio"];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		titleLabel.textColor = [UIColor blackColor];
		titleLabel.textAlignment = NSTextAlignmentCenter;
		titleLabel.alpha = 1.0f;
		
		subTitleLabel = [[UILabel alloc] initWithFrame:botFrame];
		[subTitleLabel setNumberOfLines:1];
		subTitleLabel.font = [UIFont fontWithName:@"Papyrus" size:20];
		[subTitleLabel setText:@"Get Faded!"];
		[subTitleLabel setBackgroundColor:[UIColor clearColor]];
		subTitleLabel.textColor = [UIColor redColor];
		subTitleLabel.textAlignment = NSTextAlignmentCenter;
		subTitleLabel.alpha = 0.f;
		
		CGRect copyrightFrame = CGRectMake(0, 100, width, 16);
		
		copyrightLabel = [[UILabel alloc] initWithFrame:copyrightFrame];
		[copyrightLabel setNumberOfLines:1];
		copyrightLabel.font = [UIFont systemFontOfSize:12];
		[copyrightLabel setText:@"© 2017 TheComputerWhisperer"];
		[copyrightLabel setBackgroundColor:[UIColor clearColor]];
		copyrightLabel.textColor = [UIColor grayColor];
		copyrightLabel.textAlignment = NSTextAlignmentCenter;
		copyrightLabel.alpha = 1.0f;
		
		[headerView addSubview:titleLabel];
		[headerView addSubview:subTitleLabel];
		[headerView addSubview:copyrightLabel];
		
		[self.table setTableHeaderView:headerView];
		
		[NSTimer scheduledTimerWithTimeInterval:0.5
										 target:self
									   selector:@selector(increaseAlpha)
									   userInfo:nil
										repeats:NO];
	}
}

- (void) loadView
{
	[super loadView];
	
	UIImage *supportImage = [[UIImage alloc]
							 initWithContentsOfFile:[[self bundle] pathForResource:@"emailDev" ofType:@"png"]];
							 
	UIBarButtonItem *supportButton = [[UIBarButtonItem alloc] initWithImage:supportImage 
																	  style:UIBarButtonItemStylePlain 
																	 target:self 
																	 action:@selector(emailSupport)];
	supportButton.imageInsets = (UIEdgeInsets){2, 0, 0, 0};
	[self.navigationItem setRightBarButtonItem:supportButton];
	
	self.table.alpha = 0.f;
	
	[self TitleHeader];
}

- (void)emailSupport 
{
	NSString *subject = [NSString stringWithFormat:@"SUPPORT: Revelio v: %@", [self getVersion]];
	NSString *body = @"Please include any revelant crash reports or logs, a list of all installed tweaks, and explain your issue below:\n\n1.) When did the issue first begin?\n\n2.) What steps led to the issue?\n\n3.) Does the issue happen every time?\n\n4.) What steps have you taken to try and resolve the issue?";
	NSString *urlString = [NSString stringWithFormat:@"mailto:actualcomputerwhisperer@gmail.com?subject=%@&body=%@", subject, body];
	NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
	
	[[UIApplication sharedApplication] openURL:url];
}


- (void)increaseAlpha
{
	[UIView animateWithDuration:2.0 animations:^{
		self.table.alpha = 1.0f;
	}completion:^(BOOL finished) {
		[UIView animateWithDuration:0.5 animations:^{
			subTitleLabel.alpha = 1.0f;
		}completion:nil];
	}];
}

- (NSString *)getVersion 
{
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath: @"/bin/sh"];
	[task setArguments:[NSArray arrayWithObjects: @"-c", @"dpkg -s com.thecomputerwhisperer.revelio | grep 'Version'", nil]];
	NSPipe *pipe = [NSPipe pipe];
	[task setStandardOutput:pipe];
	[task launch];
	
	NSData *data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
	NSString *version = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	version = [version stringByReplacingOccurrencesOfString:@"Version: " withString:@""];
	version = [version stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	
	return version;
}
@end
