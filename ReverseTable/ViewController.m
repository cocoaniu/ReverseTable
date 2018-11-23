//
//  ViewController.m
//  ReverseTable
//
//  Created by cocoa_niu on 2018/11/21.
//  Copyright © 2018年 com.cocoa_niu. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"


#define UI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;   //反向列表
@property (nonatomic, strong) NSMutableArray *dataArray; //数据源

@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.backgroundColor = [UIColor cyanColor];
    scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT * 2);
    [self.view addSubview:scrollView];
    
    //初始化数据源
    self.dataArray = [NSMutableArray array];
    
    self.count = 0;
    
    //添加反向列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44 * 3 - 49, self.view.frame.size.width, 44 * 3) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.transform = CGAffineTransformMakeScale(1, -1);
    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"test_cell"];
    [self.view addSubview:self.tableView];
    
    //构造假数据
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(p_addMessage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    NSTimer *timer2 = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(p_addMessage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:NSRunLoopCommonModes];
    
    //关闭定时器
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [timer invalidate];
        [timer2 invalidate];
    });
}


#pragma mark - 私有操作

#pragma mark - 数据源操作
- (void)p_addMessage {
    if (self.dataArray.count >= 3) {
        [self p_removeMessage:[NSIndexPath indexPathForRow:2 inSection:0]];
        [self.dataArray insertObject:[NSString stringWithFormat:@"消息进入%ld～",self.count++] atIndex:0];
        [self p_addCell:[NSIndexPath indexPathForRow:0 inSection:0]];
    } else {
        [self.dataArray insertObject:[NSString stringWithFormat:@"消息进入%ld～",self.count++] atIndex:0];
        [self p_addCell:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
}

- (void)p_removeMessage:(NSIndexPath *)indexPath {
    [self.dataArray removeObjectAtIndex:indexPath.row];
    TestTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"remove---%@",cell.bgLabel.text);
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationRight)];
}

#pragma mark - UI操作
- (void)p_addCell:(NSIndexPath *)indexPath {
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationRight)];
    TestTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"add---%@",cell.bgLabel.text);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(p_removeIndexCell:) object:cell];
    [self performSelector:@selector(p_removeIndexCell:) withObject:cell afterDelay:2.0];
}

- (void)p_removeIndexCell:(TestTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath) {
        [self p_removeMessage:indexPath];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test_cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.bgLabel.text = [NSString stringWithFormat:@"%@——————————",self.dataArray[indexPath.row]];
    cell.contentView.transform = CGAffineTransformMakeScale(1, -1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
