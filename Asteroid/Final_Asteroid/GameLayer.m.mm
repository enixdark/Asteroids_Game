//
//  GameLayer.m
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import "GameLayer.h"
#import "Ship.h"
#import "Bullet.h"
#import "ParallaxBackground.h"
#import "InputLayer.h"
#import "BulletCache.h"
#import "Meteor.h"
#import "CMeteors.h"
#import "RocketCache.h"
#import "RandomItem.h"
#import "CMenu.h";
#import "Global.h"
#import "LightingCache.h"
#import "Lightning.h"
#import "Laser.h"
#import "EnemyCache.h"
@interface GameLayer (PrivateMethods)
-(void) countBullets:(ccTime)delta;
@end



@implementation GameLayer

static GameLayer* sharedGameLayer;
+(GameLayer*) sharedGameLayer
{
	NSAssert(sharedGameLayer != nil, @"GameScene instance not yet initialized!");
	return sharedGameLayer;
}

+(id) scene
{
//	CCScene *scene = [CCScene node];
//	GameLayer *layer = [GameLayer node];
//	[scene addChild: layer];
//    InputLayer* inputLayer = [InputLayer node];
//    [scene addChild:inputLayer z:1 tag:GameSceneLayerTagInput];
//    return self;
    return [[[self alloc] init] autorelease] ;
}

static CGRect screenRect;
-(CGRect) screenRect
{
	return screenRect;
}

-(id) init
{
	if ((self = [super init]))
	{
		sharedGameLayer = self;
        
		glClearColor(1, 1, 1, 1);
        CGSize screenSize = [CCDirector sharedDirector].winSize;
		if (CGRectIsEmpty(screenRect))
		{
			screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
		}
        [Global instanceinit];
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		//[frameCache addSpriteFramesWithFile:@"asteroiditem.plist"];
        [frameCache addSpriteFramesWithFile:@"all.plist"];
        //[frameCache addSpriteFramesWithFile:@"background.plist"];
        //[frameCache addSpriteFramesWithFile:@"meteors.plist"];
        CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"all.pvr.ccz"];
		
		spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
        
		
		
        ParallaxBackground* background = [ParallaxBackground node];
		[self addChild:background z:-1];
        
        Ship* ship = [Ship ship];
		ship.position = CGPointMake(CCRANDOM_0_1()*100, screenSize.height / 2);
		ship.tag = GameSceneNodeTagShip;
        [[Ship listship] addObject:ship];
		[self addChild:ship z:10];
        //[ship unscheduleUpdate];
		for(int i = 1 ; i < 5 ; i++){
        Ship* s = [[Ship alloc] initWithShipImage];
        
		s.position = CGPointMake(80, screenSize.height / 2);
		s.tag = GameSceneNodeTagShip + i ;
        s.visible = NO;
        s.live = NO;
        [[Ship listship] addObject:s];
		}
		CMeteors*meteors = [[[CMeteors alloc] initwithCollection:10] autorelease];
        meteors.tag = GameSceneNodeTagMeteor;
//        for (Meteor*m in meteors.meteors) {
//            [spriteBatch addChild:m z:1];
//        }
        [self addChild:meteors];
        Lightning*l = [[Lightning alloc] initWithStrikePoint:CGPointZero strikePoint2:CGPointZero duration:1.0f fadeDuration:1.0f textureName:@"lightning.png"];
        l.anchorPoint = ccp(0,0);
		[self addChild:l z:999 tag:GameSceneNodeTagLightingCache];
		[self schedule:@selector(strikeLight) interval:1.0f ];
        
        
        
        
        

		BulletCache* bulletCache = [BulletCache node];
		[self addChild:bulletCache z:1 tag:GameSceneNodeTagBulletCache];
        RocketCache* rocketCache = [RocketCache node];
        [self addChild:rocketCache z:1 tag:GameSceneNodeTagRocketCache];
        RandomItem*ritem = [RandomItem RandoItem];
        [self addChild:ritem z:1];
        CMenu *menu = [CMenu Menu];
        [self addChild:menu];
//        for (int i =0; i < 100; i++) {
//            Bullet*b= [Bullet bullet];
//            b.position = ccp(i,200);
//            [self addChild:b];
//        }
        
        
//        Laser*lasers = [ Laser laser];
//        [self addChild:lasers];
        
        EnemyCache*enemy = [EnemyCache cache];
        [self addChild:enemy z:1 tag:9000];
        CCScene *scene = [CCScene node];
        InputLayer* inputLayer = [[[InputLayer alloc] init] autorelease];
        [self addChild:inputLayer z:1 tag:GameSceneLayerTagInput];
        [self scheduleUpdate];
        
	}
	return self;
}

