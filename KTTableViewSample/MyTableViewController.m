//
//  MyTableViewController.m
//  KTTableViewSample
//
//  Created by Chris on 7/11/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "MyTableViewController.h"

#import <KiiSDK/Kii.h>

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (UITableViewCell*) tableView:(UITableView *)tableView
              cellForKiiObject:(KiiObject *)object
                   atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:identifier];

    // start custom implementation
    cell.textLabel.text = [NSString stringWithFormat:@"%d", ((NSNumber*)[object getObjectForKey:@"myTimestamp"]).intValue];
    // end custom implementation
    
    return cell;
}

- (void) createObject
{
    // create our bucket and our object
    KiiBucket *bucket = [[KiiUser currentUser] bucketWithName:@"myBucket"];
    KiiObject *object = [bucket createObject];
    
    // store the current time as our sortable key/value pair
    NSNumber *myTimestamp = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    [object setObject:myTimestamp forKey:@"myTimestamp"];
    
    // show a loader
    [KTLoader showLoader:@"Loading..." animated:TRUE];
    
    // save the object to the cloud
    [object saveWithBlock:^(KiiObject *object, NSError *error) {
        
        // hide our loader
        [KTLoader hideLoader:TRUE];
        
        // something went wrong, tell the user
        if(error) {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:@"Unable to create an object. Check the log to see if anything went wrong"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // start custom implementation
    if(![KiiUser loggedIn]) {
        KTLoginViewController *vc = [[KTLoginViewController alloc] init];
        [self presentViewController:vc animated:TRUE completion:nil];
    } else {
        
        // this defines the query
        KiiQuery *query = [KiiQuery queryWithClause:nil];
        [query sortByDesc:@"myTimestamp"];
        self.query = query;
        
        // and this defines the bucket
        self.bucket = [[KiiUser currentUser] bucketWithName:@"myBucket"];
        
        // we also want to refresh the table with the latest query and bucket
        [self refreshQuery];
        
    }
    // end custom implementation
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createObject)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
