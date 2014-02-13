//
//  HealthHolder.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT CGFloat const kCatFullHealth;
FOUNDATION_EXPORT CGFloat const kDogFullHealth;

@interface HealthHolder : NSObject

@property (nonatomic, assign) CGFloat catHealth;
@property (nonatomic, assign) CGFloat dogHealth;

+ (instancetype)sharedHolder;

@end
