# ZLDropdownMenu
此版本为初版，后续将添加更多功能，使用了Masonry进行布局

##效果图
![demo](https://raw.githubusercontent.com/sunnyzl/ZLDropdownMenu/master/demo.gif)

##使用方法
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

    