-(void) strikeLight
{
//	Lightning *l = (Lightning *)[self getChildByTag:GameSceneNodeTagLightingCache];
//	CGSize screen = [[CCDirector sharedDirector] winSize];
//	//random position
    Ship* ship = [GameLayer sharedGameLayer].defaultShip;
//	l.strikePoint = ship.position;
//	l.strikePoint2 = ccp(50 + ship.position.x  + 100*CCRANDOM_0_1(),ship.position.y );
//	l.strikePoint3 = ccp(50+ ship.position.x + 100*CCRANDOM_0_1(),ship.position.y);
//	l.color = ccc3(CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255);
//	
//	l.displacement = 250 + CCRANDOM_0_1() * 100;
//	l.minDisplacement = 3 + CCRANDOM_0_1() * 10;
//	l.lighteningWidth = 3.0f;
//	l.split = YES;
//	l.opacity = 255;
//	[l strikeRandom];
    Lightning *l = (Lightning *)[self getChildByTag:GameSceneNodeTagLightingCache];
	CGSize screen = [[CCDirector sharedDirector] winSize];
	//random position
    
    l.strikeSource = ship.position;
    l.strikeSplitDestination = ccp(ship.position.x + 50 + 100*CCRANDOM_0_1(),ship.position.y-50 );
    l.strikeDestination = ccp(ship.position.x + 50 + 100*CCRANDOM_0_1(),ship.position.y+50 );
    //random color
    l.color = ccc3(CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255, 255);
    l.opacity = 50;
    //random style
    l.displacement = 100 + CCRANDOM_0_1() * 50;
    l.minDisplacement = 1 + CCRANDOM_0_1() * 5;
    l.lightningWidth = 4.0f;
    l.split = YES;
    [l strikeRandom];
}
//-(void)draw{
//    [[self lightingCache] draw];
//    [super draw];
//}

-(void) update:(ccTime)delta
{
    //NSLog(@"H");
}


-(void) dealloc
{
    CCLOG(@"ss");
    CCLOG(@"ss");
    CCLOG(@"ss");
    CCLOG(@"ss");
    CCLOG(@"ss");
    CCLOG(@"ss");
    CCLOG(@"ss");
    CCLOG(@"ss");
    CCLOG(@"ss");
	sharedGameLayer = nil;
    
//    for (id i  in spriteBatch.children) {
//        [spriteBatch removeChild:i];
//    }
//    for (id i  in self.children) {
//        [self removeChild:i];
//    }
    //[sharedGameLayer release];
    //[[self cmeteors] release];
//    [[self rocketCache] release];
//    [[self bulletCache] release];
//    [[self lightCache] release];
//    [[self defaultShip] release];
    //[self release];
    [super dealloc];
}

-(CCSpriteBatchNode*) bulletSpriteBatch
{
	CCNode* node = [self getChildByTag:GameSceneNodeTagBulletSpriteBatch];
	NSAssert([node isKindOfClass:[CCSpriteBatchNode class]], @"not a CCSpriteBatchNode");
	return (CCSpriteBatchNode*)node;
}

-(LightingCache*) lightingCache
{
	LightingCache* node = [self getChildByTag:GameSceneNodeTagLightingCache];
	NSAssert([node isKindOfClass:[LightingCache class]], @"not a Lighting!");
	return (LightingCache*)node;
}

-(Ship*) defaultShip
{
	CCNode* node = [self getChildByTag:GameSceneNodeTagShip];
	NSAssert([node isKindOfClass:[Ship class]], @"not a Ship!");
	return (Ship*)node;
}

-(BulletCache*) bulletCache
{
    CCNode* node = [self getChildByTag:GameSceneNodeTagBulletCache];
    NSAssert([node isKindOfClass:[BulletCache class]], @"not a BulletCache");
    return (BulletCache*)node;
}
-(RocketCache*) rocketCache
{
    CCNode* node = [self getChildByTag:GameSceneNodeTagRocketCache];
    NSAssert([node isKindOfClass:[RocketCache class]], @"not a RocketCache");
    return (RocketCache*)node;
}
-(CMeteors*) cmeteors
{
    CCNode* node = [self getChildByTag:GameSceneNodeTagMeteor];
    NSAssert([node isKindOfClass:[CMeteors class]], @"not a CMeteors");
    return (CMeteors*)node;
}


@end
