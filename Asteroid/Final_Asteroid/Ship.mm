//
//  Ship.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import "Ship.h"
#import "Bullet.h"
#import "GameLayer.h"

#import "CCAnimationHelper.h"


//@interface Ship (PrivateMethods)
//-(id) initWithShipImage;
//@end

static NSDictionary*t;
static NSMutableArray*listship ;
static float acc = 1.0f;
static BOOL hyper_thrust;
//static BOOL hyper_thrust;
#define float constants = 6.0f;


@implementation Ship

@synthesize accuracy;

static CCAnimate* animate;

+(NSMutableArray*)listship{
    return listship;
}
+(void)setListship:(NSMutableArray*)newValue{
    listship = newValue;
}

+(BOOL)hyper_thrust{
    return hyper_thrust;
}
+(void)setHyper_thrust:(BOOL)newValue{
    hyper_thrust = newValue;
}

+(id) ship
{
    if(listship==Nil){
        listship = [[NSMutableArray alloc] init];
    }
    [Ship setHyper_thrust:NO];
	return [[[self alloc] initWithShipImage] autorelease];
    
}

-(void) Explosion{
    //if(animate==Nil){
    NSString* shipAnimName = @"explosion_alpha";
    CCAnimation* anim = [CCAnimation animationWithFrame:shipAnimName frameCount:24 delay:.1f];
    animate = [CCAnimate actionWithAnimation:anim];
    //}
    [batch runAction:animate];
}

-(id) initWithShipImage
{
	if ((self = [super initWithSpriteFrameName:@"Ship1.png"]))
	{
        next = .0f;
        self.live = YES;
        CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]
									  spriteFrameByName:@"explosion_alpha1.png"];
		batch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];
        self.scale = .6f;
        [self addChild:batch];
        [self scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)delta
{
	//[[GameLayer sharedGameLayer] shootBulletFromShip:self];
//    if (self.live==NO) {
//        next+=delta;
//        next
//    }
    if(self->hyper_thrust){
        
    }
    if(!self.live && ![Ship hyper_thrust]){
        if (nextframe < 24)
            ++nextframe;
        next+=delta;
        NSString*img = [NSString stringWithFormat:@"explosion_alpha%i.png",nextframe];
        [self setDisplayFrame:[CCAnimation ImagewithFile:img]];
        if(next>2.4f){
            self.live = YES;
            nextframe = 0;
            next = 0;
        }
    }
    else{
    if([Ship hyper_thrust]){
        next+=delta;
        if(next>.3f){
            acc+= acc<8.0f?.1f:0.0f;
            next =.0f;
        }
    }
    else
        acc = 1.0f;
//        next+=delta;
//        if(next>.1f)
//        {
//            self.live = NO;
//            hyper_thrust = NO;
//            next = .0f;
//        }
//        self.hyper_thrust = NO;
//        self.live = NO;
    self.position = CGPointMake(self.position.x+self.velocity.x*4*acc, self.position.y + self.velocity.y*4*acc);
    self.velocity = ccpMult(self.velocity,.99f);
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
        pos.y = screenSize.height - 100;
	[super setPosition:pos];
}


- (CGPoint)accuracy {
    return accuracy;
}

- (void)setAccuracy:(CGPoint)newValue {
    accuracy = newValue;
}

-(BOOL) isCollisions:(CGRect)rect{
	BOOL isColliding = NO;
	if (self.visible)
    {
        if (CGRectIntersectsRect([self boundingBox], rect))
        {
            isColliding = YES;
            //self.live = NO;
            //self.visible = NO;
        }
	}
	
	return isColliding;
}

-(void) Gothit{
    //[self Explosion];
    self.live = NO;
    //self.visible = NO;
}

- (CCAnimate *)animate {
    return animate;
}

- (void)setAnimate:(CCAnimate *)newValue {
    [animate autorelease];
    animate = newValue;
}

-(void)dealloc{
    CCLOG(@"DDD");
    [super dealloc];
}
@end
