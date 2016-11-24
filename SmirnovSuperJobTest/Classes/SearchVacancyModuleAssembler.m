//
//  SearchVacancyModuleAssembler.m
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModuleAssembler.h"
#import "SearchVacancyModuleView.h"
#import "SearchVacancyModuleInteractor.h"
#import "SearchVacancyModulePresenter.h"
#import "SearchVacancyModuleRouter.h"

@implementation SearchVacancyModuleAssembler

+ (UIViewController *)createModuleWithRootController:(UINavigationController *)rootController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    SearchVacancyModuleView *view = [storyboard instantiateViewControllerWithIdentifier:@"SearchVacancyModuleView"];
    SearchVacancyModulePresenter *presenter = [[SearchVacancyModulePresenter alloc] init];
    SearchVacancyModuleInteractor *interactor = [[SearchVacancyModuleInteractor alloc] init];
    SearchVacancyModuleRouter *router = [[SearchVacancyModuleRouter alloc] init];
    view.output = presenter;
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    interactor.output = presenter;
    router.rootController = rootController;
    
    return view;
};

@end
