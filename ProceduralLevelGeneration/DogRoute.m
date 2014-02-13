//
//  Route.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/31/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "DogRoute.h"
#import "MapTiles.h"

#import "RandomGenerator.h"

@interface DogRoute ()

@property (nonatomic, strong) Map *map;
@property (nonatomic, strong) CatPlayer *catPlayer;

@property (nonatomic, assign) CGPoint lastPosition;

@property (nonatomic, assign) BOOL isRouteDirrectionCat;

@end



@implementation DogRoute

+ (instancetype)routeOnMap:(Map *)map andAim:(CatPlayer *)catPlayer {
    return [[self alloc] initWithMap:map andPlayer:catPlayer];
}

- (instancetype)initWithMap:(Map *)map andPlayer:(CatPlayer *)catPlayer {
    self = [super init];
    if(self) {
        _map = map;
        _catPlayer = catPlayer;
    }
    return self;
}

- (CGPoint)movePointForDogPosition:(CGPoint)dogPosition forState:(BOOL)isLowHealth {
    CGPoint newPosition = CGPointZero;
    NSInteger step = 5;
    while (step != 0) {
        step--;
        if(self.isRouteDirrectionCat) {
            newPosition = [self huntingPointForDogPosition:dogPosition forState:isLowHealth];
        }
        else {
            newPosition = [self randomPointForDogPosition:dogPosition];
        }
        
        if(step != 0) {
            CGPoint mapPoint = [self.map convertWorldCoordinateToMapCoordinate:newPosition];
            MapTileType type = [self.map.tiles tileTypeAt:mapPoint];
            if(type == MapTileTypeFloor) {
                self.lastPosition = newPosition;
                self.isRouteDirrectionCat = YES;
                step = 0;
                break;
            }
            else {
                self.isRouteDirrectionCat = NO;
            }
        }
        else {
            return self.lastPosition;
        }
    }
    
    return newPosition;
}

- (BOOL)checkForMoveAvailabilityFromPosition:(CGPoint)position {
    if(distanceBetweenPoints(position,  _catPlayer.position) <= 32) {
        return NO;
    }
    return YES;
}


- (CGPoint)randomPointForDogPosition:(CGPoint)dogPosition {
    CGPoint newPosition = CGPointZero;
    NSInteger direction = randomNumberBetweenNumbers(0, 3);
    switch (direction) {
        case 0:
            newPosition = CGPointMake(dogPosition.x, dogPosition.y - kSpriteSize);
            break;
        case 1:
            newPosition = CGPointMake(dogPosition.x, dogPosition.y + kSpriteSize);
            break;
        case 2:
            newPosition = CGPointMake(dogPosition.x - kSpriteSize, dogPosition.y);
            break;
        case 3:
            newPosition = CGPointMake(dogPosition.x + kSpriteSize, dogPosition.y);
            break;
        default:
            break;
    }
    return newPosition;
}


- (CGPoint)huntingPointForDogPosition:(CGPoint)dogPosition forState:(BOOL)isLowHealth {
    CGPoint newPositionUp = CGPointMake(dogPosition.x, dogPosition.y - kSpriteSize);
    CGPoint newPositionDown = CGPointMake(dogPosition.x, dogPosition.y + kSpriteSize);
    CGPoint newPositionLeft = CGPointMake(dogPosition.x - kSpriteSize, dogPosition.y);
    CGPoint newPositionRight = CGPointMake(dogPosition.x + kSpriteSize, dogPosition.y);
    
    CGFloat firstDiff = distanceBetweenPoints(newPositionUp, _catPlayer.position);
    CGFloat secondDiff = distanceBetweenPoints(newPositionDown, _catPlayer.position);
    CGFloat thirdDiff = distanceBetweenPoints(newPositionLeft, _catPlayer.position);
    CGFloat forthDiff = distanceBetweenPoints(newPositionRight, _catPlayer.position);
    
    NSArray *values = @[@(firstDiff), @(secondDiff), @(thirdDiff), @(forthDiff)];
    
    CGFloat bestDistance = 0.0;
    if(isLowHealth) {
        bestDistance = [[values valueForKeyPath:@"@max.floatValue"] floatValue];
    }
    else {
        bestDistance = [[values valueForKeyPath:@"@min.floatValue"] floatValue];
    }
    if(bestDistance == firstDiff) {
        return newPositionUp;
    }
    else if (bestDistance == secondDiff) {
        return newPositionDown;
    }
    else if (bestDistance == thirdDiff) {
        return newPositionLeft;
    }
    
    return newPositionRight;
}

@end
