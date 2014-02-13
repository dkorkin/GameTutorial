//
//  Map.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MapTiles.h"
#import "FloorMaker.h"

@interface Map : SKNode

@property (nonatomic, assign) CGSize gridSize;

@property (nonatomic, assign, readonly) CGPoint spawnPoint;
@property (nonatomic, assign, readonly) CGPoint keyPoint;
@property (nonatomic, assign, readonly) CGPoint exitPoint;
@property (nonatomic, assign, readonly) CGPoint dogPoint;

@property (nonatomic, assign) NSUInteger maxFloorCount;
@property (nonatomic, assign) NSUInteger turnResistance;
@property (nonatomic, assign) NSUInteger floorMakerSpawnProbability;
@property (nonatomic, assign) NSUInteger maxFloorMakerCount;

@property (nonatomic, assign) NSUInteger roomProbability;
@property (nonatomic, assign) CGSize roomMinSize;
@property (nonatomic, assign) CGSize roomMaxSize;

+ (instancetype) mapWithGridSize:(CGSize)gridSize;
- (instancetype) initWithGridSize:(CGSize)gridSize;

- (void) generate;

@end
