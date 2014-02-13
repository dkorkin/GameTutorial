//
//  Exit.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "LevelObject.h"

@interface Exit : LevelObject

+ (instancetype)exitToWorld:(SKNode *)world atPosition:(CGPoint)position;

@end
