//
//  Brain.m
//  Ra-iOS
//
//  Created by Joe Blau on 8/3/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

#import "Brain.h"
#include <opencv2/opencv.hpp>

@implementation Brain {
  NSMutableArray *targetValue;
  NSMutableArray *featureVector;

  NSMutableDictionary *smartZone;
  NSMutableDictionary *results;
  CvSVM SVM;
}


- (id)init {
  self = [super init];
  if (self) {
    // Load data from system memory
    // load initial values
//    targetValue = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:-1.0], nil];
//    featureVector = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:0.0], nil];
    
    targetValue = [[NSMutableArray alloc] init];
    featureVector = [[NSMutableArray alloc] init];
    
    smartZone = [[NSMutableDictionary alloc] init];
    results = [[NSMutableDictionary alloc] init];
  }
  return self;
}



- (void)learn:(float)beaconZone proxmity:(float)proximity on:(BOOL)isOn r:(float)red g:(float)g b:(float)b {
  [targetValue addObject:@[[NSNumber numberWithBool:isOn]]];
  [featureVector addObject: @[[NSNumber numberWithFloat:beaconZone], [NSNumber numberWithFloat:proximity] ]];
}

- (void)train {
  int targetCount = (int)[targetValue count];
  float labels[targetCount][1];
  for (int i=0; i<targetCount; i++) {
    for (int j=0; j<1; j++) {
      labels[i][j] = [[[targetValue objectAtIndex: i] objectAtIndex:j] floatValue];
    }
  }
  
  int featureCount = (int)[featureVector count];
  float trainingData[featureCount][1];
  for (int i=0; i<featureCount; i++) {
    for (int j=0; j<1; j++) {
      trainingData[i][j] = [[[featureVector objectAtIndex: i] objectAtIndex:j] floatValue];
    }
  }
  
  cv::Mat labelsMat      ((int)targetValue.count, 1, CV_32FC1, labels);
  cv::Mat trainingDataMat((int)featureVector.count, 2, CV_32FC1, trainingData);

  CvSVMParams params;
  params.svm_type    = CvSVM::C_SVC;
  params.kernel_type = CvSVM::LINEAR;
  params.term_crit   = cvTermCriteria(CV_TERMCRIT_ITER, 100, 1e-6);
  
  if (featureVector.count > 1) {
    SVM.train(trainingDataMat, labelsMat, cv::Mat(), cv::Mat(), params);
  }
}

- (float)decide:(float)beaconZone proxmity:(float)proximity {
  if (SVM.get_var_count() <= 0) return -10.0;
  
  cv::Mat sampleMat = (cv::Mat_<float>(1,2) <<  beaconZone, proximity);
  float response = SVM.predict(sampleMat);
  return response;
}
@end
