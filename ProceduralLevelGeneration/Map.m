//
//  Map.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Map.h"
#import "GameScene.h"

#import "MapObject.h"

#import "RandomGenerator.h"


@interface Map ()

@property (nonatomic, assign) NSUInteger keyChance;
@property (nonatomic, assign) NSUInteger dogChance;

@property (nonatomic, strong) MapTiles *tiles;

@property (nonatomic, strong) NSMutableArray *floorMakers;

@end


@implementation Map

+ (instancetype)mapWithGridSize:(CGSize)gridSize {
    return [[self alloc] initWithGridSize:gridSize];
}

- (instancetype)initWithGridSize:(CGSize)gridSize {
    if (self = [super init]) {
        _gridSize = gridSize;
        _keyChance = 4;
        _dogChance = 4;
        _maxFloorCount = 110;
        _turnResistance = 20;
        _floorMakerSpawnProbability = 25;
        _maxFloorMakerCount = 5;
        _roomProbability = 20;
        _roomMinSize = CGSizeMake(2, 2);
        _roomMaxSize = CGSizeMake(6, 6);
        
        _spawnPoint = CGPointZero;
        _exitPoint = CGPointZero;
        
        _floorMakers = [NSMutableArray array];
        
        self.zPosition = 0;
    }
    return self;
}

#pragma mark -
#pragma mark - generate map elements

- (void)generate {
    _tiles = [[MapTiles alloc] initWithGridSize:_gridSize];
    [self generateTileGrid];
    [self generateWalls];
    [self generateTiles];
}

- (void)generateTileGrid {
    CGPoint startPoint = CGPointMake(self.tiles.gridSize.width / 2, self.tiles.gridSize.height / 2);
    _spawnPoint = [self convertMapCoordinateToWorldCoordinate:startPoint];

    [self.tiles setTileType:MapTileTypeFloor at:startPoint];
    
    [_floorMakers addObject:[self generateFloorMakesWithStartPoint:startPoint andDirection:FloorDirectionTypeNone]];
    
    __block NSUInteger currentFloorCount = 1;
    while ( currentFloorCount < self.maxFloorCount ) {
        [self.floorMakers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            FloorMaker *floorMaker = (FloorMaker *)obj;
            NSInteger turnResistance = randomNumberBetweenNumbers(0, 100);
            
            if (floorMaker.direction == FloorDirectionTypeNone ||  turnResistance <= self.turnResistance){
                floorMaker.direction = [Map randomDirection];
            }
            
            BOOL isNewFloorAvailable = [self canBeSettedNewFloor:floorMaker toCurrentFloorGroupWithCount:currentFloorCount];
            CGPoint newPosition = [self chooseNewPositionFromFlooarMaker:floorMaker];
            
            if (isNewFloorAvailable) {
                floorMaker.currentPosition = newPosition;
                [self.tiles setTileType:MapTileTypeFloor at:floorMaker.currentPosition];
                currentFloorCount++;
                
                if ( randomNumberBetweenNumbers(0, 100) <= self.roomProbability ) {
                    NSUInteger roomSizeX = randomNumberBetweenNumbers(self.roomMinSize.width,
                                                                      self.roomMaxSize.width);
                    NSUInteger roomSizeY = randomNumberBetweenNumbers(self.roomMinSize.height,
                                                                      self.roomMaxSize.height);
                    
                    currentFloorCount += [self generateRoomsAt:floorMaker.currentPosition
                                                      withSize:CGSizeMake(roomSizeX, roomSizeY)];
                }
                [self pointSettings:floorMaker.currentPosition];
            }
            [self createAdditionalFloor:floorMaker];
        }];
    }
    NSLog(@"%@", [self.tiles description]);
}



- (void)generateTiles {

    for (NSInteger y = 0; y < self.tiles.gridSize.height; y++) {
        
        for (NSInteger x = 0; x < self.tiles.gridSize.width; x++) {
            
            CGPoint tileCoordinate = CGPointMake(x, y);
            MapTileType tileType = [self.tiles tileTypeAt:tileCoordinate];
            
            if (tileType != MapTileTypeNone) {
                CGPoint mapObjectPosition = [self convertMapCoordinateToWorldCoordinate:tileCoordinate];
                [MapObject objectOfType:tileType toMap:self atPosition:mapObjectPosition];
            }
            
        }
    }
}


- (void)generateWalls {
    for (NSInteger y = 0; y < self.tiles.gridSize.height; y++) {
        for (NSInteger x = 0; x < self.tiles.gridSize.width; x++) {
            
            CGPoint tileCoordinate = CGPointMake(x, y);
            
            if ([self.tiles tileTypeAt:tileCoordinate] == MapTileTypeFloor) {
                [self setupWallsForNeighbourForIndexX:x andY:y];
            }
        }
    }
}


- (FloorMaker *)generateFloorMakesWithStartPoint:(CGPoint)startPoint andDirection:(FloorDirectionType)direction {
    FloorMaker* floorMaker = [[FloorMaker alloc] initWithCurrentPosition:startPoint
                                                            andDirection:direction];
    return floorMaker;
}

-(void)createAdditionalFloor:(FloorMaker *)floor {
    NSInteger spawnProbability = randomNumberBetweenNumbers(0, 100);
    if (spawnProbability <= self.floorMakerSpawnProbability && self.floorMakers.count < self.maxFloorMakerCount) {
        FloorMaker *newFloor = [self generateFloorMakesWithStartPoint:floor.currentPosition
                                                         andDirection:[Map randomDirection]];
        [self.floorMakers addObject:newFloor];
    }
}


