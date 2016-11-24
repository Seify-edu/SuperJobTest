//
//  ShowVacanciesModuleInteractor.h
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShowVacanciesModuleInteractorInput
- (void)stopAllTasks;
@end

@protocol ShowVacanciesModuleInteractorOutput
@end

@interface ShowVacanciesModuleInteractor : NSObject<ShowVacanciesModuleInteractorInput>
@property (weak)id<ShowVacanciesModuleInteractorOutput> output;
@end
