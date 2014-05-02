#import "Bullet.h"
#import "Ship.h"
#import "GameLayer.h"

#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

@interface Bullet (PrivateMethods)
-(id) initWithShip:(Ship*)ship;
-(id) initWithBulletImage;
@end


@implementation Bullet

@synthesize isPlayerBullet;

static Missile *shot = NormalShot;

+(Missile*) shot{
    return shot;
}

+(void) setShot:(Missile*) newValue{
    shot = newValue;
}

-(void) setTarget:(AObject*)newValue;{
    target = newValue;
}
-(AObject*) target{
    return target;
}

+(void) setShotid:(NSInteger*)num{
    int n = num;
    switch (n) {
        case 1:
            [self setShot:NormalShot];
            break;
        case 2:
            [self setShot:Rocket];
            break;
        default:
            NSAssert(n>6,@"outrange ,is not bullet");
            break;
    }
}
+(id) bullet
{
	return [[self alloc] initWithBulletImage:@"shot1.png" Missiletype:NormalShot];
}
+(id) rocket{
    return [[self alloc] initWithBulletImage:@"shot3.png" Missiletype:Rocket];
}
-(id) initWithBulletImage:(NSString*)img
              Missiletype:(Missile) type
{
	if ((self = [super initWithSpriteFrameName:img]))
	{
        [self setShot:type];
	}
	
	return self;
}

-(void) shootBulletFrom:(CGPoint)startPosition
               velocity:(CGPoint)vel
               rotation:(float)rotation
              frameName:(NSString*)frameName
		 isPlayerBullet:(BOOL)playerBullet{
    [self shootBulletFrom:startPosition velocity:vel rotation:.0f target:Nil frameName:frameName isPlayerBullet:playerBullet];
}


// Re-Uses the bullet
-(void) shootBulletFrom:(CGPoint)startPosition
			   velocity:(CGPoint)vel
			  frameName:(NSString*)frameName
		 isPlayerBullet:(BOOL)playerBullet;
{
    [self shootBulletFrom:startPosition velocity:vel rotation:.0f frameName:frameName isPlayerBullet:playerBullet];
}
-(void) shootBulletFrom:(CGPoint)startPosition
               velocity:(CGPoint)vel
               rotation:(float)rotation
                 target:(AObject*)target
              frameName:(NSString*)frameName
		 isPlayerBullet:(BOOL)playerBullet{
    self.velocity = vel;
    self.position = startPosition;
    self.rotation = rotation;
    self.target = target;
    self.visible = YES;
	self.isPlayerBullet = playerBullet;
	//self.live = YES;
    // change the bullet's texture by setting a different SpriteFrame to be displayed
    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
							spriteFrameByName:frameName];
    [self setDisplayFrame:frame];
    
    [self unscheduleUpdate];
    [self scheduleUpdate];

    
}


-(void) update:(ccTime)delta
{
    // update position of the bullet
    // multiply the velocity by the time since the last update was called
    // this ensures same bullet velocity even if frame rate drops
    CGFloat dis;
    CGFloat x;
    CGFloat y;
    CGFloat degree;
    Missile select = [self shot];
    
    switch (select) {
        case NormalShot:
            
            self.position = ccpAdd(self.position, ccpMult(velocity,.01));
            break;
        case Rocket:
            if(self.live){
            x = self.target.position.x - self.position.x;
            y = self.target.position.y - self.position.y;
            
            dis = ccpDistance(self.target.position,self.position);
            float m = radiansToDegrees(asinf(x/dis));
            if (x > 0 && y > 0){
                self.rotation = (m - 90);
            }
//            else if( x < 0 && y > 0){
//                self.rotation = 180 - m;
//            }
            else if( x < 0 && y > 0){
                self.rotation = m - 90;
            }
            else{
                self.rotation = ( 90 - m);
            }
            
            self.position = ccpAdd(self.position, CGPointMake(x*4/dis,y*4/dis));
            CCParticleSystem* system;
            system = [CCParticleSystemQuad particleWithFile:@"laser.plist"];
            system.autoRemoveOnFinish = YES;
            system.scale =.025f;
            //system.scale =.05f;
            system.duration = .1f;
            system.position = self.position;
            system.rotation = self.rotation;
            [[GameLayer sharedGameLayer] addChild:system];
            }
            break;
        default:
            break;
    }
	
	
	// When the bullet leaves the screen, make it invisible
	if (CGRectIntersectsRect(self.boundingBox, [GameLayer sharedGameLayer].screenRect) == NO)
	{
		//self.live = NO;
        self.visible = NO;
		[self unscheduleUpdate];
	}
}

@end