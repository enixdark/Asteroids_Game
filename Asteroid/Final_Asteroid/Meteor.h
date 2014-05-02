//
//  Meteor.h
//  test1
//
//  Created by Cqshinn on 3/3/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AObject.h"
@class  GameLayer;
@interface Meteor : AObject {
    int Frame;
    int parent_t;
    int child_t;
    CGPoint move;
    BOOL collision;
}
@property CGPoint move;
@property int child_t;
@property int parent_t;
@property BOOL collision;
+(id) Meteor;
//
//- (CGPoint)move;
//
//- (void)setMove:(CGPoint)newValue;

-(void) gotHit;


//
//- (int)parent_t;
//
//- (void)setParent_t:(int)newValue;
//
//- (int)child_t;
//
//- (void)setChild_t:(int)newValue;
//
//- (BOOL)collision;
//
//- (void)setCollision:(BOOL)newValue;

@end
