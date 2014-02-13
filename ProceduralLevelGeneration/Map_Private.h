//
//  Map_Private.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/29/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Map.h"

@interface Map ()

@property (nonatomic) MapTiles *tiles;
@property (nonatomic) SKTextureAtlas *tileAtlas;
@property (nonatomic) CGFloat tileSize;

- (CGPoint)convertMapCoordinateToWorldCoordinate:(CGPoint)mapCoordinate;
- (CGPoint)convertWorldCoordinateToMapCoordinate:(CGPoint)worldCoordinate;

- (CGPoint)chooseNewPositionFromFlooarMaker:(FloorMaker *)floorMaker;

- (NSUInteger)generateRoomsAt:(CGPoint)position withSize:(CGSize)size;

@end
