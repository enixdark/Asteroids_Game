//
//  CCTextField.m
//  test1
//
//  Created by Cqshinn on 3/23/14.
//  Copyright (c) 2014 Cqshinn. All rights reserved.
//

#import "CCTextField.h"

@implementation CCTextField

@synthesize text;

-(id) init
{
    if(self = [super init]){
        self.isTouchEnabled = YES;
    }
    return self;
}

-(BOOL)ccTouchesBegan:(NSSet  *)touches withEvent:(UIEvent *)event {
    [self specifyStartLevel];
    return YES;
}

-(void)specifyStartLevel {
    text = [[UITextField alloc] initWithFrame:CGRectMake(60, 165, 200, 90)];
    [text setDelegate:self];
    [text setText:@""];
    [text setTextColor: [UIColor colorWithRed:255 green:255 blue:255 alpha:1.0]];
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:text];
    [text becomeFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [text resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing: (UITextField *)textField {
    if(textField == text) {
        [text endEditing:YES];
        [text removeFromSuperview];
        NSString *result = text.text;
        NSLog([NSString stringWithFormat:@"entered: %@", result]);
    } else {
        NSLog(@"textField did not match text");
    }
}
-(void) dealloc
{
    [super dealloc];
}
@end
