//
//  LevelObject.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "LevelObject.h"

CGFloat const kSpriteSize = 32;

@interface LevelObject ()

@property (nonatomic, strong) SKTextureAtlas *atlas;

@end

@implementation LevelObject

- (instancetype)initWithSpriteType:(SpriteType)type andTextureName:(NSString *)textureName {
    SKTextureAtlas *atlas = [self atlasForStripeType:type];
    self = [super initWithTexture:[atlas textureNamed:textureName]];
    if(self) {
        _atlas = atlas;
    }
    return self;
}

- (SKTextureAtlas *)atlasForStripeType:(SpriteType)type {
    SKTextureAtlas *atlas = nil;
    if(type == SpriteTypePlayer || type == SpriteTypeExit || type == SpriteTypeKey
                                || type == SpriteTypeDog || type == SpriteTypeFood) {
        atlas = [SKTextureAtlas atlasNamed:@"sprites"];
    }
    else if (type == SpriteTypeMap) {
        atlas = [SKTextureAtlas atlasNamed:@"tiles"];
    }
    return atlas;
}

- (SKTexture *)textureNamed:(NSString *)name {
    return [_atlas textureNamed:name];
}


@end
