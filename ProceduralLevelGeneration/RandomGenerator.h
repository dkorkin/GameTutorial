//
//  RandomGenerator.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#ifndef ProceduralLevelGeneration_RandomGenerator_h
#define ProceduralLevelGeneration_RandomGenerator_h

NS_INLINE NSInteger randomNumberBetweenNumbers(NSInteger min, NSInteger max) {
    return min + arc4random() % (max - min);
}

#endif
