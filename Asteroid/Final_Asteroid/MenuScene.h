//
//  MenuScene.h
//  Essentials
//
//  Created by Steffen Itterheim on 16.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuScene : CCLayer 
{
    BOOL isStartGame;
    BOOL ischange;
    int opacityes;
    int dec_or_inc;
}

+(id) scene;

@end
