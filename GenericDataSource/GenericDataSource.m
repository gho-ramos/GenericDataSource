//
//  GenericDataSource.m
//  GenericDataSource
//
//  Created by Guilherme on 1/17/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

#import "GenericDataSource.h"

@interface GenericDataSource()

@property (nonatomic) BOOL hasSections;
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, copy) NSString * cellIdentifier;
@property (nonatomic, copy) NSString * sectionKey;
@property (nonatomic, copy) ConfigurationBlock configurationBlock;

@end

@implementation GenericDataSource

-(instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)aCellIdentifier configurationBlock:(ConfigurationBlock)configurationBlock {
    return [self initWithItems:items cellIdentifier:aCellIdentifier sectionKey:nil configurationBlock:configurationBlock];
}


-(instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)aCellIdentifier sectionKey:(NSString *)aSectionKey configurationBlock:(ConfigurationBlock)configurationBlock {
    self = [super init];
    if (self) {
        self.items = items;
        self.sectionKey = aSectionKey;
        self.cellIdentifier = aCellIdentifier;
        self.configurationBlock = [configurationBlock copy];

        self.hasSections = (self.items.count > 0 && [self.items[0] isKindOfClass:[NSArray class]]);
    }
    return self;
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.hasSections) {
        return self.items[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
    }
    return self.items[(NSUInteger)indexPath.row];
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hasSections) {
        return self.items.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.hasSections) {
        return [self.items[(NSUInteger)section] count];
    }
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                             forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configurationBlock(cell, item);
    return cell;
}

@end


