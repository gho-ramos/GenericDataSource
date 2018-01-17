//
//  ViewController.m
//  GenericDataSource
//
//  Created by Guilherme on 1/17/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

#import "ViewController.h"
#import "GenericDataSource.h"

@interface ViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) GenericDataSource * dataSource;

@end

@implementation ViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

-(void) setupTableView {
    ConfigurationBlock configurationBlock = ^(UITableViewCell * cell, NSString * string) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.textLabel.text = string;
        });
    };
    NSArray * strings = @[@[@"A1", @"A2", @"A3"], @[@"B1", @"B2", @"B3"], @[@"C1", @"C2", @"C3"]];
    self.dataSource = [[GenericDataSource alloc] initWithItems:strings cellIdentifier:@"cell" configurationBlock:configurationBlock];
    self.tableView.dataSource = self.dataSource;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * string = [self.dataSource itemAtIndexPath:indexPath];

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"String" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];

    [self presentViewController:alert animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
@end
