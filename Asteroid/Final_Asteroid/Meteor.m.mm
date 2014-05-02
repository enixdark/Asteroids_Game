//
//  Meteor.m
//  test1
//
//  Created by Cqshinn on 3/3/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "Meteor.h"
#import "SimpleAudioEngine.h"
#import "GameLayer.h"
#import "CCAnimationHelper.h"
@interface Meteor (PrivateMethods)
-(id) initWithMeteorImage;
@end


@implementation Meteor

@synthesize move,child_t,parent_t,collision;
static CCAnimate* animate;
//CGFloat *const constants = 1;


-(void) Explosion{
    if([self animate]==Nil){
    NSString* shipAnimName = @"explosionship";
    CCAnimation* anim = [CCAnimation animationWithFrame:shipAnimName frameCount:72 delay:.1f];
    self.animate = [CCAnimate actionWithAnimation:anim];
    //CCAnimate*u = self.animate;
    }
    //if([[self animate] isDone])
    int m = [self numberOfRunningActions];
    [self runAction:[self animate]];
}

+(id) Meteor
{
	return [[[self alloc] initWithMeteorImage] autorelease] ;
}

-(id) initWithMeteorImage
{
	if ((self = [super initWithSpriteFrameName:@"asteroid_blue.png"]))
	{
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        Ship*ship = [GameLayer sharedGameLayer].defaultShip;
        do{
            self.position = CGPointMake(CCRANDOM_0_1()*screenSize.width,CCRANDOM_0_1()*screenSize.height );
        }while([ship isCollisions:self.boundingBox]);
		self.velocity = CGPointMake(CCRANDOM_0_1()*1,CCRANDOM_0_1()*1);
        //self.move = CGPointMake(CCRANDOM_0_1()*(CCRANDOM_0_1()>.5?1:-1),CCRANDOM_0_1()*(CCRANDOM_0_1()>.5?1:-1));
        self.move = ccp(CCRANDOM_MINUS1_1(), CCRANDOM_MINUS1_1());
        self.visible = YES;
        self.live = YES;
        self.scale = .6f;
        next = 0.0f;
		[self scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)delta
{
	//[[GameLayer sharedGameLayer] shootBulletFromShip:self];
//    if([self collision]){
//        next+=delta;
//        if (next>=1.0f) {
//            [self setCollision: NO];
//        }
//    }
    if(self.visible &&  self.live){
        self.rotation = self.rotation > 360 ? 0 : self.rotation+3;
        self.position = CGPointMake(self.position.x + move.x*self.velocity.x
                                    , self.position.y+ move.y*self.velocity.y);
        
    }
    else if (self.visible && !self.live){
        
        nextframe +=1;
        if (nextframe < 81) {
            NSString*img = [NSString stringWithFormat:@"explosionship%i.png",nextframe];
            [self setDisplayFrame:[CCAnimation ImagewithFile:img]];

        }
        next+=delta;
        if(next>=2.4f){
            self.visible = NO;
            [self stopAction:[self animate]];
            next = 0.0;
            nextframe = 0;
        }
    }
    else if(!self.live && !self.visible && self.parent_t==0){
        next+=delta;
        if(next > 5.5f){
            next = 0.0f;
            
            Ship*ship = [[GameLayer sharedGameLayer] defaultShip];
            CGSize screenSize = [CCDirector sharedDirector].winSize;
            [self setDisplayFrame:[CCAnimation ImagewithFile:@"asteroid_blue.png" ]];

            
            self.visible = YES;
            self.live = YES;
            do{
                self.position = CGPointMake(CCRANDOM_0_1()*screenSize.width,CCRANDOM_0_1()*screenSize.height );
            }while([ship isCollisions:self.boundingBox]);
        }
    }
    else{
        
        [self setDisplayFrame:[CCAnimation ImagewithFile:@"asteroid_blue.png" ]];
    }
    
}

// override setPosition to keep ship within bounds
-(void) setPosition:(CGPoint)pos
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    //	float halfWidth = contentSize_.width * 0.5f;
    //	float halfHeight = contentSize_.height * 0.5f;
    //	int posX = pos.x;
    //    int screenx = screenSize.width;
    //    int posY = pos.y;
    //    int screeny = screenSize.height;
    //    pos = CGPointMake(posX %screenx, posY % screeny);
    if(pos.x > screenSize.width)
        pos.x = 0;
    if(pos.x < 0)
        pos.x = screenSize.width;
    if(pos.y > screenSize.height - 100)
        pos.y = 0;
    if(pos.y < 0)
        pos.y = screenSize.height -100;
	[super setPosition:pos];
}


//- (CGPoint)move {
//    return move;
//}
//
//- (void)setMove:(CGPoint)newValue {
//    move = newValue;
//}

-(void) gotHit
{
	
    //self.visible = NO;
    if(self.live==YES){
        //[self Explosion];
        self.live = NO;
    }
//    CCParticleSystem* system;
//    system = [CCParticleSystemQuad particleWithFile:@"Flash.plist"];
//    //[[SimpleAudioEngine sharedEngine] playEffect:@"explo2.wav" pitch:1.0f pan:0.0f gain:1.0f];
//    system.positionType = kCCPositionTypeFree;
//    system.blendAdditive = NO;
//    system.duration = .5f;
//    system.autoRemoveOnFinish = YES;
//    system.position = self.position;
    
    // Add the particle effect to the GameScene, for these reasons:
    // - self is a sprite added to a spritebatch and will only allow CCSprite nodes (it crashes if you try)
    // - self is now invisible which might affect rendering of the particle effect
    // - since the particle effects are short lived, there is no harm done by adding them directly to the GameScene
    //[[GameLayer sharedGameLayer] addChild:system];

}

- (CCAnimate *)animate {
    return animate;
}

- (void)setAnimate:(CCAnimate *)newValue {
    [animate autorelease];
    animate = [newValue retain];
}


//- (int)parent_t {
//    return parent_t;
//}
//
//- (void)setParent_t:(int)newValue {
//    parent_t = newValue;
//}
//
//- (int)child_t {
//    return child_t;
//}
//
//- (void)setChild_t:(int)newValue {
//    child_t = newValue;
//}
//
//- (BOOL)collision {
//    return collision;
//}
//
//- (void)setCollision:(BOOL)newValue {
//    collision = newValue;
//}

@end

