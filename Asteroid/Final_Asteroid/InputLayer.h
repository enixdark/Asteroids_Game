//
//  InputLayer.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by Cqshinn on 23.02.13.
//  Copyright d 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
#import "cocos2d.h"
#import "GameLayer.h"
#import "Ship.h"
#import "CMeteors.h"
#import "Meteor.h"
#import "BulletCache.h"
#import "Global.h";
// SneakyInput headers
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"



@class AObject;
@class Bullet;
@interface InputLayer : CCLayer 
{
	SneakyButton* fireButton;
    SneakyButton* moveButton;
    SneakyButton* rotateleftButton;
    SneakyButton*rotaterightButton;
	SneakyJoystick* joystick;
	ccTime totalTime;
	ccTime nextShotTime;
}

@end
