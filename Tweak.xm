#import <BulletinBoard/BBBulletin.h>

#define GET_BOOL(key, default) ([prefs objectForKey:key] ? ((NSNumber *)[prefs objectForKey:key]).boolValue : default)

BOOL highlightsOnly;
BOOL hideInNC;
NSArray *highlights;

static NSString *const kHBCVEnabledKey = @"Enabled";
static NSString *const kHBCVHighlightsKey = @"Highlights";
static NSString *const kHBCVHideInNCKey = @"HideInNC";

void HBCVLoadPrefs();

BOOL HBCVShouldCancelBulletin(BBBulletin *bulletin) {
	if (![bulletin.sectionID isEqualToString:@"com.apple.MobileSMS"] || !bulletin.context[@"AssistantContext"]) {
		return NO;
	}

	/*
	 ios 5/6:	AssistantContext.properties.msgRecipients
	 ios 7:		AssistantContext.msgRecipients
	*/

	// can't use `?:` - clang segfaults!
	NSDictionary *context = bulletin.context[@"AssistantContext"][@"properties"] ? bulletin.context[@"AssistantContext"][@"properties"] : bulletin.context[@"AssistantContext"];

	if (!highlights) {
		HBCVLoadPrefs();
	}

	if (highlightsOnly && context[@"msgRecipients"] && ((NSArray *)context[@"msgRecipients"]).count > 1) {
		NSString *message = bulletin.message.lowercaseString;

		for (NSString *highlight in highlights) {
			if ([message rangeOfString:highlight].location != NSNotFound) {
				return NO;
			}
		}

		return YES;
	}

	return NO;
}

#pragma mark - Hooks

%hook SBBulletinBannerController

- (void)observer:(id)observer addBulletin:(BBBulletin *)bulletin forFeed:(NSUInteger)feed {
	if (!HBCVShouldCancelBulletin(bulletin)) {
		%orig;
	}
}

%end

%hook SBLockScreenNotificationListController //5/6:SBAwayBulletinListController

- (void)observer:(id)observer addBulletin:(BBBulletin *)bulletin forFeed:(NSUInteger)feed {
	if (!HBCVShouldCancelBulletin(bulletin)) {
		%orig;
	}
}

%end

%hook SBBulletinViewController
//5/6:SBBulletinListController

- (void)addBulletin:(BBBulletin *)bulletin inSection:(id)section {
//5/6: - (void)observer:(id)observer addBulletin:(BBBulletin *)bulletin forFeed:(NSUInteger)feed {
	if (HBCVShouldCancelBulletin(bulletin) && !hideInNC) {
		%orig;
	}
}

%end

#pragma mark - Preferences

void HBCVLoadPrefs() {
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/ws.hbang.converse.plist"];

	[highlights release];

	highlightsOnly = GET_BOOL(kHBCVEnabledKey, YES);
	highlights = prefs[kHBCVHighlightsKey] ? [[((NSString *)prefs[kHBCVHighlightsKey]).lowercaseString componentsSeparatedByString:@" "] retain] : [@[] retain];
	hideInNC = GET_BOOL(kHBCVHideInNCKey, YES);
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)HBCVLoadPrefs, CFSTR("ws.hbang.groupquiet/ReloadPrefs"), NULL, kNilOptions);
}
