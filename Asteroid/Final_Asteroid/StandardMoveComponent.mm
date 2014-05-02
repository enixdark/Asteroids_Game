//
//  StandardMoveComponent.m
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

#import "StandardMoveComponent.h"
#import "GameLayer.h"
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

int q = 0;
int rotate = 0;
int randomrotate = 0;
@implementation StandardMoveComponent



-(id) init
{
	if ((self = [super init]))
	{
		velocity = [self veclocity_from_angle:rotate];
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	if (self.parent.visible)
	{
		CGSize screenSize = [CCDirector sharedDirector].winSize;
        if(rotate!=randomrotate){
            rotate++;
            velocity = [self veclocity_from_angle:rotate];
            self.parent.rotation = [self getr_angle:velocity];
        }
        else
            rotate = randomrotate;
        self.parent.position = ccpAdd(self.parent.position, velocity);
        if(q++%300==0){
            randomrotate = CCRANDOM_0_1()*360;
        }
	}
}

-(int) getr_angle:(CGPoint)velocitys{
    float x = velocitys.x;
    float y = velocitys.y;
    float t = x*x + y*y;
    float ang = sqrt(t);
    float m = radiansToDegrees(asinf(velocity.x/ang));
    if (velocitys.x > 0 && velocitys.y > 0){
        return (m - 90);
    }
    else if( velocitys.x < 0 && velocitys.y > 0){
        return  m  - 90;
    }
    return  ( 90 - m);
}

-(CGPoint) veclocity_from_angle:(int)angle{
    CGPoint vel = CGPointMake(cos(degreesToRadians(angle)),-sin(degreesToRadians(angle))) ;
    return vel;
}

@end
