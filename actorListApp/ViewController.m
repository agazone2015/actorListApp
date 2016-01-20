//
//  ViewController.m
//  actorListApp
//
//  Created by Chappie on 21/04/2015.
//  Copyright (c) 2015 Chappie. All rights reserved.
//

#import "ViewController.h"
#import "ViewActorController.h"

@interface ViewController ()

@property NSMutableArray *actors;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadActors];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadActors
{
    NSString *actorsFilePath = [[NSBundle mainBundle] pathForResource:@"actors_list" ofType:@"txt"];
    NSLog(@"The actors list file is at: %@", actorsFilePath);
    
    NSString *actorsFileContents = [NSString stringWithContentsOfFile:actorsFilePath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *actorsFileLines = [actorsFileContents componentsSeparatedByString:@"\n"];
    
    self.actors = [NSMutableArray array];
    
    int actorsFileLineNumber = 0;
    for (NSString *actorsFileLine in actorsFileLines) {
        actorsFileLineNumber++;
        NSArray *actorsLineComponents = [actorsFileLine componentsSeparatedByString:@" "];
        if ([actorsLineComponents count] == 2) {
            ViewActorController *actorsRecord = [[ViewActorController alloc] init];
            actorsRecord.name = [actorsLineComponents objectAtIndex:0];
            actorsRecord.surname = [actorsLineComponents objectAtIndex:1];
            [self.actors addObject:actorsRecord];
        } else {
             NSLog(@"%@", actorsFileLine);
           // [self loadView];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.actors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActorsListCell" forIndexPath:indexPath];
    
     ViewActorController *actorsRecordForIndexPath = [self.actors objectAtIndex:indexPath.row];
     cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", actorsRecordForIndexPath.name, actorsRecordForIndexPath.surname];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showActorsListView"]) {

    }
}


@end
