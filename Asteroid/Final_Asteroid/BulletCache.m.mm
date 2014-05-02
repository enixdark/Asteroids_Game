//
//  BulletCache.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import "BulletCache.h"
#import "Bullet.h"

@implementation BulletCache

-(id) init
{
    if ((self = [super init]))
    {
        CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
									  spriteFrameByName:@"shot1.png"];
		
        batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
        [self addChild:batch];
        
        for (int i = 0; i < 200; i++)
        {
            Bullet* bullet = [Bullet bullet];
            bullet.visible = NO;
            bullet.live = YES;
            [batch addChild:bullet];
            
        }
    }
    
    return self;
}

-(void) shootBulletFrom:(CGPoint)startPosition
			   velocity:(CGPoint)velocity 
			  frameName:(NSString*)frameName
         isPlayerBullet:(BOOL)playerBullet

{
    CCArray* bullets = batch.children;
    CCNode* node = [bullets objectAtIndex:nextInactiveBullet];
    NSAssert([node isKindOfClass:[Bullet class]], @"not a Bullet!");
    
    Bullet* bullet = (Bullet*)node;
    [bullet shootBulletFrom:startPosition velocity:velocity frameName:frameName isPlayerBullet:YES];
    int v = bullets.count;
    nextInactiveBullet++;
    if (nextInactiveBullet >= bullets.count)
    {
        nextInactiveBullet = 0;
    }
}

-(BOOL) isPlayerBulletCollidingWithRect:(CGRect)rect
{
	return [self isBulletCollidingWithRect:rect usePlayerBullets:YES];
}

-(BOOL) isEnemyBulletCollidingWithRect:(CGRect)rect
{
	return [self isBulletCollidingWithRect:rect usePlayerBullets:NO];
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
                
				break;
			}
		}
	}
	
	return isColliding;
}


@end
