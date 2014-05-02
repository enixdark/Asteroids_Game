//
//  AObject.h
//  test1
//
//  Created by Cqshinn on 3/4/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AObject : CCSprite {
    CGPoint velocity;
    BOOL live;
    float radius;
    float constants;
    ccTime next;
    int nextframe;
    //CCAnimate* animate;

}
@property CGPoint velocity;
@property BOOL live;
@property float radius;
@property float constants;
@property ccTime next;
@property int nextframe;
-(BOOL) isColisions:(CGRect) pos;

//- (ccTime) next;
//-(void) setNext:(ccTime)newVal;
//- (float)radius;
//
//- (void)setRadius:(float)newVal;
//
//- (CGPoint)velocity;
//
//- (void)setVelocity:(CGPoint)newValue;
//
//- (BOOL)live;
//
//- (void)setLive:(BOOL)newValue;
//
//-(int) nextframe;
//
//-(void) setNextframe:(int) newValue;

@end
