#import "HBCVListController.h"

@implementation HBCVListController

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:161.0/255.0 green:49.0/255.0 blue:216.0/255.0 alpha:1.0];
}

- (instancetype)init {
	self = [super init];

	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return self;
}

- (void)loadView {
	[super loadView];

	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
		[self table].keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
	}
}

@end
