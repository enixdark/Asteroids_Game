

#import "InputLayer.h"
#import "SimpleAudioEngine.h"
#import "Bullet.h"
#include "Global.h"
#import <OpenGLES/ES3/gl.h>
#import "GameOver_Scene.h"
#import "Rank.h"
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )


static CGPoint shadowlist[5] ;
static int nextframe = 0;
@interface InputLayer (PrivateMethods)
-(void) addFireButton;
-(void) addMoveButton;
-(void) addrotateleftButton;
-(void) addrotaterightButton;
-(float) distance:(CGPoint) p
              sub:(CGPoint) q;
-(BOOL) collideA:(AObject*)p
        collideB:(AObject*)q;
-(BOOL) collidePA:(CGPoint)p
        collidePB:(CGPoint)q;
@end

@implementation InputLayer


-(id) init
{
	if ((self = [super init]))
	{
        for (int i = 0 ; i < 5 ; i++) {
            shadowlist[i] = CGPointZero;
        }
        [self addFireButton];
        [self addMoveButton];
        [self addrotaterightButton];
        [self addrotateleftButton];
		[self scheduleUpdate];
        
	}
	return self;
}
-(void) addrotateleftButton{
    float buttonRadius = 30;
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    
	BOOL useSkinnedButton = YES;
	if (useSkinnedButton)
	{
		CCSprite* idle = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
		CCSprite* press = [CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"];
        
		rotateleftButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		rotateleftButton.isHoldable = YES;
		
		SneakyButtonSkinnedBase* skinFireButton = [[SneakyButtonSkinnedBase alloc] init];
        skinFireButton.scale = .3f;
		skinFireButton.button = rotateleftButton;
		skinFireButton.defaultSprite = idle;
		skinFireButton.pressSprite = press;
		skinFireButton.position = CGPointMake(screenSize.width - buttonRadius,buttonRadius);
		[self addChild:skinFireButton];
	}
	else
	{
		moveButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		moveButton.radius = buttonRadius;
		moveButton.position = CGPointMake(screenSize.width - buttonRadius, buttonRadius);
		[self addChild:moveButton];
	}
}
-(void) addMoveButton
{
	float buttonRadius = 30;
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    
	BOOL useSkinnedButton = YES;
	if (useSkinnedButton)
	{
		CCSprite* idle = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
		CCSprite* press = [CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"];
        
		moveButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		moveButton.isHoldable = YES;
		
		SneakyButtonSkinnedBase* skinFireButton = [[SneakyButtonSkinnedBase alloc] init];
        skinFireButton.scale = .4f;
		skinFireButton.button = moveButton;
		skinFireButton.defaultSprite = idle;
		skinFireButton.pressSprite = press;
		skinFireButton.position = CGPointMake(screenSize.width - buttonRadius,screenSize.height - buttonRadius*2);
		[self addChild:skinFireButton];
	}
	else
	{
		moveButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		moveButton.radius = buttonRadius;
		moveButton.position = CGPointMake(screenSize.width - buttonRadius,screenSize.height - buttonRadius*2);
		[self addChild:moveButton];
	}
}
-(void) addrotaterightButton
{
	float buttonRadius = 30;
	CGSize screenSize = [CCDirector sharedDirector].winSize;
    
	BOOL useSkinnedButton = YES;
	if (useSkinnedButton)
	{
		CCSprite* idle = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
		CCSprite* press = [CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"];
        
		rotaterightButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		rotaterightButton.isHoldable = YES;
		
		SneakyButtonSkinnedBase* skinFireButton = [[SneakyButtonSkinnedBase alloc] init];
        skinFireButton.scale = .3f;
		skinFireButton.button = rotaterightButton;
		skinFireButton.defaultSprite = idle;
		skinFireButton.pressSprite = press;
		skinFireButton.position = CGPointMake(screenSize.width - buttonRadius, buttonRadius*2);
		[self addChild:skinFireButton];
	}
	else
	{
		rotaterightButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		rotaterightButton.radius = buttonRadius;
		rotaterightButton.position = CGPointMake(screenSize.width - buttonRadius, buttonRadius*2);
		[self addChild:rotaterightButton];
	}
}


-(void) addFireButton
{
	float buttonRadius = 30;
	CGSize screenSize = [CCDirector sharedDirector].winSize;

	BOOL useSkinnedButton = YES;
	if (useSkinnedButton)
	{
		CCSprite* idle = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
		CCSprite* press = [CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"];

		fireButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		fireButton.isHoldable = YES;
		
		SneakyButtonSkinnedBase* skinFireButton = [[SneakyButtonSkinnedBase alloc] init];
        skinFireButton.scale = .4f;
		skinFireButton.button = fireButton;
		skinFireButton.defaultSprite = idle;
		skinFireButton.pressSprite = press;
		skinFireButton.position = CGPointMake(screenSize.width - buttonRadius*2,screenSize.height - buttonRadius );
		[self addChild:skinFireButton];
	}
	else 
	{
		fireButton = [[SneakyButton alloc] initWithRect:CGRectZero];
		fireButton.radius = buttonRadius;
		fireButton.position = CGPointMake(screenSize.width - buttonRadius*2,screenSize.height - buttonRadius);
		[self addChild:fireButton];
	}
}


-(void) update:(ccTime)delta
{
    
    if([Global state]!=GAMEOVER){

    
	totalTime += delta;
	GameLayer* game = [GameLayer sharedGameLayer];
	Ship* ship = game.defaultShip;
	BulletCache* bulletCache = game.bulletCache;
    RocketCache*rocketCache = game.rocketCache;
	CMeteors*METEORS = game.cmeteors;
    NSMutableArray*list = [Ship listship];
    [Bullet setShotid:2];
    Missile y = [Bullet shot];
    if(nextframe>=5)
        nextframe=0;
    
    shadowlist[nextframe++] = ship.position;
	if (fireButton.active && totalTime > nextShotTime && ship.live)
	{
        [self draw];
        
        float pitch = CCRANDOM_0_1() * 0.2f + 0.9f;
        CGPoint vector = CGPointMake(cos(degreesToRadians(ship.rotation)),-sin(degreesToRadians(ship.rotation))) ;
        float start_x = ship.position.x + 20* vector.x;
        float start_y = ship.position.y + 20* vector.y;
        CGPoint shotPos = CGPointMake(start_x, start_y);
        CGPoint velocity = CGPointMake(200*vector.x,200*vector.y);
        AObject*target = [METEORS checkDistanceMeteor:ship];
        switch (y) {
            case NormalShot:
                nextShotTime = totalTime + 0.5f;
                [bulletCache shootBulletFrom:shotPos velocity:velocity frameName:@"shot1.png" isPlayerBullet:YES];
                [[SimpleAudioEngine sharedEngine] playEffect:@"shoot1.wav" pitch:pitch pan:0.0f gain:1.0f];
                break;
            case Rocket:
                [Global setRocket_storage:[Global rocket_storage] - 1];
                [rocketCache shootBulletFrom:shotPos velocity:velocity rotation:ship.rotation target:target frameName:@"shot3.png" isPlayerBullet:YES];
                [[SimpleAudioEngine sharedEngine] playEffect:@"shoot1.wav" pitch:pitch pan:0.0f gain:1.0f];
                break;
            default:
                break;
        }
		


        
    }
    
    
	if (rotateleftButton.active)
	{
        
		ship.rotation = ship.rotation<0?360:ship.rotation-3;
        
        
	}
    if (rotaterightButton.active)
	{
        
		ship.rotation = ship.rotation>360?0:ship.rotation+3;
        
	}
    if(moveButton.active){
        
        if(ship.live){
            NSString*img;
            if([Ship hyper_thrust]){
                img = @"Ship4.png";
                CCParticleSystem* system;
                system = [CCParticleSystemQuad particleWithFile:@"gear.plist"];
                system.scale = .5f;
                system.autoRemoveOnFinish = YES;
                CGPoint vector = CGPointMake(cos(degreesToRadians(ship.rotation)),-sin(degreesToRadians(ship.rotation))) ;
                float start_x = ship.position.x - 40*vector.x;
                float start_y = ship.position.y - 40*vector.y;
                system.position = CGPointMake(start_x,start_y);
                system.rotation = ship.rotation+90;
                [self addChild:system];
                [Global setTran_am_energy:[Global tran_am_energy] - 0.004f];
                
            }
            else
                img = @"Ship2.png";
            CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [frameCache spriteFrameByName:img];
            [ship setDisplayFrame:frame];
            
            for (int i = 1 ; i < 5; i++) {
                
                Ship*p = [list objectAtIndex:i];
                p.position = shadowlist[i];
                p.visible = YES;
                p.rotation = ship.rotation;
                //p.hyper_thrust = YES;
                p.velocity = ship.velocity;
                [p setDisplayFrame:frame];
                if([game getChildByTag:p.tag]==nil){
                    [game addChild:p z:i];
                }
            }
        }
        //ship.rotation = -90;
        CGPoint vel = CGPointMake(cos(degreesToRadians(ship.rotation)),-sin(degreesToRadians(ship.rotation))) ;
        [ship setVelocity:vel];
        
        
        
//        for (int i = 1 ; i < 8; i++) {
//            Ship*s = [list objectAtIndex:i];
//            if(s.visible==NO){
//            [game removeChild:s cleanup:YES];
//            [s unscheduleUpdate];
//            [s scheduleUpdate];
//            }
//        }

//        int numnext = 0;
//        for (Ship*s in list) {
//            BOOL t = s.visible;
//            BOOL u = s.tag!=ship.tag;
//            CCNode*k = [game getChildByTag:s.tag];
//            BOOL kcheck = k==Nil;
//            if(s.tag!=ship.tag && s.visible == NO && kcheck==YES){
//                //s.hyper_thrust = YES;
//                [s setDisplayFrame:frame];
//                
//                s.visible = YES;
//                s.tag = s.tag;
//                s.position = shadowlist[numnext++];
//                
//                [game addChild:s z:10];
//            }
//            if (s.visible == NO) {
//                
//                [game removeChild:s cleanup:YES];
//                [s unscheduleUpdate];
//                [s scheduleUpdate];
//            }
//        }
//        NSLog(@"Rotate is : %f",ship.rotation);
//        NSLog(@"radian is : %f , %f",degreesToRadians(ship.rotation),M_PI/2);
//        NSLog(@"x is : %f , y is %f",cos(M_PI/2),sin(M_PI/2));
//        NSLog(@"x is : %f , y is %f",cos(degreesToRadians(ship.rotation)),sin(degreesToRadians(ship.rotation)));
        
        
    }
    else
    {
        if(ship.live){
            NSString*img;
            if([Ship hyper_thrust]){
                img = @"Ship3.png";
            }
            else
                img = @"Ship1.png";
            CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [frameCache spriteFrameByName:img];
            [ship setDisplayFrame:frame];
            
            for (int i = 1 ; i < 5; i++) {
                
                Ship*p = [list objectAtIndex:i];
                p.position = shadowlist[i];
                p.visible = YES;
                p.rotation = ship.rotation;
                //p.hyper_thrust = YES;
                p.velocity = ship.velocity;
                [p setDisplayFrame:frame];
                if([game getChildByTag:p.tag]==nil){
                    [game addChild:p z:i];
                }
            }
        }
//        Ship*p = [list objectAtIndex:nextframe];
//        p.position = shadowlist[nextframe];
//        p.visible = YES;
//        p.velocity = ship.velocity;
//        [p setDisplayFrame:frame];
//        if([game getChildByTag:p.tag]==nil)
//            [game addChild:p z:10];
//        if(nextframe>[list count]){
//            Ship*s = [list objectAtIndex:nextframe];
//            [game removeChild:s cleanup:YES];
//            [s unscheduleUpdate];
//            [s scheduleUpdate];
//        
//        }
        
//        for (Ship*s in list) {
//            CCNode*k =[game getChildByTag:s.tag];
//            if(s.tag!=ship.tag){
//                if(s.hyper_thrust && k!=Nil){
//                    s.visible = NO;
//                    [game removeChild:k cleanup:YES];
//                }
//            }
//        }
//        for (int i = 1 ; i < 8; i++) {
//            Ship*p = [list objectAtIndex:i];
//            p.position = shadowlist[i];
//            p.visible = YES;
//            p.hyper_thrust = YES;
//            p.rotation = ship.rotation;
//            p.velocity = ship.velocity;
//            [p setDisplayFrame:frame];
//            if([game getChildByTag:p.tag]==nil)
//                [game addChild:p z:8-i];
//        }
        
//        for (int i = 1 ; i < 8; i++) {
//            Ship*s = [list objectAtIndex:i];
//            if(s.visible==NO){
//                [game removeChild:s cleanup:YES];
//                [s unscheduleUpdate];
//                [s scheduleUpdate];
//            }
//        }
    }
	
	if (fireButton.active == NO)
	{
		nextShotTime = 0;
        
        
	}
//    if(fireButton.active ==YES){
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:3.0 scene:[MenuScene scene] ]];
//        
//        for (id i in [GameLayer sharedGameLayer].children) {
//            if(![i isEqual:ship] && ![i isEqual:rocketCache])
//                [game removeChild:i];
//        }
//        
//
//    }
    }
    else{
        
        for (id i in [GameLayer sharedGameLayer].children) {
            if(![i isEqual:[GameLayer sharedGameLayer].defaultShip] && ![i isEqual:[GameLayer sharedGameLayer].rocketCache])
                [[GameLayer sharedGameLayer] removeChild:i];
        }
        Rank*rank = [[Rank alloc] init] ;
        
        [rank insertdata:@"HHH" score:[Global score]];
        NSArray *fetchedObjects = [rank fetchdatas];
        for (id employee in fetchedObjects) {
            NSLog(@"name: %@", [employee valueForKey:@"name"]);
            NSLog(@"score: %@", [employee valueForKey:@"score"]);
        }
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[GameOver_Scene scene] ]];
        

    }

    
}
//-(void) draw{
//    [super draw];
//    
//    CGSize screenSize = [[CCDirector sharedDirector] winSize];
//    glClearColor(.5f, .5f, .5f, .5f);
//    glLineWidth(6.0f);
//    
//    ccDrawColor4F(0.0f, 1.0f, 0.0f, 1.0f);
//    glColor4ub(0,0,255,255)
//    float radius = 5.0f;
//    float angle = 180;
//    int numSegments = 300;
//    bool drawLineToCenter = YES;
//    ccDrawCircle([[GameLayer sharedGameLayer] defaultShip].position, radius, angle, numSegments, drawLineToCenter);
//    
//    CGPoint p1 = ccp(0,screenSize.height);
//    CGPoint p2 = ccp(screenSize.width,screenSize.height - 100);
//    
//    ccColor4F color;
//    color.a = 1.0;
//    color.r = 0;
//    color.g = 0;
//    color.b = 0;
//    ccDrawSolidRect(p1,p2, color);
//    
//    ccDrawColor4B(0,0,0,0);
//    ccDrawRect(p1,p2);
//    LightingCache* li = [[GameLayer sharedGameLayer] lightCache];
//    [li draw];
//}

-(float) distance:(CGPoint) p
             sub :(CGPoint) q{
    return sqrtf(powf((q.x-p.x),2) + powf((q.y - p.y),2));
    
}
-(BOOL) collideA:(AObject *)p collideB:(AObject *)q{
    return [self distance:p.position sub:q.position] <= p.radius+q.radius;
}

-(void)dealloc{
    CCLOG(@"ddd");
    [self release];
    [super dealloc];
    
    
}
@end
