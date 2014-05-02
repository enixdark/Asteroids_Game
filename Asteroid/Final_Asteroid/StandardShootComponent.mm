//
//  StandardShootComponent.m
//  ShootEmUp
//
//  Created by Steffen Itterheim on 04.08.10.
//
//  Updated by Andreas Loew on 20.06.11:
//  * retina display
//  * framerate independency
//  * using TexturePacker http://www.texturepacker.com
//
//  Copyright Steffen Itterheim and Andreas Loew 2010-2011. 
//  All rights reserved.
//

#import "StandardShootComponent.h"
#import "BulletCache.h"
#import "GameLayer.h"

#import "SimpleAudioEngine.h"
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

@implementation StandardShootComponent

@synthesize shootFrequency;
@synthesize bulletFrameName;
@synthesize shootSoundFile;

-(id) init
{
	if ((self = [super init]))
	{
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	if (self.parent.visible)
	{
		updateCount += delta;
		
		if (updateCount >= shootFrequency)
		{
			//CCLOG(@"enemy %@ shoots!", self.parent);
			updateCount = 0;
			
			GameLayer* game = [GameLayer sharedGameLayer];
			CGPoint vector = CGPointMake(cos(degreesToRadians(self.parent.rotation)),-sin(degreesToRadians(self.parent.rotation))) ;
            float start_x = self.parent.position.x + 20* vector.x;
            float start_y = self.parent.position.y + 20* vector.y;
            CGPoint shotPos = CGPointMake(start_x, start_y);
            CGPoint velocity = CGPointMake(200*vector.x,200*vector.y);
			[game.bulletCache shootBulletFrom:shotPos velocity:velocity frameName:bulletFrameName isPlayerBullet:NO];

			if (shootSoundFile != nil)
			{
				float pitch = CCRANDOM_0_1() * 0.2f + 0.9f;
				[[SimpleAudioEngine sharedEngine] playEffect:shootSoundFile pitch:pitch pan:0.0f gain:1.0f];
			}
		}
	}
}

@end
