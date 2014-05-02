//
//  CMeteors.m
//  test1
//
//  Created by Cqshinn on 3/4/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "CMeteors.h"
#import "Meteor.h"
#import "GameLayer.h"
#import "Ship.h"
#import "Bullet.h"
#import "Global.h"
//#import "GameLayer.h"
#define PARENT_METEOR_TAG 1
#define CHILD_METEOR_TAG 100
const float t = 5.0f;
@implementation CMeteors


-(id) initwithCollection:(NSInteger *)num{
    if(self= [self init]){
        //[meteors autorelease];
        next = 0.0;
        CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
									  spriteFrameByName:@"asteroid_blue.png"];
		
        batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
        [self addChild:batch];
        //NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        meteors = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < num ; i++){
            Meteor*m = [Meteor Meteor];
            [meteors addObject:m];
            //default 0 is root parent
            m.parent_t = 0;
            m.child_t = (i+1)*PARENT_METEOR_TAG;
            [batch addChild:m z:1 tag:m.child_t];
        }
//
        for(int i = 0 ; i < (int)num*4; i++){
            Meteor*m = [Meteor Meteor];
            m.scale = 0.25f;
            m.parent_t = (i/4+1)*PARENT_METEOR_TAG;
            m.child_t = (i+1)+CHILD_METEOR_TAG;
            m.visible = NO;
            m.live = NO;
            //[meteors addObject:m];
            [batch addChild:m z:10 tag:1000+i];
        }
        [self scheduleUpdate];
    }
    return self;
}
-(void) active_child_meteors:(int)tag{
    Meteor*parent = (Meteor*)[batch getChildByTag:tag];
    for(Meteor*m in batch.children){
        if(m.parent_t==tag){
            m.visible = YES;
            m.live = YES;
            m.position = ccpAdd(parent.position,ccp(CCRANDOM_MINUS1_1()*1,CCRANDOM_MINUS1_1()*1));
        }
    }
}
-(void) update:(ccTime)delta
{
//    if([[self meteors] count] < 10){
//        next+=delta;
//        if(next>t){
//            
//        }
//    }
    [self checkForShipCollisions];
    [self checkForBulletCollisions];
    [self checkForRocketCollisions];
    //[self checkForMeteorCollisions];

}

- (NSMutableArray *)meteors {
    return meteors;
}

- (void)setMeteors:(NSMutableArray *)newValue {
    [meteors autorelease];
    meteors = [newValue retain];
}

//
//-(float) distance:(CGPoint) p
//             sub :(CGPoint) q{
//    return sqrtf(powf((q.x-p.x),2) + powf((q.y - p.y),2));
//}

-(AObject*) checkDistanceMeteor:(AObject*) pos{
    AObject*p;
    float vt = CGFLOAT_MAX;
    for (Meteor*m in batch.children){
        if(ccpDistance(m.position,pos.position)<vt &&m.visible && m.live){
            vt = ccpDistance(m.position,pos.position);
            p = m;
        }
    }
    return p;
}

//-(BOOL) isColisions:(CGRect) pos{
//    BOOL colision = NO;
//    CGPoint p = pos.origin;
//    for (Meteor*m in batch.children) {
//        CGPoint mpos = m.boundingBox.origin;
//        float vt = (pos.size.width + m.boundingBox.size.width)/2;
//        if(ccpDistance(p,mpos)<vt && m.visible && m.live){
//            colision = YES;
//        }
//    }
//    return colision;
//}
-(void) checkForBulletCollisions
{
    
    for (Meteor* m in batch.children)
	{
        
		if (m.visible==YES && m.parent_t==0)
		{
            
			BulletCache* bulletCache = [GameLayer sharedGameLayer].bulletCache;
			CGRect bbox = m.boundingBox;
			if ([bulletCache isPlayerBulletCollidingWithRect:bbox])
			{
				[m gotHit];
				NSLog(@"Ping");
                [self active_child_meteors:m.child_t];
			}
            
		}
	}
}

// kiem tra su giao nhau giua kich thuoc cua ship voi cac Meteor tren he toa do
-(void) checkForShipCollisions
{
	for (Meteor* m in batch.children)
	{
		if (m.visible && m.live)
		{
            
			Ship*ship = [GameLayer sharedGameLayer].defaultShip;
			CGRect bbox = m.boundingBox;
            
			if ([ship isColisions:bbox] && ship.live)
			{
                [Global setLife:[Global life] - 1 ];
                //[m gotHit];
                [ship Gothit];
			}
		}
	}
}

-(void) checkForRocketCollisions
{
	for (Meteor* m in batch.children)
	{
		if (m.visible && m.live)
		{
            
			RocketCache*r = [GameLayer sharedGameLayer].rocketCache;
			CGRect bbox = m.boundingBox;
            
			if ([r isPlayerBulletCollidingWithRect:bbox])
			{
                
				[m gotHit];
                [Global setScore:[Global score]+5];
                //[self active_child_meteors:m.child_t];

			}
		}
    }
}

-(void) checkForMeteorCollisions
{
	for (Meteor* m in meteors)
	{
        if(m.visible && m.live){
		for (Meteor*mc in meteors) {
//            BOOL t = [mc isColisions:m.boundingBox];
//            float d = ccpDistance(ccp(100,100),ccp(0,200));
//            CGPoint m2 = m.move;
//            CGPoint m1 = ccpMult(m.move,-1);
            if(mc.visible && mc.live && ![m isEqual:mc] && [m isColisions:mc.boundingBox]){
                [mc setMove:ccpMult(mc.move,-1)];
                [m setMove:ccpMult(m.move,-1)];
                
            }
        }
        }
    }
}

-(void)dealloc{
    for (id i in self.children) {
        [self removeChild:i];
    }
    [self release];
    [super dealloc];
}
@end
