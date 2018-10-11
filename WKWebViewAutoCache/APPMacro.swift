//
//  APPMacro.swift
//  ShopProject-Swift
//
//  Created by grx on 2018/9/4.
//  Copyright © 2018年 grx. All rights reserved.
//

import Foundation
import UIKit

let mainWindow: UIWindow = ((UIApplication.shared.delegate?.window)!)!

let Main_Screen_Width = UIScreen.main.bounds.width
let Main_Screen_Height = UIScreen.main.bounds.height

/*代替之前的49*/
let kTabBarHeight: CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20.0 ? 83.0:49.0)
/** 判断是否iphoneX系列 */
let iPhoneXS = (mainWindow.safeAreaInsets.bottom > 0.0) ? true:false

let NaviBarHeight:CGFloat = (iPhoneXS ? 88 : 64)
let StatusBarHeight:CGFloat = (iPhoneXS ? 44 : 20)
let SafeBottomMargin:CGFloat = (iPhoneXS ? 34 : 0)
let YC_TabbarHeight:CGFloat = (iPhoneXS ? 83 : 49)


/*全屏幕高度*/
let Screen_Height = Main_Screen_Height+NaviBarHeight+SafeBottomMargin

/*! 屏幕比适配宽高 */
func kWidth(R:CGFloat)->CGFloat{
    let nowR = R*(Main_Screen_Width)/375
    return nowR
}

// MARK: ---- 生成颜色
/// 根据RGBA生成颜色(格式为：22,22,22,0.5)
var gof_RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}
/// 根据RGB生成颜色(格式为：22,22,22)
var gof_RGBColor: (CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1);
}
/// 根据色值生成颜色(无透明度)(格式为0xffffff)
var gof_ColorWithHex: (NSInteger) -> UIColor = {hex in
    return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hex & 0xFF)) / 255.0, alpha: 1);
}

// MARK: ---- 三大色调
let YCColorWhite = gof_ColorWithHex(0xFFFFFF);     // 主色调，白色
let YCColorBlack = gof_ColorWithHex(0x2D2D2D);   // 主色调，纯黑色
let YCColorLightBlack = gof_ColorWithHex(0x7A7A7A);   //  浅黑色
let YCColorTitleBlack = gof_ColorWithHex(0x666666);   // 主色调，标题黑色

let YCColorLight = gof_ColorWithHex(0xF2F4F6);   //全局灰色
let YCColorDarkLight = gof_ColorWithHex(0xA6A6A6);   //全局深灰色
let YCColorBlue = gof_ColorWithHex(0x309FFF);   //全局浅蓝色
let YCColorDarkBlue = gof_ColorWithHex(0x3A69EF);   //全局深蓝色
let YCColorRed = gof_ColorWithHex(0xFF2633);   //全局红色

let YCColorLoginLine = gof_ColorWithHex(0xDCE1ED);   //登录分割线


public let YC_FontColor_LightGray =  gof_RGBAColor(152 , 152 , 163 , 1);
public let YC_FontColor_DarkGray =  gof_RGBAColor(122 , 122 , 122 , 1);
public let YC_FontColor_45Dark =  gof_RGBAColor(45 , 45 , 45 , 1);
public let YC_FontColor_102Gray = gof_RGBAColor(102,102,102,1);
public let YCBackground_LightColor = gof_RGBAColor(245 , 246 , 248 , 1);

public let YC_Color_DarkBlue = gof_RGBAColor(72 , 153 , 240 , 1);
public let YC_Color_LightBlue = gof_RGBAColor(229 , 241 , 254 , 1);
public let YC_Color_LightPink = gof_RGBAColor(255 , 234 , 235 , 1);
public let YC_Color_DarkPink = gof_RGBAColor(251 , 82 , 88 , 1);
public let YC_Color_DarkGreen = gof_RGBAColor(55 , 145 , 40 , 1);
public let YC_Color_LightGreen = gof_RGBAColor(200 , 237 , 194 , 1);
public let YC_Color_Yellow = gof_RGBAColor(255 , 239 , 56 , 1);
public let YC_Color_Red = gof_RGBAColor(255 , 38 , 51 , 1);
public let YC_Color_DDarkBlue = gof_RGBAColor(39 , 111 , 188 , 1);


//字体
var YC_FONT_PFSC_Semibold: (CGFloat) -> UIFont = {size in
    return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
}
var YC_FONT_PFSC_Medium: (CGFloat) -> UIFont = {size in
    return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
}
var YC_FONT_PFSC_Regular: (CGFloat) -> UIFont = {size in
    return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
}
var YC_FONT_PFSC_Light: (CGFloat) -> UIFont = {size in
    return UIFont(name: "PingFangSC-Light", size: size) ?? UIFont.systemFont(ofSize: size)
}
//富文本设置行间距
var YC_FONT_RowSpacing :(CGFloat , UIFont , String) -> NSAttributedString = { size, font, str in
    //通过富文本来设置行间距
    let paraph = NSMutableParagraphStyle()
    //将行间距设置为28
    paraph.lineSpacing = size
    //样式属性集合
    let attributes = [NSAttributedString.Key.font:font,
                      NSAttributedString.Key.paragraphStyle: paraph]
    return NSAttributedString(string: str, attributes: attributes)
}

//
var getTextHeigh :(String , UIFont , CGFloat) -> CGFloat = {str, font, width in
    let normalText: String = str
    let size = CGSize(width: width, height: 10000)
    let attributes = [NSAttributedString.Key.font : font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let stringSize:CGRect = normalText.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    return stringSize.height
}

var getTextWidth :(String , UIFont , CGFloat) -> CGFloat = {str, font, height in
    let normalText: String = str
    let size = CGSize(width: 10000, height: height)
    let attributes = [NSAttributedString.Key.font : font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let stringSize:CGRect = normalText.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    return stringSize.width
}

var getTextSize :(String , UIFont , CGFloat) -> CGRect = {str, font, height in
    let normalText: String = str
    let size = CGSize(width: 10000, height: height)
    let attributes = [NSAttributedString.Key.font : font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let stringSize:CGRect = normalText.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    return stringSize
}


// MARK: ---- 打印日志
/**
 打印日志
 - parameter message: 日志消息内容
 */
func printLog<T>(message: T)
{
    #if DEBUG
    print("\(message)");
    #endif
}

// 客服电话
let YCKeFUPhone = "4007658376"


