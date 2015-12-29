//
//  RecBookDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/22.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "RecBookDetailViewController.h"

@interface RecBookDetailViewController ()

@end

@implementation RecBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"推荐详情";
}
-(void)viewWillAppear:(BOOL)animated{
    self.titleLab.text = @"逻辑思维:迷茫时代的明白人";
    self.titleInfoLab.text = @"《罗辑思维》首次充分集中表达成长的洞见：一切坚固的东西都将烟消云散，个人崛起的时代已经到来。本书精选罗振宇的诸多思考，与你分享成长的洞见。";
    
    self.infoTitleLab.text = @"简介";
    self.infoLab.text = @"书名:迷茫时代的明白人 作者:罗振宇 ISBN 9787550257870 类别:成功心理－通俗读物 页数:312 定价:42 出版社:北京联合出版公司 出版时间:2015-8 装帧:平装 开本:16";
    
    self.contentTitleLab.text = @"内容推荐";
    self.contentLab.text = @"年轻的你为感情的波折苦恼，工作的迷茫让你忧虑，生活上的变故让你不快，你心急火燎，却又手足无措，觉得自己被世界抛弃。你急于逞强，弄巧成拙，迷茫无助，却不知道人生中时间自会为你疗伤。痛就痛，苦就苦，就让它痛，就让它苦。只有莫名哭过，才明白青春。只有经历痛楚，才领悟成长。20余篇触动泪腺的暖心励志故事，多幅温馨的创意插图，随着作者陈亚豪的细腻戳心的字句，扑面而来，让你拥抱曾经，直面未来。愿你在脆弱和迷茫中学会坚强。愿你永远无畏时光，给自己疗伤。书中语录：1） 发现了吗，长大后，爱一个人的表现不再是不顾一切，而是卸下防备。2）你那么擅长安慰他人，一定度过了很多自己安慰自己的日子吧。3） 希望你永远傻呵呵，会因为一件喜欢的新衣开心一整天，因为一顿美食一扫阴霾，因为一首好歌原谅世界。4）后来明白，我们永远无法成为别人满意的那个自己，可如果坚持做喜欢的自己，终会遇见喜欢你的人。其实到最后，我们都是在寻找同类，就像溪流汇入江海，光束拥抱彩虹。5）终有一天会出现一个人，让你像流沙，像落雪，那些别人在上面划了又划的痕迹，他轻轻一抹，就平了。你要好好的等他。6）所失去的，岁月并不会以另一种方式补偿。得到补偿的人，都是在时间里，用更好的自己去重逢。7）你知道的，所有过错后来都可以用错过来释怀，人生不管可以重来多少次，终会有所遗憾。8）累了就去吃顿美食，不开心时就做些有趣的事，与其渴望他人的理解和安慰，不如自己做自己的知己。终要学会一个人度过生命里的每个寒冬，自己来温暖自己，自己来治愈自己，自己来给自己力量和勇气，不是冷漠也不是清高，只是越来越觉得别人能给你的，自己都可以给自己。9）真正的放下大概是，你不会删除他的聊天记录，也不会把他拉入黑名单，只是任由他躺在通讯录里，再也懒得去点开。他像你掉进床底的笔，扔在地铁站的水，决定不要了，就再不会想起。他留下的那些痕迹就像家中沙发缝的灰，油烟机上的渍，你不会为它特意来次大扫除，只是心情好时，顺手一擦。10）世界一直都是现实残酷的，我们谁都没有权利选择出生在一个怎样的家庭，生活在一个怎样的社会，但是你能选择成为一个怎样的人，这是在这个世界上我们唯一握在手里的一点权利，你不能放弃。";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
