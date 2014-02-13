//
//  MapTiles.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MapTileType) {
    MapTileTypeInvalid = -1,
    MapTileTypeNone = 0,
    MapTileTypeFloor = 1,
    MapTileTypeWall = 2,
};

@interface MapTiles : NSObject

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign, readonly) CGSize gridSize;

- (instancetype) initWithGridSize:(CGSize)size;

- (MapTileType) tileTypeAt:(CGPoint)tileCoordinate;
- (void) setTileType:(MapTileType)type at:(CGPoint)tileCoordinate;

- (BOOL) isEdgeAtPoint:(CGPoint)tileCoordinate;
- (BOOL) isValidTileCoordinateAt:(CGPoint)tileCoordinate;

@end
