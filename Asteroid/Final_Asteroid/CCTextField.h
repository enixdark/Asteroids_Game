//
//  CCTextField.h
//  test1
//
//  Created by Cqshinn on 3/23/14.
//  Copyright (c) 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include "cocos2d.h"

@interface CCTextField : CCLayer<UITextFieldDelegate>{
    UITextField*text;
}
@property (nonatomic) UITextField*text;
-(void)specificStartLevel;
@end
