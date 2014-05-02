//
//  RocketCache.m
//  test1
//
//  Created by Cqshinn on 3/6/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "RocketCache.h"
#include "Bullet.h"

@implementation RocketCache
-(id) init
{
    if ((self = [super init]))
    {
        CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
									  spriteFrameByName:@"shot3.png"];
		
        batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
        [self addChild:batch];
        Bullet* bullet = [Bullet rocket];
        bullet.visible = NO;
        bullet.tag = 1111;
        [batch addChild:bullet];
        
    }
    
    return self;
}

-(void) shootBulletFrom:(CGPoint)startPosition
			   velocity:(CGPoint)velocity
               rotation:(float)rotation
                 target:(AObject*)target
			  frameName:(NSString*)frameName
         isPlayerBullet:(BOOL)playerBullet


{
    
    CCNode* bullets = [batch getChildByTag:1111];
    Bullet * bullet = (Bullet*)bullets;
    bullet.live = YES;
    [bullet shootBulletFrom:startPosition velocity:velocity rotation:rotation target:target frameName:frameName isPlayerBullet:YES];
    
    
}

-(BOOL) isPlayerBulletCollidingWithRect:(CGRect)rect
{
	return [self isBulletCollidingWithRect:rect usePlayerBullets:YES];
}

-(BOOL) isBulletCollidingWithRect:(CGRect)rect usePlayerBullets:(bool)usePlayerBullets
{
	BOOL isColliding = NO;
	
	for (Bullet* bullet in batch.children)
	{
		if (bullet.visible && usePlayerBullets == bullet.isPlayerBullet)
		{
			if (CGRectIntersectsRect([bullet boundingBox], rect))
			{
				isColliding = YES;
                bullet.visible = NO;
                bullet.live = NO;
                break;
			}
		}
	}
	
	return isColliding;
}



@end
