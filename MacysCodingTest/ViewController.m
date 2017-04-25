//
//  ViewController.m
//  MacysCodingTest
//
//  Created by User on 4/21/17.
//  Copyright © 2017 Yemi Ajibola. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *acronymTableView;
@property UISearchController* acronymSearchController;
@property AcronymStore* acronymStore;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.acronymSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.acronymSearchController.searchBar.delegate = self;
    self.acronymSearchController.dimsBackgroundDuringPresentation = false;
    self.acronymTableView.tableHeaderView = self.acronymSearchController.searchBar;
    self.acronymStore = [[AcronymStore alloc]init];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(MBProgressHUD* )progressHUD {
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading";
    
    return hud;
}

-(void) fetchWordsWithAcronym:(NSString* )acronym {
    [self.acronymSearchController dismissViewControllerAnimated:YES completion:NULL];
    
    [self.acronymStore fetchAcronym:acronym completion:^(NSError* _Nullable error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressHUD hideAnimated:YES];
        });
        
        if(error) {
            [self errorAlert:error];
        } else {
            [self.acronymTableView reloadData];
        }
    }];
}

-(void) errorAlert:(NSError* ) error {
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:@"An error occurred" message:error.userInfo[@"errorReason"] preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL]];
    
    [self presentViewController:controller animated:YES completion:NULL];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self fetchWordsWithAcronym:searchBar.text];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.acronymStore.searchedAcronym.longForms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AcronymCell"];
    NSString* longFormText = self.acronymStore.searchedAcronym.longForms[indexPath.row].name;
    
    cell.textLabel.text = longFormText;
    
    return cell;
}

@end
