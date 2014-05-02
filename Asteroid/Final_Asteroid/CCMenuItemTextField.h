//
//  CCMenuItemTextField.h
//  test1
//
//  Created by Cqshinn on 3/23/14.
//  Copyright (c) 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface CCMenuItemTextField : CCMenuItemSprite<UITextFieldDelegate> {
    UITextField     *textField_;
    CCLabelTTF      *label_;
    
    CGFloat         paddingLeft_;
}

@property (readonly, nonatomic) UITextField     *textField;
@property (readonly, nonatomic) CCLabelTTF      *label;
@property (assign, nonatomic)   CGFloat         paddingLeft;

- (void)selected;
- (void)unselected;
- (void)setFontSize:(CGFloat)size;

- (NSString*)text;
- (void)setText:(NSString*)text;

@end
