//
//  MenuScene.m
//  Essentials
//
//  Created by Steffen Itterheim on 16.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "MenuScene.h"

#import "GameLayer.h"
#import "HighScoreScene.h"
#define TAGBACKGROUND 1

@interface MenuScene()
-(void) startGame ;
-(void) quitGame ;
-(void) rankGame ;
@end

@implementation MenuScene
+(id) scene {
    return [[[self alloc] init] autorelease];
}
-(id) init
{
    if(self = [super init]) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        isStartGame = NO;
        ischange = NO;
        dec_or_inc = 1;
        opacityes = 0;
        NSString*s = [NSString stringWithFormat:@"menu.png"];
        CCSprite* sprite = [CCSprite spriteWithFile:s];
        sprite.rotation = 270;
        sprite.position = ccp(size.width/2,size.height/2);
        [self addChild:sprite z:1 tag:TAGBACKGROUND];
        
        
        // Build a basic title
		CCLabelTTF *highscore= [CCLabelTTF labelWithString:@"HighScore" fontName:@"Verdana" fontSize:22];
        [highscore setColor:ccRED];
		        // Build the start menu
        CCLabelTTF *newgame = [CCLabelTTF labelWithString:@"NewGame" fontName:@"Verdana" fontSize:22];
        CCLabelTTF *quit = [CCLabelTTF labelWithString:@"Exit" fontName:@"Verdana" fontSize:22];
        //startGameLbl.rotation = 270;
        newgame.color = ccRED;
        CCMenuItemLabel *newgameitem = [CCMenuItemLabel itemWithLabel:newgame target:self selector:@selector(startGame)];
        newgameitem.position = ccp(25, size.height - 125);
        newgameitem.rotation = 270;

        CCMenuItemLabel *highscoreitem = [CCMenuItemLabel itemWithLabel:highscore target:self selector:@selector(rankGame)];
        highscoreitem.position = ccp(105, size.height - 125);
        highscoreitem.rotation = 270;
                CCMenu *startMenu = [CCMenu menuWithItems:newgameitem,highscoreitem,
                             nil];
        [startMenu setPosition:ccp(0,0)];
        [self addChild:startMenu];
    }
    return self;
}

-(void) update:(ccTime)delta{
    
    opacityes += dec_or_inc ;
    if(opacityes<255 && !ischange){
        CCSprite*t = (CCSprite*)[self getChildByTag:TAGBACKGROUND];
        t.opacity = opacityes;
    }
    else{
        [self unscheduleUpdate];
    }
    
}

-(void) startGame {
    
    if (isStartGame == NO) {
        // Start the game, called by the menu item
        isStartGame = YES;
        //[[SimpleAudioEngine sharedEngine] playEffect:SND_BUTTON];
        //id list = self.children;
        //[self removeAllChildren];
        [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
    }
}

-(void)quitGame{
    
}

-(void)rankGame{
    [[CCDirector sharedDirector] replaceScene:[HighScoreScene scene]];
}

-(void)dealloc{
    [self release];
    [super dealloc];
}

@end