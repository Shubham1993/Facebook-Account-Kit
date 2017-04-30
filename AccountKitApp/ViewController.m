//
//  ViewController.m
//  AccountKitApp
//
//  Created by Shubham on 29/04/17.
//  Copyright © 2017 perpule. All rights reserved.
//

#import "ViewController.h"
#import "Themes.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AKFAccountKit *_accountKit;
    UIViewController<AKFViewController> *_pendingLoginViewController;
    NSString *authorizationCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    if (_accountKit == nil) {
        _accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAuthorizationCode];
           }
    [_accountKit requestAccount:^(id<AKFAccount> account, NSError *error) {
        // account ID
        NSLog(@"%@",account.accountID);
        if ([account.emailAddress length] > 0) {
            NSLog(@"Email Address : %@",account.emailAddress);
        }
        else if ([account phoneNumber] != nil) {
            NSLog(@"Phone Number : %@",[[account phoneNumber] stringRepresentation]);
        }
    }];

    _pendingLoginViewController = [_accountKit viewControllerForLoginResume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_prepareLoginViewController:(UIViewController<AKFViewController> *)loginViewController
{
    loginViewController.delegate = self;
//     Optionally, you may use the Advanced UI Manager or set a theme to customize the UI.
//    loginViewController.advancedUIManager = nil;
//    loginViewController.theme = [Themes bicycleTheme];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
       if ([self isUserLoggedIn]) {
        // if the user is already logged in, go to the main screen
//        [self proceedToMainScreen];
        NSLog(@"Already Logged In");
    } else if (_pendingLoginViewController != nil) {
        // resume pending login (if any)
        [self _prepareLoginViewController:_pendingLoginViewController];
        [self presentViewController:_pendingLoginViewController
                           animated:animated
                         completion:NULL];
        _pendingLoginViewController = nil;
    }
}

- (IBAction)loginWithPhone:(id)sender {
    
    AKFPhoneNumber *preFillPhoneNumber = [[AKFPhoneNumber alloc] initWithCountryCode:@"" phoneNumber:@""];
    NSString *inputState = [[NSUUID UUID] UUIDString];
    UIViewController<AKFViewController> *viewController = [_accountKit viewControllerForPhoneLoginWithPhoneNumber:preFillPhoneNumber state:inputState];
    viewController.enableSendToFacebook = YES; // defaults to NO
    [self _prepareLoginViewController:viewController]; // see below
    [self presentViewController:viewController animated:YES completion:NULL];

}


-(BOOL)isUserLoggedIn{
    
    if([_accountKit currentAccessToken] != nil){
        return true;
    }
    return false;
}


- (void)viewController:(UIViewController<AKFViewController> *)viewController didFailWithError:(NSError *)error
{
    NSLog(@"%@ did fail with error: %@", viewController, error);
}

-(void)viewController:(UIViewController<AKFViewController> *)viewController didCompleteLoginWithAuthorizationCode:(NSString *)code state:(NSString *)state{
    
    
}

@end
