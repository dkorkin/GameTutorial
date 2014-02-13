//
//  Tile.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "LevelObject.h"
#import "MapTiles.h"


@interface MapObject : LevelObject

@property(nonatomic, assign) MapTileType objectType;

+ (instancetype)objectOfType:(MapTileType)type toMap:(SKNode *)map atPosition:(CGPoint)position;

@end
