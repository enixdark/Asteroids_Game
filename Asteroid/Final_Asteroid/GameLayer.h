//
//  GameLayer.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{
	GameSceneLayerTagGame = 1,
	GameSceneLayerTagInput,
	
} GameSceneLayerTags;

typedef enum
{
	GameSceneNodeTagBullet = 1,
	GameSceneNodeTagBulletSpriteBatch,
	GameSceneNodeTagBulletCache,
    GameSceneNodeTagRocketCache,
    GameSceneNodeTagLightingCache,
    GameSceneNodeTagMeteor = 100,
    GameSceneNodeTagShip=10000,
	
} GameSceneNodeTags;


@class Ship;
@class BulletCache;
@class RocketCache;
@class Meteor;
@class CMeteors;
@class CMenu;
@class LightingCache;
@class Laser;
@interface GameLayer : CCLayer 
{
    CCSpriteBatchNode*spriteBatch;
}

@property (readonly) Ship* defaultShip;
@property (readonly) BulletCache* bulletCache;
@property (readonly) RocketCache* rocketCache;
@property (readonly) CMeteors* cmeteors;
@property (readonly) CGRect screenRect;
@property (readonly) LightingCache* lightCache;

//@property Meteor * meteor;
+(id) scene;
+(GameLayer*) sharedGameLayer;
-(CCSpriteBatchNode*) bulletSpriteBatch;


@end
