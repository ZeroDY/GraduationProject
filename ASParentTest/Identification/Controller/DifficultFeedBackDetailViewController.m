//
//  DifficultFeedBackDetailViewController.m
//  ASParentTest
//
//  Created by 张浩 on 15/11/21.
//  Copyright © 2015年 周德艺. All rights reserved.
//

#import "DifficultFeedBackDetailViewController.h"

@interface DifficultFeedBackDetailViewController ()

@end

@implementation DifficultFeedBackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的问题";
    
    self.questionTitleImg.layer.masksToBounds = YES;
    self.questionTitleImg.layer.cornerRadius = self.questionTitleImg.frame.size.width/2;
    
    
    self.solutionTitleImg.layer.masksToBounds = YES;
    self.solutionTitleImg.layer.cornerRadius = self.questionTitleImg.frame.size.width/2;
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.questionInfoLab.text = @"我以前觉得自己容易发怒而伤害到身边人的感情，最近想明白其实并不是自己易怒而是没有恰当的表达自己的愤怒。我平时是个很温和的人，温和到连小孩子都知道欺负我。所以当我的愤怒以一种激烈而失控的方式表现出来的时候，所有人会被吓到。很多人会告诉我不要生气、为人要宽容云云。但我觉得愤怒是人类最原始的情绪之一，是正常的情绪，也许是要对伤害自己的事情说“不，也许说不清什么原因。所以我觉得“我不高兴”这样的事情应该要表达出来。但是怎样表达才会比较恰当，能帮助自己成长能帮助彼此改善关系呢？求解答。";
    self.solutionInfoLab.text = @"心理学上，我曾自己总结过几种愤怒的情境：当利益受损的时候；当期望受挫的时候（主要）；当被忽略的时候；当嫉妒别人的时候；当觉得自己被侵犯的时候（个人规范）；当觉得他人被侵犯的时候（社会规范）；大部分情况下，愤怒只是一种次级感受（secondary feeling），与悲伤，羞耻等构成情绪群（cluster）。用通俗的话来讲，愤怒不是核心感受，当我们期望受挫的时候，我们希望自己得到尊重却受到侮辱，我们希望自己被肯定却遭遇贬低，这种情况下我们的原始感受是受到伤害（如果归因到他人故意，会加剧愤怒）而产生的悲伤，焦虑。对于大部分人来说，感受和承认这种悲伤并不容易，也不安全，因为这往往意味着自己的脆弱，还会引发一些对自身的焦虑，“我好没用，对方这样就伤害了我”；甚至还会自责，“我怎么可以因为这个就生气呢”。这样的知觉本身还有另外一层含义，如果我们分享这种脆弱，委屈，别人会不会认可我们？会不会同情我们？会不会离我们而去？这时，愤怒作为一种防御姿态，由自己指向别人，保护了我们的脆弱和委屈，也阻止别人进入我们的内心，甚至连自己都不知道生气的缘由。那些温和的人有着一套逻辑，「’我都已经这样忍让了，对方应该会适可而止」。这样的逻辑本身又包含着一个期望，「我希望别人理解我」，当别人未能表达这种理解的时候，期望会再次受挫。如果认为是自己的忍让换来对方的变本加厉，“一定是我太过温和，温和到xx都会欺负我”。这里面还隐藏着一个不合理的信念：「理解自己是别人的事情」，这样就把原因归结到自己的温和，换而言之，也认定了对方的铁石心肠。不仅如此，很多时候这些人还会开始怀疑自己的这套温和的行为模式是否正确，采取的策略就是经常性的表达愤怒，周围人的避让会让自己的地位得到无形的提高，获得心理优势，从而补偿了自己的悲伤，避免了自己的恐惧。知觉到这一层面非常关键，不要单纯的表达愤怒，更要坚定地表达愤怒背后隐藏着的委屈，焦虑本身，因为表达这些本身就是一种让别人了解自己底线的过程，这个过程中最好指着自己（我怎样怎样），而不要指着别人（你怎样怎样），不要对别人做价值判断。但比这更重要的是，一个合理信念的树立“让别人理解自己，这是自己的责任”和一个合理期望的养成“即使我表达了自己，别人不一定会理解自己”，以及时时刻刻接纳自己的准备。";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
