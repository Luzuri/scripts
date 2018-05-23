#!/bin/bash

echo 'create "unai2",{NAME => "f1", VERSIONS => 5},{NAME => "f2", VERSIONS => 5} ' | hbase shell
echo 'put "unai2","1","f2:name","raju"' | hbase shell
echo 'put "unai2","1","f2:city","hyderabad"' | hbase shell
echo 'put "unai2","1","f2:designation","manager"' | hbase shell
echo 'put "unai2","1","f1:salary","50000"' | hbase shell
echo 'put "unai2","1","f1:salary","40000"' | hbase shell
echo 'put "unai2","1","f1:salary","30000"' | hbase shell
echo 'put "unai2","1","f1:salary","20000"' | hbase shell
echo 'put "unai2","1","f1:salary","10000"' | hbase shell
echo 'get "unai2","1",{COLUMN => "f1:salary", VERSIONS => 3}' | hbase shell
