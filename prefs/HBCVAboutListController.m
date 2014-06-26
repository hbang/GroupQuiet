#import "HBCVAboutListController.h"
#import <UIKit/UITableViewCell+Private.h>

@implementation HBCVAboutListController

#pragma mark - PSListController

- (instancetype)init {
	self = [super init];

	if (self) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"About" target:self] retain];
	}

	return self;
}

@end
