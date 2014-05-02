//
//  CCMenuItemTextField.m
//  test1
//
//  Created by Cqshinn on 3/23/14.
//  Copyright (c) 2014 Cqshinn. All rights reserved.
//

#import "CCMenuItemTextField.h"

@implementation CCMenuItemTextField

@synthesize
textField = textField_,
label = label_,
paddingLeft = paddingLeft_;

- (id)init
{
    CCSprite *normalSprite = [CCSprite spriteWithFile:@"text_field_background.png"];
    CCSprite *selectedSprite = [CCSprite spriteWithFile:@"text_field_background.png"];
    CCSprite *disabledSprite = [CCSprite spriteWithFile:@"text_field_background.png"];
    
    return [self initWithNormalSprite:normalSprite selectedSprite:selectedSprite disabledSprite:disabledSprite];
}

- (id)initWithNormalSprite:(CCNode<CCRGBAProtocol> *)normalSprite
            selectedSprite:(CCNode<CCRGBAProtocol> *)selectedSprite
            disabledSprite:(CCNode<CCRGBAProtocol> *)disabledSprite
{
    self = [super initWithNormalSprite:normalSprite
                        selectedSprite:selectedSprite
                        disabledSprite:disabledSprite
                                target:self
                              selector:@selector(selected)];
    
    if (self) {
        paddingLeft_ = 3.0;
        
        textField_ = [[UITextField alloc] init];
        [textField_ setTextColor:[UIColor blackColor]];
        [textField_ setFont:[UIFont systemFontOfSize:18]];
        
        label_ = [[CCLabelTTF node] retain];
        [label_ setAnchorPoint:ccp(0,0.5)];
        [label_ setFontSize:18];
        [label_ setVisible:NO];
        [label_ setColor:ccBLACK];
        [self addChild:label_];
    }
    
    return self;
}

- (void)dealloc
{
    [label_ release];
    [textField_ release];
    [super dealloc];
}

// --------------------------------
// Public
// --------------------------------

- (void)selected
{
    [super selected];
    
    [label_ setVisible:NO];
    
    CGAffineTransform transform = [self nodeToWorldTransform];
    float textFieldHeight = textField_.font.lineHeight;
    float width = self.contentSize.width;
    float height = self.contentSize.height;
    float left = transform.tx + paddingLeft_;
    float top = 480 - transform.ty - height + (height - textFieldHeight) / 2;
    
    [textField_ setFrame:CGRectMake(left, top, width, height)];
    [[[[CCDirector sharedDirector] view] window] addSubview:textField_];
    [textField_ becomeFirstResponder];
    [textField_ setDelegate:self];
}

- (void)unselected
{
    [super unselected];
    
    [label_ setVisible:YES];
    [label_ setPosition:ccp(paddingLeft_, self.contentSize.height/2)];
    
    NSString *text = textField_.text ? textField_.text : @"";
    [label_ setString:text];
    
    [textField_ resignFirstResponder];
    [textField_ removeFromSuperview];
}

- (NSString*)text
{
    return [label_ string];
}

- (void)setText:(NSString*)text
{
    [label_ setString:text];
    [textField_ setText:text];
}

// --------------------------------
// UITextFieldDelegate
// --------------------------------

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [self unselected];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField*)textField {
    [self unselected];
}

- (void)setFontSize:(CGFloat)size
{
    [label_ setFontSize:size];
    [textField_ setFont:[UIFont systemFontOfSize:size]];
}

// --------------------------------
// CCNode
// --------------------------------

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
    [self unselected];
}

@end
