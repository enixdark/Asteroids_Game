//
//  CMeteors.h
//  test1
//
//  Created by Cqshinn on 3/4/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AObject.h"
@class BulletCache;
@class Ship;
@interface CMeteors :AObject{
    NSMutableArray * meteors;
    CCSpriteBatchNode* batch;
    CCAnimate *animate;
}

-(id) initwithCollection:(NSInteger*)num;

- (NSMutableArray *)meteors;

- (void)setMeteors:(NSMutableArray *)newValue;
-(AObject*) checkDistanceMeteor:(AObject*) pos;
//-(float) distance:(CGPoint) p
//             sub :(CGPoint) q;
- (CCAnimate *)animate;

- (void)setAnimate:(CCAnimate *)newValue;

@end
