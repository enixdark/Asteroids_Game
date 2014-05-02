//
//  BulletCache.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BulletCache : CCNode 
{
    CCSpriteBatchNode* batch;
	NSUInteger nextInactiveBullet;
    
}



-(void) shootBulletFrom:(CGPoint)startPosition
			   velocity:(CGPoint)velocity 
			  frameName:(NSString*)frameName
            isPlayerBullet:(BOOL)playerBullet;


-(BOOL) isPlayerBulletCollidingWithRect:(CGRect)rect;
-(BOOL) isEnemyBulletCollidingWithRect:(CGRect)rect;

@end
