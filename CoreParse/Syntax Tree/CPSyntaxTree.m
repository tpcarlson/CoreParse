//
//  CPSyntaxTree.m
//  CoreParse
//
//  Created by Tom Davie on 04/03/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "CPSyntaxTree.h"

@interface CPSyntaxTree ()

@property (readwrite,retain) CPRule *rule;
@property (readwrite,copy) NSArray *children;
@property (readwrite,copy) NSDictionary *tagValues;

@end

@implementation CPSyntaxTree

@synthesize rule;
@synthesize children;
@synthesize tagValues;

+ (id)syntaxTreeWithRule:(CPRule *)rule children:(NSArray *)children
{
    return [[[self alloc] initWithRule:rule children:children tagValues:[NSDictionary dictionary]] autorelease];
}

- (id)initWithRule:(CPRule *)initRule children:(NSArray *)initChildren;
{
    return [self initWithRule:initRule children:initChildren tagValues:[NSDictionary dictionary]];
}

+ (id)syntaxTreeWithRule:(CPRule *)rule children:(NSArray *)children tagValues:(NSDictionary *)tagValues;
{
    return [[[self alloc] initWithRule:rule children:children tagValues:tagValues] autorelease];
}

- (id)initWithRule:(CPRule *)initRule children:(NSArray *)initChildren tagValues:(NSDictionary *)initTagValues
{
    self = [super init];
    
    if (nil != self)
    {
        [self setRule:initRule];
        [self setChildren:initChildren];
        [self setTagValues:initTagValues];
    }
    
    return self;
}

- (id)init
{
    return [self initWithRule:nil children:[NSArray array] tagValues:[NSDictionary dictionary]];
}

- (void)dealloc
{
    [rule release];
    [children release];
    
    [super dealloc];
}

- (id)valueForTag:(NSString *)tagName
{
    return [tagValues objectForKey:tagName];
}

- (NSUInteger)hash
{
    return [[self rule] hash];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[CPSyntaxTree class]])
    {
        CPSyntaxTree *other = (CPSyntaxTree *)object;
        return [other rule] == [self rule] && [[other children] isEqualToArray:[self children]];
    }
    return NO;
}

- (NSString *)description
{
    NSMutableString *desc = [NSMutableString stringWithString:@"("];
    for (id obj in children)
    {
        [desc appendFormat:@"%@ ", obj];
    }
    [desc replaceCharactersInRange:NSMakeRange([desc length] - 1, 1) withString:@")"];
    return desc;
}

@end
