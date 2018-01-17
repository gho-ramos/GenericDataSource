//
//  GenericDataSource.h
//  GenericDataSource
//
//  Created by Guilherme on 1/17/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ConfigurationBlock) (id cell, id item);

@interface GenericDataSource : NSObject <UITableViewDataSource>

-(instancetype)initWithItems:(NSArray*)items cellIdentifier:(NSString*)aCellIdentifier configurationBlock:(ConfigurationBlock)configurationBlock;

-(instancetype)initWithItems:(NSArray*)items cellIdentifier:(NSString*)aCellIdentifier sectionKey:(NSString*)aSectionKey configurationBlock:(ConfigurationBlock)configurationBlock;

-(id)itemAtIndexPath:(NSIndexPath*)indexPath;

@end
