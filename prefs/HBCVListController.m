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

	// iOS 7, unsure if this supports iOS 6 and below (might just be self.view)
	[self table].keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

@end
