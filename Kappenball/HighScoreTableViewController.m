//
//  HighScoreTableViewController.m
//  Kappenball
//
//  Created by Darren Vong on 06/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "HighScoreTableViewController.h"

@interface HighScoreTableViewController ()

-(IBAction)backPressed:(id)sender;

@end

@implementation HighScoreTableViewController

// Sends the user back to the home page of app when back button is pressed
-(IBAction)backPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Table header set up
    UILabel *tableTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    tableTitle.textColor = [UIColor whiteColor];
    tableTitle.backgroundColor = [self.tableView backgroundColor];
    tableTitle.opaque = YES;
    tableTitle.font = [UIFont boldSystemFontOfSize:18];
    tableTitle.text = @"High score table";
    tableTitle.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = tableTitle;
    self.tableView.tableHeaderView.userInteractionEnabled = YES;
    
    // "Back" button set up
    UIButton* backButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 2, 60, 40)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor colorWithRed:0.145098 green:0.662745 blue:0.109804 alpha:1];
    backButton.userInteractionEnabled = YES;
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView.tableHeaderView addSubview:backButton];
    
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Number of rows is the number of highscore entries the users have submitted
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.highscores count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HighScoreTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"highScoreRow"];
    
    // Display the table headings if it's the first row
    if (indexPath.row == 0) {
        NSArray* tableHeader = [self.highscores objectAtIndex:indexPath.row];
        cell.rank.text = [tableHeader objectAtIndex:0];
        cell.name.text = [tableHeader objectAtIndex:1];
        cell.energy.text = [tableHeader objectAtIndex:2];
        cell.score.text = [tableHeader objectAtIndex:3];
    }
    else {
        // Display user submitted details otherwise
        HighScorePlayer* player = [self.highscores objectAtIndex:indexPath.row];
        cell.rank.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        cell.name.text = player.name;
        cell.energy.text = [NSString stringWithFormat:@"%d", player.averageEnergy];
        cell.score.text = [NSString stringWithFormat:@"%d", player.score];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
