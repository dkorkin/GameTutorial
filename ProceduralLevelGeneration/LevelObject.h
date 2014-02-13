//
//  LevelObject.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

FOUNDATION_EXPORT CGFloat const kSpriteSize;

typedef NS_ENUM(NSInteger, SpriteType) {
    SpriteTypeNone,
    SpriteTypePlayer,
    SpriteTypeExit,
    SpriteTypeMap,
    SpriteTypeKey,
    SpriteTypeDog,
    SpriteTypeFood
};

@interface LevelObject : SKSpriteNode

- (instancetype)initWithSpriteType:(SpriteType)type andTextureName:(NSString *)textureName;

- (SKTexture *)textureNamed:(NSString *)name;

@end
