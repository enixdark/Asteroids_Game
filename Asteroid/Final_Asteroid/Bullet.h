//
//  Bullet.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AObject.h"
@class Ship;

typedef enum
{
	NormalShot = 1,
    DoubleShot,
    TripleShot,
	Rocket,
    Lasers,
    Thunder,
    Transam
	
} Missile;

@interface Bullet : AObject
{
	float outsideScreen;
	BOOL isPlayerBullet;
    AObject* target;
    //Missile shot;
}

@property (readwrite, nonatomic) BOOL isPlayerBullet;
@property (readwrite,nonatomic) Missile *shot;
+(id) bullet;
+(id) rocket;
-(void) shootBulletFrom:(CGPoint)startPosition
			   velocity:(CGPoint)vel
			  frameName:(NSString*)frameName
		 isPlayerBullet:(BOOL)playerBullet;

-(void) shootBulletFrom:(CGPoint)startPosition
               velocity:(CGPoint)vel
               rotation:(float)rotation
              frameName:(NSString*)frameName
		 isPlayerBullet:(BOOL)playerBullet;
-(void) shootBulletFrom:(CGPoint)startPosition
               velocity:(CGPoint)vel
               rotation:(float)rotation
                 target:(AObject*)target
              frameName:(NSString*)frameName
		 isPlayerBullet:(BOOL)playerBullet;
+(Missile*) shot;
+(void) setShot:(Missile*) newValue;
+(void) setShotid:(NSInteger*)num;
-(void) setTarget:(AObject*)newValue;
-(AObject*) target;
@end
