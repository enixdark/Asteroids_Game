//
//  RocketCache.h
//  test1
//
//  Created by Cqshinn on 3/6/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class AObject;
@interface RocketCache : CCNode {
    CCSpriteBatchNode* batch;
}

-(void) shootBulletFrom:(CGPoint)startPosition
			   velocity:(CGPoint)velocity
               rotation:(float)rotation
                 target:(AObject*)target
			  frameName:(NSString*)frameName
         isPlayerBullet:(BOOL)playerBullet;
-(BOOL) isPlayerBulletCollidingWithRect:(CGRect)rect;
@end
