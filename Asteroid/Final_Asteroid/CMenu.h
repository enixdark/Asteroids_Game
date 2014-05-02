//
//  CMenu.h
//  test1
//
//  Created by Cqshinn on 3/8/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Global.h"
@interface CMenu : CCNode {
    NSMutableArray*listrocket;
    NSMutableArray*listlife;
    CCSprite*thunder;
    CCSprite*tran_am;
}

+(id) Menu;



- (NSMutableArray *)listrocket;

- (void)setListrocket:(NSMutableArray *)newValue;

- (NSMutableArray *)listlife;

- (void)setListlife:(NSMutableArray *)newValue;

- (CCSprite *)thunder;

- (void)setThunder:(CCSprite *)newValue;

- (CCSprite *)tran_am;

- (void)setTran_am:(CCSprite *)newValue;

@end
