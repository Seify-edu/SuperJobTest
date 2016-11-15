//
//  SearchVacancyModulePresenter.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModulePresenter.h"

@interface SearchVacancyModulePresenter()
@property BOOL viewDidLoad;
@end

@implementation SearchVacancyModulePresenter

#pragma mark - SearchVacancyModuleInput

- (void)configureModule
{
    
};

#pragma mark - SearchVacancyModuleViewOutput methods

- (void)didLoad
{
    self.viewDidLoad = YES;
};

- (void)errorOkPressed
{
    [self.view dismissErrorMessage];
};

- (void)searchPressedForEnteredKeyword:(NSString *)keyword
{
    [self.interactor loadVacanciesForKeyword:keyword];
};

#pragma mark - SearchVacancyModuleInteractorOutput methods

- (void)didFailLoadVacanciesWithErrorMessage:(NSString *)errorMessage
{
    [self.view showErrorMessage:errorMessage];
};

- (void)didLoadVacancies:(NSArray *)vacancies
{
    if ( vacancies.count == 0 )
    {
        [self.view showErrorMessage:@"Nothing was found. Try another keywords."];
    }
    else
    {
        [self.router presentNextModuleWithData:vacancies];
    }
};
@end
