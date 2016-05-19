// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"

@implementation QCViewController
@synthesize dataSrc;
@synthesize titleMsg;

#pragma mark -
#pragma mark UIViewController override
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化表的数据
    dataSrc     = [[NSMutableArray alloc] initWithCapacity:0];
    titleMsg    = [@"没有动作" retain];
    
    //
    //对表数据进行监视
    // 
                //谁来监视，KVO的监视回调函数就调用谁
    [self addObserver:self
                //监视的键的路径，我们这里属性由于只有一层，所以直接写dataSrc
           forKeyPath:@"dataSrc" 
                //需要知道表数据改动时的新旧数据，方便我们研究。如果不需要，可以置0
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                //KVO触发时，我们收到的额外信息，如果不需要可以置nil
              context:@"testCotent"];
    
    [self addObserver:self
           forKeyPath:@"titleMsg" 
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:@"testCotent"];
    
    //右边的按钮
    //我们放增加
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                               target:self
                                                                               action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    //左边的按钮，我们放编辑，主要提供删除功能
    //初始化没有数据，所以我们disable掉
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.editButtonItem.title = @"编辑";
    
    //标题
    self.navigationItem.title = titleMsg;
}

- (void)viewDidUnload
{
    [super viewDidUnload];    
    [_tbv release];
}

- (void)dealloc
{
    //移除KVO
    [self removeObserver:self
              forKeyPath:@"dataSrc"];
    [self removeObserver:self
              forKeyPath:@"titleMsg"];
    
    [dataSrc release];
    [titleMsg release];
    [super dealloc];
}

#pragma mark -
#pragma mark Action
//导航栏上增加按钮的调用方法
- (void)add
{
    //我们打算设置一个静态整型记录当前的排序值.
    static int myIndex = 0;
    
    //每次进来，我们就把当前的排序值作为新增的对象
    //所以调用KVO提供的新增接口
    [self insertObject:[NSString stringWithFormat:@"%d", myIndex]
      inDataSrcAtIndex:[self countOfDataSrc]];
    
    //排序值+1
    myIndex++;
    
    self.titleMsg = [NSString stringWithFormat:@"新增：[%d]", myIndex];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //UIViewController提供的editButtonItem默认会调用此方法。
    //所以我们重写此方法，第一步就是让表视图变成编辑状态，供我们删除内容用
    [_tbv setEditing:editing
            animated:animated];
    
    //第二步让super继续操作
    //目的是不改变UIViewController对于editButtonItem原有的动作
    //如果不加，那就是等于我们将这个方法截获了。
    //直接的效果不同体现在：editButtonItem不会在Edit状态和Done状态之间切换
    [super setEditing:editing 
             animated:animated];
    
    if (editing) {
        self.editButtonItem.title = @"完成";
    }
    else {
        self.editButtonItem.title = @"编辑";
    }
}

#pragma mark -
#pragma mark KVO
//
//KVO对于一对多的属性需要我们提供的的接口
//

//集合属性的个数
- (NSUInteger)countOfDataSrc {
    return [dataSrc count];
}

//集合属性的新增动作
- (void)insertObject:(id)anObject 
    inDataSrcAtIndex:(NSUInteger)idx 
{
    [dataSrc insertObject:anObject
                  atIndex:idx];
}

//集合属性的取值动作
- (id)objectInDataSrcAtIndex:(NSUInteger)idx {
    return [dataSrc objectAtIndex:idx];
}

//集合属性的删除动作
- (void)removeObjectFromDataSrcAtIndex:(NSUInteger)idx {
    [dataSrc removeObjectAtIndex:idx];
}

#pragma mark -
#pragma mark KVO Delegate
//
//KVO监视某个属性时，当属性发生变化会收到此回调
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"titleMsg"]) {
        [self handleTitleChangeofObject:object
                                 change:change
                                context:context];
        return;
    }
    
    
    NSInteger   changeRow   = 0;
    //NSKeyValueChangeIndexesKey信息中记录了集合属性改变位置等重要信息
    NSIndexSet  *indices    = [change objectForKey:NSKeyValueChangeIndexesKey];
    if (indices) {
        //我们每次只改集合中的一处地方，所以我们可以用firstIndex来简单地取出改变的地方
        //如果是多处地方遭到修改，需要使用NSIndexSet提供的getIndexes方法。
        changeRow = indices.firstIndex;
    }
    
    //制作NSIndexPath，为了提供给表视图进行UI更新
    NSIndexPath *changeIndexPath = [NSIndexPath indexPathForRow:changeRow
                                                      inSection:0];
    
    
    //NSKeyValueChangeKindKey信息中记录了监视属性的值变化类型
    NSNumber *kind = [change objectForKey:NSKeyValueChangeKindKey];
    switch ([kind intValue]) {
        //新增
        case NSKeyValueChangeInsertion:
            //此新增方法后，表视图会重绘
            [_tbv insertRowsAtIndexPaths:[NSArray arrayWithObject:changeIndexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
            break;
        //删除
        case NSKeyValueChangeRemoval:
            //此删除方法后，表视图会重绘
            [_tbv deleteRowsAtIndexPaths:[NSArray arrayWithObject:changeIndexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
        default:
            break;
    }

    //
    //控制“编辑”按钮
    //
    //如果表数据有记录
    if ([self countOfDataSrc] > 0) {
        //让“编辑”按钮可用
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }
    else {
        //让“编辑”按钮不可用，并且遵循UIViewController对于不可用时的UI处理（比如变成Edit等）
        [self setEditing:NO
                animated:YES];
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }
}

//更新界面标题
- (void)handleTitleChangeofObject:(id)object
                           change:(NSDictionary *)change 
                          context:(void *)context {
    self.navigationItem.title = titleMsg;
}


//
//表视图的代理方法
#pragma mark -
#pragma mark TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self countOfDataSrc];
}

#pragma mark TableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [self objectInDataSrcAtIndex:[indexPath row]];
    return cell;
}


//表视图的代理方法
//当我们在编辑状态，删除记录时，会进入此回调方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
        self.titleMsg = [NSString stringWithFormat:@"删除：[%d]", [indexPath row]];
        [self removeObjectFromDataSrcAtIndex:[indexPath row]];
}

@end
