//
//  HighScoreScene.m
//  test1
//
//  Created by Cqshinn on 3/24/14.
//  Copyright 2014 Cqshinn. All rights reserved.
//

#import "HighScoreScene.h"
#import "Rank.h"
#define TAGBACKGROUND 1

@implementation HighScoreScene
@synthesize opacitys;
+(id) scene {
    return [[[self alloc] init] autorelease];
}


-(id) init
{
    if(self = [super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        self.touchEnabled = YES;
        NSString*s = [NSString stringWithFormat:@"highscore.png"];
        CCSprite* sprite = [CCSprite spriteWithFile:s];
        opacitys = 0;
        sprite.opacity = opacitys;
        sprite.rotation = 270;
        sprite.position = ccp(size.width/2,size.height/2);
        [self addChild:sprite z:1 tag:TAGBACKGROUND];
        [self scheduleUpdate];
        Rank*rank = [[Rank alloc] init] ;
        
        [rank insertdata:@"KING" score:10000000];
        
        NSMutableArray *fetchedObjects = [rank fetchdatas];
        
        NSArray *fetche = [fetchedObjects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSNumber* i = [obj1 valueForKey:@"score"];
            NSNumber*j =  [obj2 valueForKey:@"score"];
            return [j compare:i];
            
        }];
        int i = 0;
        for (id employee in fetche) {
            i++;

            NSString*name = [NSString stringWithFormat:@"%@",[employee valueForKey:@"name"]];
            NSString*score = [NSString stringWithFormat:@"%@",[employee valueForKey:@"score"]];
            CCLabelTTF *labelname= [CCLabelTTF labelWithString:name fontName:@"Verdana" fontSize:25];
            [labelname setColor:ccGRAY];
            labelname.position = ccp(30*i + 100, 150);
            labelname.rotation = 270;
            labelname.visible = NO;
            [self addChild:labelname z:10];
            
            CCLabelTTF *labelscore= [CCLabelTTF labelWithString:score fontName:@"Verdana" fontSize:25];
            [labelscore setColor:ccGRAY];
            labelscore.position = ccp(30*i + 100,350);
            labelscore.rotation = 270;
            labelscore.visible = NO;
            [self addChild:labelscore z:10];
            if(i>=5)
                break;
        }
    }
    return self;
}

-(void) update:(ccTime)delta{
    
    opacitys+=2;
    if(opacitys<255){
    CCSprite*t = (CCSprite*)[self getChildByTag:TAGBACKGROUND];
        t.opacity = opacitys;
    }
    else{
        for (id i in self.children) {
            [i setVisible:YES];
        }
        [self unscheduleUpdate];
    }
    
}

-(void) returnGame {
    
//    if (isStartGame == NO) {
//        // Start the game, called by the menu item
//        isStartGame = YES;
//        //[[SimpleAudioEngine sharedEngine] playEffect:SND_BUTTON];
//        //id list = self.children;
//        //[self removeAllChildren];
//        [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
//    }
}



-(void)dealloc{
    [self release];
    [super dealloc];
}
@end
