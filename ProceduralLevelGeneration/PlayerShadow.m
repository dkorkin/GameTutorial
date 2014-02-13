//
//  PlayerShadow.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "PlayerShadow.h"

@implementation PlayerShadow

+ (instancetype)playerShadowToWorld:(SKNode *)world atPosition:(CGPoint)position {
    return [[self alloc] initPlayerShadowToWorld:world atPosition:position];
}

- (instancetype)initPlayerShadowToWorld:(SKNode *)world atPosition:(CGPoint)position {
    self = [super initWithSpriteType:SpriteTypePlayer andTextureName:@"shadow"];
    if(self) {
        self.position = position;
        [self shadowSettings];
        [world addChild:self];
    }
    return self;
}

- (void)shadowSettings {
    self.xScale = 0.6f;
    self.yScale = 0.5f;
    self.alpha = 0.4f;
    self.zPosition = 2;
}

@end
