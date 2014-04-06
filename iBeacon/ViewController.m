//
//  ViewController.m
//  iBeacon
//
//  Created by Mike Perry on 4/5/14.
//  Copyright (c) 2014 Anthony Perry. All rights reserved.
//

#import "ViewController.h"
#import "BeaconAdvertisingService.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBPeripheralManagerDelegate,UIActionSheetDelegate,UINavigationBarDelegate>

@property (strong,nonatomic)CBPeripheralManager *peripheralManager;
@property (weak, nonatomic) IBOutlet UIButton *advertiseButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];

    }
    return self;
}


- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the

}

#pragma mark - CBPeripheralManager Delegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"Peripheral manager updated state");
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    NSLog(@"Did start advertising");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startAdvertising:(id)sender {
    self.advertiseButton.titleLabel.text = @"Running";

    if ([[BeaconAdvertisingService sharedInstance]isAdvertising]) {
        [[BeaconAdvertisingService sharedInstance]stopAdvertising];
    }

    /*UUID is generated using uuidgen command line tool*/
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:@"C3CACDAD-5501-4DA6-B240-5F588C2AF0B2"];

    [[BeaconAdvertisingService sharedInstance]startAdvertisingUUID:uuid major:0 minor:0];
}


- (IBAction)showAdvertisingOptions:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Beacon" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Baldwin Hall", @"UC Pavilion", nil];
    [actionSheet setTintColor:[UIColor colorWithRed:231.0/255.0 green:113.0/255.0 blue:37.0/255.0 alpha:1]];
    [actionSheet showFromBarButtonItem:self.leftBarButton animated:YES];
}


#pragma mark - Aciton sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[BeaconAdvertisingService sharedInstance]isAdvertising]) {
        [[BeaconAdvertisingService sharedInstance]stopAdvertising];
    }
    switch (buttonIndex) {
        case 0: {
            NSUUID *baldwinID = [[NSUUID alloc] initWithUUIDString:@"C3CACDAD-5501-4DA6-B240-5F588C2AF0B2"];
            [[BeaconAdvertisingService sharedInstance] startAdvertisingUUID:baldwinID major:0 minor:0];
            self.navigationItem.title = @"Baldwin Hall";
            break;
        } case 1: {
            NSLog(@"Pavilion advertising starting");
            NSUUID *pavilionUUID = [[NSUUID alloc] initWithUUIDString:@"7B377E4A-1641-4765-95E9-174CD05B6C79"];
            [[BeaconAdvertisingService sharedInstance] startAdvertisingUUID:pavilionUUID major:1 minor:1];
            self.navigationItem.title = @"UC Pavilion";
            break;
        }
        default:
            break;
    }
}


@end