- (NSUInteger)generateRoomsAt:(CGPoint)position withSize:(CGSize)size {
    NSUInteger numberOfFloorsGenerated = 0;
    for (NSUInteger y = 0; y < size.height; y++) {
        for (NSUInteger x = 0; x < size.width; x++) {
            CGPoint tilePosition = CGPointMake(position.x + x, position.y + y);
            
            if ([self.tiles tileTypeAt:tilePosition] == MapTileTypeInvalid) {
                continue;
            }
            
            if (![self.tiles isEdgeAtPoint:tilePosition]) {
                if ([self.tiles tileTypeAt:tilePosition] == MapTileTypeNone) {
                    [self.tiles setTileType:MapTileTypeFloor at:tilePosition];
                    numberOfFloorsGenerated++;
                }
            }
        }
    }
    return numberOfFloorsGenerated;
}

#pragma mark - point settings
- (void)pointSettings:(CGPoint)position {
    _exitPoint = [self convertMapCoordinateToWorldCoordinate:position];
    
    if([self isKeyPoint]) {
        _keyPoint = [self convertMapCoordinateToWorldCoordinate:position];
    }
    
    if([self isDogPoint]) {
        _dogPoint = [self convertMapCoordinateToWorldCoordinate:position];
    }
}


#pragma mark - generate helpers

- (BOOL)canBeSettedNewFloor:(FloorMaker *)floor toCurrentFloorGroupWithCount:(NSInteger) floorCount{
    CGPoint newPosition = [self chooseNewPositionFromFlooarMaker:floor];
    BOOL isValidDirection = [self.tiles isValidTileCoordinateAt:newPosition];
    BOOL isEdge = [self.tiles isEdgeAtPoint:newPosition];
    MapTileType mapTyleType = [self.tiles tileTypeAt:newPosition];
    
    if( isValidDirection && !isEdge &&  mapTyleType == MapTileTypeNone && floorCount < self.maxFloorCount) {
        return YES;
    }
    return NO;
}

- (void)setupWallsForNeighbourForIndexX:(NSInteger)x andY:(NSInteger)y {
    for (NSInteger neighbourY = -1; neighbourY < 2; neighbourY++) {
        for (NSInteger neighbourX = -1; neighbourX < 2; neighbourX++) {
            
            if (!(neighbourX == 0 && neighbourY == 0)) {
                CGPoint coordinate = CGPointMake(x + neighbourX, y + neighbourY);
                
                if ([self.tiles tileTypeAt:coordinate] == MapTileTypeNone) {
                    [self.tiles setTileType:MapTileTypeWall at:coordinate];
                }
            }
        }
    }
}

- (BOOL)isKeyPoint {
    if(self.keyChance != -1) {
        NSInteger keyLevel = randomNumberBetweenNumbers(0, self.keyChance);
        if(keyLevel == 0) {
            self.keyChance = -1;
            return YES;
        }
    }
    self.keyChance = self.keyChance / 2;
    return NO;
}


- (BOOL)isDogPoint {
    if(self.dogChance != -1) {
        NSInteger dogLevel = randomNumberBetweenNumbers(0, self.dogChance);
        if(dogLevel == 0) {
            self.dogChance = -1;
            return YES;
        }
    }
    self.dogChance = self.dogChance / 2;
    return NO;
}


- (CGPoint)chooseNewPositionFromFlooarMaker:(FloorMaker *)floorMaker {
    CGPoint newPosition;
    switch (floorMaker.direction) {
        case FloorDirectionTypeUp:
            newPosition = CGPointMake(floorMaker.currentPosition.x, floorMaker.currentPosition.y - 1);
            break;
        case FloorDirectionTypeDown:
            newPosition = CGPointMake(floorMaker.currentPosition.x, floorMaker.currentPosition.y + 1);
            break;
        case FloorDirectionTypeLeft:
            newPosition = CGPointMake(floorMaker.currentPosition.x - 1, floorMaker.currentPosition.y);
            break;
        case FloorDirectionTypeRight:
            newPosition = CGPointMake(floorMaker.currentPosition.x + 1, floorMaker.currentPosition.y);
            break;
        default:
            break;
    }
    return newPosition;
}


- (CGPoint)convertMapCoordinateToWorldCoordinate:(CGPoint)mapCoordinate {
    CGFloat xValue = mapCoordinate.x * kSpriteSize;
    CGFloat yValue = (self.tiles.gridSize.height - mapCoordinate.y) * kSpriteSize;
    return CGPointMake(xValue, yValue);
}

- (CGPoint)convertWorldCoordinateToMapCoordinate:(CGPoint)worldCoordinate {
    CGFloat xValue = worldCoordinate.x / kSpriteSize;
    CGFloat yValue = self.tiles.gridSize.height - worldCoordinate.y / kSpriteSize;
    return CGPointMake(xValue, yValue);
}

+ (FloorDirectionType)randomDirection {
    NSInteger direction = randomNumberBetweenNumbers(1, 4);
    if (direction == 1) {
        return FloorDirectionTypeUp;
    }
    else if (direction == 2) {
        return FloorDirectionTypeDown;
    }
    else if (direction == 3) {
        return FloorDirectionTypeLeft;
    }
    return FloorDirectionTypeRight;
}

@end
