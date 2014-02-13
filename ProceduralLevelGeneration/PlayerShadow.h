//
//  PlayerShadow.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "LevelObject.h"
#import "GameScene.h"

@interface PlayerShadow : LevelObject

+ (instancetype)playerShadowToWorld:(SKNode *)world atPosition:(CGPoint)position;

@end
