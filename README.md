# ZLDropdownMenu 

---
This version is the original version, I will add more function for it in the future. You can use `ZLDropdownMenu` to set the condition what you want to filter. If you have any advice or problem, please [issue](https://github.com/sunnyzl/ZLDropdownMenu/issues) me.

![demo1](https://raw.githubusercontent.com/sunnyzl/ZLDropdownMenu/master/demo1.gif)

# Usage 

---  

First, you should set the datasource and delegate.  

```  
    ZLDropDownMenu *menu = [[ZLDropDownMenu alloc] init];
    [self.view addSubview:menu];
    menu.delegate = self;
    menu.dataSource = self;
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
```
Second, you should implement the corresponding method.  

```
- (NSInteger)numberOfColumnsInMenu:(ZLDropDownMenu *)menu;
- (NSInteger)menu:(ZLDropDownMenu *)menu numberOfRowsInColumns:(NSInteger)column;
- (NSString *)menu:(ZLDropDownMenu *)menu titleForColumn:(NSInteger)column;
- (NSString *)menu:(ZLDropDownMenu *)menu titleForRowAtIndexPath:(ZLIndexPath *)indexPath;
- (void)menu:(ZLDropDownMenu *)menu didSelectRowAtIndexPath:(ZLIndexPath *)indexPath;
```
if you wanna change the UI, plese reset `ZLDropDownMenuUICalc` 、`ZLDropDownMenuTitleButton` and `ZLDropDownMenuCollectionViewCell`.

# ZLDropdownMenu

---
此版本为初版，后续将添加更多功能，使用了Masonry进行布局

#效果图

![demo](https://raw.githubusercontent.com/sunnyzl/ZLDropdownMenu/master/demo.gif)

#使用方法

---
    ZLDropDownMenu *menu = [[ZLDropDownMenu alloc] init];
    [self.view addSubview:menu];
    menu.delegate = self;
    menu.dataSource = self;
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    遵守代理ZLDropDownMenuDelegate和数据源ZLDropDownMenuDataSource，并按照ViewController中设置即可，使用方法和UITableview相似

    