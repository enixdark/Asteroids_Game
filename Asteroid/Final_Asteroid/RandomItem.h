//
//  RandomItem.h
//  test1
//
//  Created by Cqshinn on 3/8/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum {
    ROCKET = 0,
    //LIGHTING,
    SHOT,
    //FLASHBOMB,
    LASER,
    TRANAM,
    LIFE
} TYPEITEM;

@interface RandomItem : CCSprite {
    TYPEITEM item;
    ccTime next;
    NSDictionary* dict;
    CGPoint velocity;
}
//@property (readonly,atomic) NSDictionary*dict;
+(id) RandoItem;
-(void) refreshtime;
-(void) setRandom;
-(TYPEITEM) item;
- (NSDictionary *)dict;

- (void)setDict:(NSDictionary *)newValue;

- (ccTime)next;

- (void)setNext:(ccTime)newValue;

- (CGPoint)velocity;

- (void)setVelocity:(CGPoint)newValue;

@end
