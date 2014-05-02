//
//  GameOver_Scene.m
//  test1
//
//  Created by Cqshinn on 3/23/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "GameOver_Scene.h"


@implementation GameOver_Scene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOver_Scene *layer = [GameOver_Scene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		NSString* frameName = [NSString stringWithFormat:@"nebula_blue1.png"];
        CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
        //sprite.rotation = 90;
        sprite.anchorPoint = CGPointMake(0,0);
        sprite.position = CGPointMake(0,0);
        [self addChild:sprite z:1];
		
    }
	return self;
}

@end
