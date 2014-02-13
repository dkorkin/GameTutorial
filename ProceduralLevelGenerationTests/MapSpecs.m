//
//  MapSpecs.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/29/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Kiwi.h"
#import "Map.h"
#import "Map_Private.h"
#import "LevelObject.h"

SPEC_BEGIN(MapSpecs)

describe(@"Map elements generation helpers", ^{
    
    __block Map *map = nil;
    __block FloorMaker *floorMaker = nil;
    
    beforeAll(^{
        map = [Map mapWithGridSize:CGSizeMake(48, 48)];
        floorMaker = [[FloorMaker alloc] initWithCurrentPosition:CGPointMake(2, 2) andDirection:FloorDirectionTypeRight];
    });
    
    beforeEach(^{
        floorMaker.currentPosition = CGPointMake(2, 2);
    });
    
    /*
    context(@"Random number generation in range", ^{
        it(@"number should be in range", ^{
            NSInteger randomNumber = [Map randomNumberBetweenMin:3 andMax:8];
            [[theValue(randomNumber) should] beBetween:theValue(3) and:theValue(8)];
        });
        
        it(@"number should be out range", ^{
            NSInteger randomNumber = [Map randomNumberBetweenMin:3 andMax:8];
            [[theValue(randomNumber) shouldNot] beBetween:theValue(10) and:theValue(18)];
        });
    });
     */
    
    context(@"Choose new Position check", ^{
        it(@"new position in right direction shoud have x+1 coord", ^{
            CGPoint newPosition = [map chooseNewPositionFromFlooarMaker:floorMaker];
            [[theValue(newPosition.x) should] equal:theValue(floorMaker.currentPosition.x + 1)];
        });
        
        it(@"new position in left direction shoud have x-1 coord", ^{
            floorMaker.direction = FloorDirectionTypeLeft;
            CGPoint newPosition = [map chooseNewPositionFromFlooarMaker:floorMaker];
            [[theValue(newPosition.x) should] equal:theValue(floorMaker.currentPosition.x - 1)];
        });
        
        it(@"new position in right direction shoud have same y coord", ^{
            floorMaker.direction = FloorDirectionTypeRight;
            CGPoint newPosition = [map chooseNewPositionFromFlooarMaker:floorMaker];
            [[theValue(newPosition.y) should] equal:theValue(floorMaker.currentPosition.y)];
        });
        
        it(@"new position in up direction shoud have y+1 coord", ^{
            floorMaker.direction = FloorDirectionTypeUp;
            CGPoint newPosition = [map chooseNewPositionFromFlooarMaker:floorMaker];
            [[theValue(newPosition.y) should] equal:theValue(floorMaker.currentPosition.y - 1)];
        });
        
        it(@"new position in down direction shoud have y-1 coord", ^{
            floorMaker.direction = FloorDirectionTypeDown;
            CGPoint newPosition = [map chooseNewPositionFromFlooarMaker:floorMaker];
            [[theValue(newPosition.y) should] equal:theValue(floorMaker.currentPosition.y + 1)];
        });
        
        it(@"new position in down direction shoud have same x coord", ^{
            floorMaker.direction = FloorDirectionTypeDown;
            CGPoint newPosition = [map chooseNewPositionFromFlooarMaker:floorMaker];
            [[theValue(newPosition.x) should] equal:theValue(floorMaker.currentPosition.x)];
        });

    });
    
    context(@"Coordinate convertation check", ^{
        it(@"should perform valid x coord convention", ^{
            CGPoint pointForConvert = CGPointMake(2, 3);
            CGPoint pointResult = [map convertMapCoordinateToWorldCoordinate:pointForConvert];
            CGFloat resultX = kSpriteSize * pointForConvert.x;
            [[theValue(pointResult.x) should] equal:theValue(resultX)];
        });
        
        it(@"should perform valid y coord convention", ^{
            CGPoint pointForConvert = CGPointMake(2, 3);
            CGPoint pointResult = [map convertMapCoordinateToWorldCoordinate:pointForConvert];
            CGFloat resultY = (map.tiles.gridSize.height - pointForConvert.y) * kSpriteSize;
            [[theValue(pointResult.y) should] equal:theValue(resultY)];
        });
    });
    
    context(@"room generation", ^{
        it(@"shold be greater than 0", ^{
            CGPoint generationPoint = CGPointMake(5, 5);
            CGSize roomSize = CGSizeMake(2, 2);
            NSInteger roomNumber = [map generateRoomsAt:generationPoint withSize:roomSize];
            [[@(roomNumber) should] beGreaterThan:@0];
        });
    });
    
});


SPEC_END
