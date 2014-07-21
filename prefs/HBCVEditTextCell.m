#import "HBCVEditTextCell.h"

@implementation HBCVEditTextCell

- (id)initWithStyle:(UITableViewCellStyle)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3 {
	HBCVEditTextCell *editTextCell = [super initWithStyle:arg1 reuseIdentifier:arg2 specifier:arg3];
	((UITextField *)[editTextCell textField]).returnKeyType = UIReturnKeyDone;
	return editTextCell;
}

- (BOOL)textFieldShouldReturn:(id)arg1 {
	return YES;
}

@end