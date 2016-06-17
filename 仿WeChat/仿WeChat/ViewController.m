//
//  ViewController.m
//  键盘遮挡控件
//
//  Created by wyzc on 16/1/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (IBAction)tap:(UIButton *)sender {
    NSString * path=[[NSBundle mainBundle]pathForResource:@"a" ofType:@"png"];
    UIImage * image=[UIImage imageWithContentsOfFile:path];
    image=[image stretchableImageWithLeftCapWidth:40 topCapHeight:45];
    self.imageView.image=image;
    self.imageView.frame=CGRectMake(0, 0, 200, 300);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    //判断是否需要移动视图
    CGFloat height=self.view.bounds.size.height-self.text.bounds.size.height-self.text.frame.origin.y;
    CGFloat offset=height-deltaY;
    if(offset<0)
    {
        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            self.view.transform=CGAffineTransformMakeTranslation(0, offset);
        }];
    }
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.text resignFirstResponder];
}
@end
