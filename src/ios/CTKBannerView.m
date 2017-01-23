//
//  CTKBannerView.m
//  rn-fbads
//
//  Created by Michał Grabowski on 23/01/2017.
//  Copyright © 2017 callstack. All rights reserved.
//

@import FBAudienceNetwork;
#import "CTKBannerView.h"
#import "RCTUtils.h"

@interface CTKBannerView () <FBAdViewDelegate>

@end

@implementation CTKBannerView

- (void)setSize:(NSNumber *)size {
  _size = size;
  [self createViewIfCan];
}

- (void)setPlacementId:(NSString *)placementId {
  _placementId = placementId;
  [self createViewIfCan];
}

// Initialise BannerAdView as soon as all the props are set
- (void)createViewIfCan {
  if (!_placementId || !_size) {
    return;
  }
  
  FBAdView *adView = [[FBAdView alloc] initWithPlacementID:_placementId
                                                    adSize:kFBAdSizeHeight50Banner
                                        rootViewController:RCTPresentedViewController()];
  
  adView.frame = CGRectMake(0, 20, adView.bounds.size.width, adView.bounds.size.height);
  adView.delegate = self;
  
  [adView loadAd];
  
  [self addSubview:adView];
}

# pragma mark - FBAdViewDelegate

- (void)adViewDidClick:(FBAdView *)adView {
  _onPress(nil);
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error {
  _onError(RCTJSErrorFromNSError(error));
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView {}
- (void)adViewWillLogImpression:(FBAdView *)adView {}

@end
