//
//  MapTiles.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "MapTiles.h"

@interface MapTiles ()

@property (nonatomic, assign) NSInteger *tiles;

@end

@implementation MapTiles

- (instancetype)initWithGridSize:(CGSize)size {
    self = [super init];
    
    if (self) {
        _gridSize = size;
        _count = (NSUInteger) size.width * size.height;
        _tiles = calloc(_count, sizeof(NSInteger));
    }
    
    return self;
}

#pragma mark -
#pragma mark Tiles managment 

- (MapTileType)tileTypeAt:(CGPoint)tileCoordinate {
    NSInteger tileArrayIndex = [self tileIndexAt:tileCoordinate];
    
    if (tileArrayIndex == NSNotFound) {
        return MapTileTypeInvalid;
    }
    
    return self.tiles[tileArrayIndex];
}

- (void)setTileType:(MapTileType)type at:(CGPoint)tileCoordinate {
    NSInteger tileArrayIndex = [self tileIndexAt:tileCoordinate];
    
    if (tileArrayIndex != NSNotFound) {
        self.tiles[tileArrayIndex] = type;
    }
}

- (NSInteger)tileIndexAt:(CGPoint)tileCoordinate {
    if (![self isValidTileCoordinateAt:tileCoordinate]) {
        return NSNotFound;
    }
    
    return ((NSInteger)tileCoordinate.y * (NSInteger)self.gridSize.width + (NSInteger)tileCoordinate.x);
}

- (BOOL)isEdgeAtPoint:(CGPoint)tileCoordinate {
    if([self isValidTileCoordinateAt:tileCoordinate]) {
        return ((NSInteger)tileCoordinate.x == 0 ||
                (NSInteger)tileCoordinate.x == (NSInteger)self.gridSize.width - 1 ||
                (NSInteger)tileCoordinate.y == 0 ||
                (NSInteger)tileCoordinate.y == (NSInteger)self.gridSize.height - 1);
    }
    
    return NO;
}

- (BOOL)isValidTileCoordinateAt:(CGPoint)tileCoordinate {
    return !(tileCoordinate.x < 0 ||
             tileCoordinate.x >= self.gridSize.width ||
             tileCoordinate.y < 0 ||
             tileCoordinate.y >= self.gridSize.height);
}

#pragma mark -
#pragma mark Description

- (NSString *)description {
    NSMutableString *tileMapDescription = [NSMutableString stringWithFormat:@"<%@ = %p | \n", [self class], self];
    NSInteger maxElementIndex = (NSInteger)self.gridSize.height - 1;
    for (NSInteger y = maxElementIndex; y >= 0; y--) {
        [tileMapDescription appendString:[NSString stringWithFormat:@"[%i]", y]];
        
        for ( NSInteger x = 0; x < (NSInteger)self.gridSize.width; x++ ) {
            MapTileType typeAtPoint = [self tileTypeAt:CGPointMake(x, y)];
            [tileMapDescription appendString:[NSString stringWithFormat:@"%i",typeAtPoint]];
        }
        [tileMapDescription appendString:@"\n"];
    }
    
    return [tileMapDescription stringByAppendingString:@">"];
}


- (void)dealloc {
    if (_tiles) {
        free(_tiles);
    }
}

@end
