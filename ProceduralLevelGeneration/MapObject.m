//
//  Tile.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "MapObject.h"

@implementation MapObject

+ (instancetype)objectOfType:(MapTileType)type toMap:(SKNode *)map atPosition:(CGPoint)position {
    return [[self alloc] initMapObjectOfType:type toMap:map atPosition:position];
}

- (instancetype)initMapObjectOfType:(MapTileType)type toMap:(SKNode *)map atPosition:(CGPoint)position {
    self = [super initWithSpriteType:SpriteTypeMap andTextureName:[self textureNameFromType:type]];
    if(self) {
        self.position = position;
        [map addChild:self];
        _objectType = type;
        
        if(type == MapTileTypeWall) {
            [self addCollisionWall];
        }
    }
    return self;
}

- (NSString *)textureNameFromType:(MapTileType)type {
    NSString *textureName = nil;
    if(type == MapTileTypeFloor) {
        textureName = @"2.png";
    }
    else if (type == MapTileTypeWall) {
        textureName = @"1.png";
    }
    return textureName;
}

- (void)addCollisionWall {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionTypeWall;
    self.physicsBody.contactTestBitMask = 0;
    self.physicsBody.collisionBitMask = CollisionTypePlayer | CollisionTypeDog;
    self.zPosition = 1;
}

@end

