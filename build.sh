#!/bin/bash
##
#
# build.sh
#
# Dark, dark place. You know better.
#
##

CXX=g++
CXXFLAGS="-g -std=gnu++14 -I."
LDFLAGS="-ll"
BISON=bison
FLEX=flex

$BISON -d ExpressionParser.yy
$FLEX ExpressionScanner.l

$CXX $CXXFLAGS -c ExpressionParserContext.cc
$CXX $CXXFLAGS -c ExpressionScanner.c
$CXX $CXXFLAGS -I. -c ExpressionParser.tab.cc
$CXX $CXXFLAGS -I. -ll -c Expression.cc
$CXX $CXXFLAGS -I. -ll -c ExpressionBuilder.cc
$CXX $CXXFLAGS -I. -ll -c ExpressionContext.cc
$CXX $CXXFLAGS -I. -ll -c Type.cc
$CXX $CXXFLAGS -I. -ll -c main.cc
$CXX -o r main.o Expression.o ExpressionBuilder.o ExpressionContext.o ExpressionScanner.o ExpressionParser.tab.o ExpressionParserContext.o Type.o $LDFLAGS
