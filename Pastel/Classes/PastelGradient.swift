//
//  PastelGradient.swift
//  Pods
//
//  Created by CruzDiary on 18/05/2017.
//  Gradient Designed by https://webgradients.com/
//  Github https://github.com/itmeo/webgradients :D

import UIKit

@objc public enum PastelGradient: Int {
    case warmFlame
    case nightFade
    case springWarmth
    case juicyPeach
    case youngPassion
    case ladyLips
    case sunnyMorning
    case rainyAshville
    case frozenDreams
    case winterNeva
    
    func colors() -> [UIColor] {
        switch self {
        case .warmFlame:
            return [#colorLiteral(red: 1, green: 0.6039215686, blue: 0.6196078431, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.8156862745, blue: 0.768627451, alpha: 1)]
        case .nightFade:
            return [#colorLiteral(red: 0.631372549, green: 0.5490196078, blue: 0.8196078431, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.7607843137, blue: 0.9215686275, alpha: 1)]
        case .springWarmth:
            return [#colorLiteral(red: 0.9803921569, green: 0.8156862745, blue: 0.768627451, alpha: 1), #colorLiteral(red: 1, green: 0.8196078431, blue: 1, alpha: 1)]
        case .juicyPeach:
            return [#colorLiteral(red: 1, green: 0.9254901961, blue: 0.8235294118, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.7137254902, blue: 0.6235294118, alpha: 1)]
        case .youngPassion:
            return [#colorLiteral(red: 1, green: 0.5058823529, blue: 0.4666666667, alpha: 1), #colorLiteral(red: 1, green: 0.5254901961, blue: 0.4784313725, alpha: 1), #colorLiteral(red: 1, green: 0.5490196078, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.568627451, blue: 0.5215686275, alpha: 1), #colorLiteral(red: 0.8117647059, green: 0.3333333333, blue: 0.4235294118, alpha: 1), #colorLiteral(red: 0.6941176471, green: 0.1647058824, blue: 0.3568627451, alpha: 1)]
        case .ladyLips:
            return [#colorLiteral(red: 1, green: 0.6039215686, blue: 0.6196078431, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8117647059, blue: 0.937254902, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8117647059, blue: 0.937254902, alpha: 1)]
        case .sunnyMorning:
            return [#colorLiteral(red: 0.9647058824, green: 0.8274509804, blue: 0.3960784314, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.6274509804, blue: 0.5215686275, alpha: 1)]
        case .rainyAshville:
            return [#colorLiteral(red: 0.9843137255, green: 0.7607843137, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.6509803922, green: 0.7568627451, blue: 0.9333333333, alpha: 1)]
        case .frozenDreams:
            return [#colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.9450980392, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.9450980392, alpha: 1), #colorLiteral(red: 0.9019607843, green: 0.8705882353, blue: 0.9137254902, alpha: 1)]
        case .winterNeva:
            return [#colorLiteral(red: 0.631372549, green: 0.768627451, blue: 0.9921568627, alpha: 1), #colorLiteral(red: 0.7607843137, green: 0.9137254902, blue: 0.9843137255, alpha: 1)]
        }
    }
}
