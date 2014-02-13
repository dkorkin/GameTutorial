//
//  MapTilesSpecs.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Kiwi.h"
#import "MapTiles.h"

SPEC_BEGIN(MapTilesSpecs)

describe(@"MapTiles", ^{
   
    __block MapTiles *tiles;
    
    beforeAll(^{
        CGSize gridSixe = CGSizeMake(10, 10);
        tiles = [[MapTiles alloc] initWithGridSize:gridSixe];
    });
    describe(@"Initialization", ^{
        context(@"Initialization Parameter are calculated correctly", ^{
            it(@"grid width shoul equal to init value", ^{
                [[theValue(tiles.gridSize.width) should] equal:theValue(10)];
            });
            
            it(@"grid height shoul equal to init value", ^{
                [[theValue(tiles.gridSize.height) should] equal:theValue(10)];
            });
            
            it(@"count should be multiplication of size", ^{
                [[theValue(tiles.count) should] equal:theValue(10*10)];
            });
        });
        
        context(@"description shold be available", ^{
            it(@"should not be nil", ^{
                [[tiles description] shouldNotBeNil];
            });
            
            it(@"should be string", ^{
                [[[tiles description] should] beKindOfClass:[NSString class]];
            });
        });
    });
    
    describe(@"validity check", ^{
        context(@"valid cases", ^{
            it(@"should be valid (point inside)", ^{
                BOOL isValidCoordinates = [tiles isValidTileCoordinateAt:CGPointMake(3, 5)];
                [[theValue(isValidCoordinates) should] equal:theValue(YES)];
            });
            
            it(@"should be valid (point on side)", ^{
                BOOL isValidCoordinates = [tiles isValidTileCoordinateAt:CGPointMake(0, 9)];
                [[theValue(isValidCoordinates) should] equal:theValue(YES)];
            });
        });
        
        context(@"invalid cases", ^{
            it(@"should be valid (point greater than 0 coord)", ^{
                BOOL isValidCoordinates = [tiles isValidTileCoordinateAt:CGPointMake(9, 15)];
                [[theValue(isValidCoordinates) shouldNot] equal:theValue(YES)];
            });
            
            it(@"should be valid (point on less than 0)", ^{
                BOOL isValidCoordinates = [tiles isValidTileCoordinateAt:CGPointMake(-1, 9)];
                [[theValue(isValidCoordinates) shouldNot] equal:theValue(YES)];
            });
        });
    });
    
    describe(@"Edge check", ^{
        context(@"Edge coordinates given", ^{
            it(@"should be at the Edge", ^{
                BOOL isEdge = [tiles isEdgeAtPoint:CGPointMake(0, 0)];
                [[theValue(isEdge) should] equal:theValue(YES)];
            });
            
            it(@"should be at the Edge", ^{
                BOOL isEdge = [tiles isEdgeAtPoint:CGPointMake(0, 5)];
                [[theValue(isEdge) should] equal:theValue(YES)];
            });
        });
        
        context(@"Inside coordinates given", ^{
            it(@"should not be at the Edge", ^{
                BOOL isEdge = [tiles isEdgeAtPoint:CGPointMake(5, 1)];
                [[theValue(isEdge) shouldNot] equal:theValue(YES)];
            });
            
            it(@"should not be at the Edge", ^{
                BOOL isEdge = [tiles isEdgeAtPoint:CGPointMake(4, 5)];
                [[theValue(isEdge) shouldNot] equal:theValue(YES)];
            });
        });
        
        context(@"Outside coordinates given", ^{
            it(@"should not be at the Edge", ^{
                BOOL isEdge = [tiles isEdgeAtPoint:CGPointMake(-1, 0)];
                [[theValue(isEdge) shouldNot] equal:theValue(YES)];
            });
            
            it(@"should not be at the Edge", ^{
                BOOL isEdge = [tiles isEdgeAtPoint:CGPointMake(9, -1)];
                [[theValue(isEdge) shouldNot] equal:theValue(YES)];
            });
        });
    });
    
    describe(@"Coordinate methods", ^{
        context(@"tileTypeAt valid cases", ^{
            it(@"should be same as setted if rect contain initialization point", ^{
                CGPoint initPoint = CGPointMake(1, 1);
                [tiles setTileType:MapTileTypeFloor at:initPoint];
                [[theValue([tiles tileTypeAt:initPoint]) should] equal:theValue(MapTileTypeFloor)];
            });
            
            it(@"should not be differ as setted if rect contain initialization point", ^{
                CGPoint initPoint = CGPointMake(3, 2);
                [tiles setTileType:MapTileTypeFloor at:initPoint];
                [[theValue([tiles tileTypeAt:initPoint]) shouldNot] equal:theValue(MapTileTypeWall)];
            });
        });
        
        context(@"tileTypeAt invalid cases", ^{
            it(@"should be invalid if rect doesn't contain initialization point", ^{
                CGPoint initPoint = CGPointMake(11, 15);
                [tiles setTileType:MapTileTypeFloor at:initPoint];
                [[theValue([tiles tileTypeAt:initPoint]) should] equal:theValue(MapTileTypeInvalid)];
            });
            
            it(@"should be equal floor if rect doesn't contain initialization point", ^{
                CGPoint initPoint = CGPointMake(11, 15);
                [tiles setTileType:MapTileTypeFloor at:initPoint];
                [[theValue([tiles tileTypeAt:initPoint]) shouldNot] equal:theValue(MapTileTypeFloor)];
            });
        });
    });
    
});

SPEC_END
