//
//  TodayVC.m
//  Today
//
//  Created by Ricardo Contreras on 3/6/15.
//  Copyright (c) 2015 RCR. All rights reserved.
//

#import "TodayVC.h"
#import "EasyNetwork.h"
#import "UX.h"
#import "BrowserVC.h"

@interface TodayVC ()
@property (nonatomic, strong) EasyNetwork *network;
@property (nonatomic, strong) UX *ux;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UITextField *searchTF;
@end

@implementation TodayVC
@synthesize network = _network;
@synthesize ux = _ux;
@synthesize items = _items;
@synthesize searchTF = _searchTF;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _network = [[EasyNetwork alloc]init];
    _ux = [[UX alloc]init];
    
    NSUserDefaults *usrDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.rcr.today"];
    NSData *encodedObject = [usrDefaults objectForKey:@"search"];
    if (encodedObject) {
        NSString *searchST = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        [self search:searchST];
    } else {
        [self search:@"iOS"];
    }
}

- (void) searchButton {
    [self search:_searchTF.text];
}

-(void) search:(NSString*) searchST {
    
    [self dismissKeyboard:nil];
    
    self.title = searchST;
    
    NSUserDefaults *usrDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.rcr.today"];
    NSData *itemsData = [NSKeyedArchiver archivedDataWithRootObject:searchST];
    [usrDefaults setObject:itemsData forKey:@"search"];
    [usrDefaults synchronize];
    
    NSString *searchURL = [NSString stringWithFormat:@"https://pipes.yahoo.com/pipes/pipe.run?_id=dd1aee83c96f4588e963f956d6068e28&_render=json&feeditems=100&keywords=%@", searchST];
    
    [_network apiCall:searchURL httpMethod:@"GET" target:self selector:@selector(infoResponse) bodyString:@""];
}

-(void) infoResponse {
    
    if (_network.json[@"value"]) {
        NSDictionary *valueDict = _network.json[@"value"];
        
        if (valueDict[@"items"]) {
            _items = valueDict[@"items"];
            [self.tableView reloadData];
            
            
            NSUserDefaults *usrDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.rcr.today"];
            NSData *itemsData = [NSKeyedArchiver archivedDataWithRootObject:_items];
            [usrDefaults setObject:itemsData forKey:@"items"];
            [usrDefaults synchronize];
            
        }
    }
}

-(IBAction)dismissKeyboard:(id)sender {
    [[self.view superview] endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 90;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    _searchTF = [_ux makeTextFieldWithPlaceholder:@"" tag:1 font:_ux.fontLight backgroundImage:nil textColor:_ux.grayMid backgroundColor:_ux.grayLight x:10 y:40 width:tableView.bounds.size.width -100 height:40 keyboard:UIKeyboardTypeDefault capitalization:UITextAutocapitalizationTypeWords secure:NO];
    [headerView addSubview:_searchTF];
    
    UIButton *btn = [_ux makeButtonWithText:@"Buscar" target:self selector:@selector(searchButton) font:_ux.fontLight textColor:[UIColor whiteColor] image:nil background:nil backgroundColor:_ux.grayMid x:tableView.bounds.size.width -90 y:40 width:80 height:40 tag:1];
    [headerView addSubview:btn];
    
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self dismissKeyboard:nil];
    
    NSDictionary *item = _items[indexPath.row];
    cell.textLabel.text = item[@"title"];
    cell.textLabel.numberOfLines = 3;
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item = _items[indexPath.row];
    if (item[@"link"]) {
        BrowserVC *controller = [[BrowserVC alloc]init];
        controller.titleST = item[@"title"];;
        controller.urlST = item[@"link"];
        [self.navigationController pushViewController:controller animated:YES];
    }

}

@end
