// ################################################################################//
//		文件名 : RMPlayerDM.m
// ################################################################################//
/*!
 @file		RMPlayerDM.m
 @brief		Real Madrid球队球员的Data Model
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCPickerViewController.h"

@implementation RMPlayerDM
@synthesize name = _name;
@synthesize number = _number;
@synthesize role = _role;

- (void)dealloc
{
    [_name release];
    [_number release];
    [_role release];
    
    [super dealloc];
}

@end

// ################################################################################//
//		文件名 : QCPickerViewController.m
// ################################################################################//
/*!
 @file		QCPickerViewController.m
 @brief		通用式样取值控件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
@implementation QCPickerViewController
@synthesize datasource = _datasource;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化界面
    [self initUI];
    
    //初始化球员数据
    [self initData];
    
    //初始化“取值控件”的选择内容
    [self showInfo:self.picker
        onRowIndex:0
       inComponent:0];
}

#pragma mark -
#pragma mark Init
- (void)initUI {
    self.title = @"皇家马德里";
}

- (void)initPlistData
{
    NSMutableArray  *arrPlayers = [NSMutableArray arrayWithCapacity:0];
    NSArray         *arrPlist   = nil;
    
    //读取工程中的球员信息plist
    arrPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rmroll"
                                                                                ofType:@"plist"]];
    
    RMPlayerDM  *onePlayer = nil;
    //将信息挨个解析到数据模型中
    for (NSDictionary *onePlayerInfo in arrPlist) {
        
        onePlayer           = [[[RMPlayerDM alloc] init] autorelease];
        onePlayer.name      = [onePlayerInfo objectForKey:@"name"];
        onePlayer.number    = [onePlayerInfo objectForKey:@"number"];
        onePlayer.role      = [onePlayerInfo objectForKey:@"role"];
        
        [arrPlayers addObject:onePlayer];
    }
    
    //数据源的赋值
    if (_datasource != nil) {
        [_datasource release];
    }
    _datasource = [[NSArray alloc] initWithArray:arrPlayers];
}

- (void)initData
{
    _currentRoleIndex = 0;
    [self initPlistData];
    
    //最终的新数据源
    NSMutableArray  *arrSectionDatasource = [NSMutableArray arrayWithCapacity:0];
    //记录着当前已经使用的段名
    NSMutableArray  *arrSection           = [NSMutableArray arrayWithCapacity:0];
    //临时存放一个段名下的所有球员对象
    NSMutableArray  *arrTmp               = [NSMutableArray arrayWithCapacity:0];
    
    //对于所有球员进行遍历
    for (RMPlayerDM *onePlayer in self.datasource) {
        NSString *role = onePlayer.role;
        
        //如果当前球员的role已经被作为段名制作好，则continue
        //也意味着当前球员已经被加入到最终数据源中
        if ([arrSection containsObject:role]) {
            continue;
        }
        
        //新的role
        //再次遍历球员
        for (RMPlayerDM *rolePlayer in self.datasource) {
            //如果当前球员属于当前新的role，则加到arrTmp中
            if ([rolePlayer.role isEqualToString:role]) {
                [arrTmp addObject:rolePlayer];
            }
        }
        
        //此role被作为一个段名，制作完成
        [arrSection addObject:role];
        
        //arrTmp中包含着所有满足当前role段名的球员对象
        //加到最终的数据源中
        [arrSectionDatasource addObject:arrTmp];
        
        //重置arrTmp
        //等待新的role将所有满足的球员对象加进来。
        arrTmp = [NSMutableArray arrayWithCapacity:0];
    }
    
    //重置数据源，进行赋值
    if(_datasource){
        [_datasource release];
    }
    _datasource = [[NSArray alloc] initWithArray:arrSectionDatasource];
}

#pragma mark -
#pragma mark Utility
- (void)showInfo:(UIPickerView *)pickerView
      onRowIndex:(NSInteger)row
     inComponent:(NSInteger)component
{
    NSUInteger  nRoleIndex      = [pickerView selectedRowInComponent:0];
    NSUInteger  nPlayerIndex    = [pickerView selectedRowInComponent:1];
    NSArray     *arrTmp         = nil;
    RMPlayerDM  *onePlayer      = nil;
    
    if (nRoleIndex < _datasource.count) {
        arrTmp = [_datasource objectAtIndex:nRoleIndex];
        if (nPlayerIndex < arrTmp.count) {
            onePlayer = [arrTmp objectAtIndex:nPlayerIndex];
        }
    }
    
    if (onePlayer) {
        self.info.text = [NSString stringWithFormat:@"我是%@:%@",
                          onePlayer.role,
                          onePlayer.name];
    }
    else{
        self.info.text = @"取值异常";
    }
}

#pragma mark -
#pragma mark UIPicker datasource
//几列？
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //一共有2列，左边为角色，右边为球员名
    return 2;
}

//每列多少行选项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray     *arrTmp     = nil;
    NSUInteger  roleIndex   = 0;
    switch (component) {
        case 0:
            //角色的个数也就是数据源的子数组元素的个数。
            return _datasource.count;
        case 1:
            //将当前的角色序号取出，得到相应的球员列表，返回球员列表个数。
            roleIndex   = [pickerView selectedRowInComponent:0];
            if (roleIndex >= _datasource.count) {
                return 0;
            }
            
            arrTmp = [_datasource objectAtIndex:roleIndex];
            return arrTmp.count;
        default:
            return 0;
    }
}

#pragma mark -
#pragma mark UIPicker delegate
//每列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            //角色列由于单次长度小，所以占的宽度较小
            return CGRectGetWidth(pickerView.frame)*2/5;
        case 1:
            //球员列由于单次长度大，所以占的宽度较大
            return CGRectGetWidth(pickerView.frame)*3/5;
        default:
            return 0.0f;
    }
}

//哪列第几行内容的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{       
    NSArray         *arrTmp     = nil;
    RMPlayerDM      *onePlayer  = nil;
    NSUInteger      roleIndex   = 0;
    
    switch (component) {
        case 0://角色列
            //row是多少就代表第几个数据源中的子数组
            arrTmp      = [_datasource objectAtIndex:row];
            if (!arrTmp || arrTmp.count == 0) {
                return  @"";
            }
            
            //由于每个子数组中的元素的role属性都一样，所以就取第一个元素即可。
            onePlayer   = [arrTmp objectAtIndex:0];
            
            //将需要显示到界面的role字符串返回
            return onePlayer.role;
            break;
        case 1://球员列
            roleIndex   = [pickerView selectedRowInComponent:0];
            if (roleIndex >= _datasource.count) {
                return @"";
            }
            
            //取出相应的球员列表
            arrTmp      = [_datasource objectAtIndex:roleIndex];
            //根据行数的参数信息，将对应的球员取出
            onePlayer   = [arrTmp objectAtIndex:row];
            if (!onePlayer) {
                return @"";
            }
            
            //考虑到宽度太小可能显示不全的问题，只以球员的姓作为标题
            arrTmp = [onePlayer.name componentsSeparatedByString:@" "];
            if (arrTmp && arrTmp.count >= 2) {
                return (NSString*)[arrTmp objectAtIndex:1];
            }
                        
            return onePlayer.name;
        default:
            return @"";
    }
}

//选中任何列的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        //选项没变化
        if (_currentRoleIndex == row) {
            return;
        }

        _currentRoleIndex = row;
        //更新右侧球员名单
        [pickerView reloadComponent:1];
    }
    
    //将当前整个选中的信息显示出来
    [self showInfo:pickerView onRowIndex:row inComponent:component];
}

@end
