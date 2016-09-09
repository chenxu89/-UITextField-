//
//  ViewController.m
//  OCtest
//
//  Created by chenxu on 16/8/26.
//  Copyright © 2016年 chenxu. All rights reserved.
//

#import "ViewController.h"

typedef enum{
    kTag_Edit_Price = 523,//委托价格
    kTag_Edit_Volume = 524,//委托数量
}kTag_Edit;

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *volumeTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.volumeTextField.delegate = self;
    self.volumeTextField.tag = kTag_Edit_Volume;
    self.volumeTextField.keyboardType = UIKeyboardTypeAlphabet;
    self.priceTextField.delegate = self;
    self.priceTextField.tag = kTag_Edit_Price;
    self.priceTextField.keyboardType = UIKeyboardTypeAlphabet;
}
//限制textField只能输入正确的金额数据
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == kTag_Edit_Volume) {//只能输入整数
        if (string.length == 0) return YES;//回退
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if (single >='0' && single<='9'){//数据格式正确"0123456789"
            if([textField.text length]==0 && single == '0'){//输入首位不能为小数点
                return NO;
            }
        }else{//输入的数据格式不正确
            return NO;
        }
        return YES;
    }
    
    if(textField.tag == kTag_Edit_Price)//只能输入小数
    {
        if (string.length == 0) return YES;//回退
        BOOL isHaveDian = YES;
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            isHaveDian = NO;
        }
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确"0123456789."
        {
            if([textField.text length]==0){//输入首位不能为小数点
                if(single == '.'){
                    return NO;
                }
            }
            if([textField.text length]==1 && [textField.text isEqualToString:@"0"]){//如果首位为0，后面仅能输入小数点
                if(single != '.'){
                    return NO;
                }
            }
            if (single=='.' && isHaveDian)//小数点不能输入超过一个
            {
                return NO;
            }
        }else{//输入的数据格式不正确
            return NO;
        }
        return YES;
    }
    
    return YES;
}
@end
