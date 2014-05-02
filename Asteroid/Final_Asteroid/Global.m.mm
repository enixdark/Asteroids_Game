//
//  Global.m
//  test1
//
//  Created by Cqshinn on 3/9/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "Global.h"
//#define rocket_storage_max 10;
//#define thunder_energy_max 1.0f;
//#define tran_am_energy_max 1.0f;
//#define level_shot_max 3;
//#define life_max 5;

@implementation Global

static int rocket_storage = 0;
static float thunder_energy = 0.0f;
static int life = 0;
static int level_shot = 0;
static float tran_am_energy =0.0f;
static GAMESTATE state;
static float score;
//@synthesize rocket_storage,thunder_energy,life,level_shot,state,tran_am_energy;

+(id) instanceinit{
    return [[self alloc] init];
}

-(id) init{
    if (self = [super init]) {
        rocket_storage = 0;
        thunder_energy = 0.0f;
        life = 3;
        score = 0.0f;
        level_shot = 1;
        tran_am_energy = 0.0f;
        state = NEWGAME;
        
    }
    return self;
}


+ (int)rocket_storage {
    return  rocket_storage;
}

+ (void)setRocket_storage:(int)newValue {
    if(rocket_storage<=10 && rocket_storage >= 0){
        rocket_storage = rocket_storage<10 ? newValue : 10;
    }
}

+ (float)thunder_energy {
    return thunder_energy;
}

+ (void)setThunder_energy:(float)newValue {
    if(thunder_energy<=1.0f && thunder_energy>=0.0f)
    thunder_energy = newValue;
}

+ (int)life {
    return life;
}

+ (void)setLife:(int)newValue {
    if(life>=0 && life <= 5)
        life = life < 5 ? newValue : 5;
}

+ (int)level_shot {
    return level_shot;
}

+ (void)setLevel_shot:(int)newValue {
    level_shot = newValue;
}

+ (float)tran_am_energy {
    return tran_am_energy;
}

+ (void)setTran_am_energy:(float)newValue {
    if(tran_am_energy<=1.0f && tran_am_energy>=0.0f)
        tran_am_energy = newValue;
}

+ (GAMESTATE)state {
    return state;
}

+ (void)setState:(GAMESTATE)newValue {
    state = newValue;
}

+ (float)score{
    return score;
}

+ (void)setScore:(float)newValue{
    score = newValue;
}



@end
