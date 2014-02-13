//
//  FloorMaker.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FloorDirectionType){
    FloorDirectionTypeNone = 0,
    FloorDirectionTypeUp = 1,
    FloorDirectionTypeDown = 2,
    FloorDirectionTypeLeft = 3,
    FloorDirectionTypeRight = 4,
};

@interface FloorMaker : NSObject

@property (nonatomic, assign) CGPoint currentPosition;
@property (nonatomic, assign) FloorDirectionType direction;

- (instancetype) initWithCurrentPosition:(CGPoint)currentPosition andDirection:(FloorDirectionType)direction;

@end
