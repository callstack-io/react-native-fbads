/**
 * AdsManager.js
 * react-native-fbads
 *
 * Created by Mike Grabowski on 24/09/16.
 * Copyright © 2016 Callstack.io. All rights reserved.
 */

import {
  NativeModules,
  NativeAppEventEmitter,
} from 'react-native';

const { CTKNativeAdManager: NativeAdManager } = NativeModules;

/**
 * Proxy to `FBNativeAdsManager`
 */
class AdsManager {

  // Initial value of the native ads manager. True, if ads are available straight away
  isValid: Boolean = NativeAdManager.isValid;

  // Called for the first time ads are loaded. Native manager will keep calling the
  // below event for every chunk of native ads loaded, however we are only
  // interested in the first part. This function will automatically deregister itself
  // after its first invocation.
  onAdsLoaded = (func: () => void) => {
    const sub = NativeAppEventEmitter.addListener('CTKNativeAdManagerDidLoad', () => {
      func();
      sub.remove();
    });

    return () => sub.remove();
  }
}

const inst = new AdsManager();

inst.onAdsLoaded(() => {
  inst.isValid = true;
});

export default inst;
