//
//  ParallaxBackground.m
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import "ParallaxBackground.h"


static BOOL fixFlickeringLine = YES;
static CGSize size;

@implementation ParallaxBackground

-(id) init
{
	if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        size = screenSize;
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"all.pvr.ccz"];
		
		spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch];
		
        NSString* frameName = [NSString stringWithFormat:@"nebula_blue1.png"];
        CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
        //sprite.rotation = 90;
        sprite.anchorPoint = CGPointMake(0,0);
        sprite.position = CGPointMake(0,0);
        [spriteBatch addChild:sprite z:1];
        //NSLog(@"%i , %i",screenSize.width,screenSize.height);
        NSString* frameName2 = [NSString stringWithFormat:@"debris2_blue.png"];
        CCSprite* sprite2 = [CCSprite spriteWithSpriteFrameName:frameName2];
        //sprite2.rotation = 90;
        sprite2.anchorPoint = CGPointMake(0,0);
        //sprite2.scale = .6f;
        sprite2.tag = 13;
        sprite2.position = CGPointMake(0,0);
        //[spriteBatch addChild:sprite2 z:2];
        NSString* frameName3 = [NSString stringWithFormat:@"debris3_blue.png"];

        CCSprite* sprite3 = [CCSprite spriteWithSpriteFrameName:frameName3];
        //sprite3.rotation = 90;
        sprite3.anchorPoint = CGPointMake(0,0);
        sprite3.tag = 14;
        sprite3.position = CGPointMake(0,screenSize.height);
        [spriteBatch addChild:sprite3 z:2];
        [sprite2 runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.05f
                                                                                position:ccp(0,- 1)]]];
        [sprite3 runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.05f
                                                                              position:ccp(0,- 1)]]];
        
        [self scheduleUpdate];
        
		
//		for (int i = 0; i < numStripes; i++)
//		{
//			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
//			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
//			sprite.anchorPoint = CGPointMake(0, 0.5f);
//			sprite.position = CGPointMake(0, screenSize.height / 2);
//			[spriteBatch addChild:sprite z:i];
//		}
//		
//		for (int i = 0; i < numStripes; i++)
//		{
//			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
//			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
//			
//			// Position the new sprite one screen width to the right
//			sprite.anchorPoint = CGPointMake(0, 0.5f);
//			
//			if (fixFlickeringLine)
//			{
//				sprite.position = CGPointMake(screenSize.width - 1, screenSize.height / 2);
//			}
//			else 
//			{
//				sprite.position = CGPointMake(screenSize.width, screenSize.height / 2);
//			}
//			
//			sprite.flipX = YES;
//			// Add the sprite using the same tag offset by numStripes
//			[spriteBatch addChild:sprite z:i tag:i + numStripes];
//		}
//		
//		speedFactors = [NSMutableArray arrayWithCapacity:numStripes];
//		[speedFactors addObject:[NSNumber numberWithFloat:0.3f]];
//		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
//		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
//		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
//		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
//		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
//		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
//		NSAssert(speedFactors.count == (NSUInteger)numStripes, @"speedFactors count does not match numStripes!");
//		
//		scrollSpeed = 1.0f;
//		[self scheduleUpdate];
//		
//		BOOL showRepeatTextureTest = NO;
//		if (showRepeatTextureTest)
//		{
//			CGRect repeatRect = CGRectMake(0, 0, 8000, 8000);
//			CCSprite* sprite = [CCSprite spriteWithFile:@"iTunesArtwork" rect:repeatRect];
//			sprite.position = CGPointMake(200, 200);
//			sprite.scale = 0.1f;
//			sprite.rotation = 30.0f;
//			ccTexParams params = 
//			{
//				GL_LINEAR, // texture minifying function
//				GL_LINEAR, // texture magnification function
//				GL_REPEAT, // how texture should wrap along X coordinates
//				GL_REPEAT  // how texture should wrap along Y coordinates
//			};
//			[sprite.texture setTexParameters:&params];
//			[self addChild:sprite];
//			
//		}
        
        //[spriteBatch scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)delta
{
//    CCNode * p = [spriteBatch getChildByTag:13];
//    CCSprite * layout = (CCSprite*)p;
//    layout.position = CGPointMake(0,layout.position.y + .01f);
    for (CCSprite* sprite in spriteBatch.children)
    {
        if(sprite.tag==13 || sprite.tag==14){
            
            
            if(sprite.position.y <= -size.height){
                sprite.position = ccp(0,size.height);
            }
            

//            sprite.position = sprite.position.y > -sprite.position.y ? ccp(0,sprite.position.y - 1) :
//            ccp(0,size.height);
            //sprite.position = ccp(0,sprite.position.y - 1);
//            [sprite runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(0,sprite.position.y - 1)],[CCMoveBy actionWithDuration:0.5 position:ccp(0,sprite.position.y - 1)], nil]]];
        }
        
        
        
    }
//	for (CCSprite* sprite in spriteBatch.children)
//	{
//		NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
//		
//		CGPoint pos = sprite.position;
//		pos.x -= (scrollSpeed * factor.floatValue) * (delta * 50);
//		
//		CGSize screenSize = [CCDirector sharedDirector].winSize;
//		if (pos.x < -screenSize.width)
//		{
//			if (fixFlickeringLine)
//			{
//				pos.x += (screenSize.width * 2) - 2;
//			}
//			else
//			{
//				pos.x += screenSize.width * 2;
//			}
//		}
//		
//		sprite.position = pos;
//	}
}
-(void)dealloc{
    
}
@end
