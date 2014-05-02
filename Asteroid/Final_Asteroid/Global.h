//
//  Global.h
//  test1
//
//  Created by Cqshinn on 3/9/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum{
    NEWGAME = 1,
    GAMEOVER,
    PAUSE,
    CONTINUES,
    SAVE,
} GAMESTATE;

@interface Global : NSObject {
//    int rocket_storage;
//    int thunder_energy;
//    int life;
//    int level_shot;
//    int tran_am_energy;
//    GAMESTATE state;
    
}
//@property(readwrite,assign) int rocket_storage;
//@property(readwrite,assign) int thunder_energy;
//@property(readwrite,assign) int life;
//@property(readwrite,assign) int level_shot;
//@property(readwrite,assign) int tran_am_energy;
//@property(readwrite,assign) GAMESTATE state;
+(id) instanceinit;
+ (int)rocket_storage;

+ (void)setRocket_storage:(int)newValue;

+ (float)thunder_energy;

+ (void)setThunder_energy:(float)newValue;

+ (int)life;

+ (void)setLife:(int)newValue;

+ (int)level_shot;

+ (void)setLevel_shot:(int)newValue;

+ (float)tran_am_energy;

+ (void)setTran_am_energy:(float)newValue;

+ (GAMESTATE)state;

+ (void)setState:(GAMESTATE)newValue;

+ (float)score;

+ (void)setScore:(float)newValue;

@end
