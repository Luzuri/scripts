#!/bin/bash

echo 'create "unai","c1","c2" ' | hbase shell
echo 'put "unai","1","c1:name","raju"' | hbase shell
echo 'put "unai","1","c1:city","hyderabad"' | hbase shell
echo 'put "unai","1","c1:designation","manager"' | hbase shell
echo 'put "unai","1","c1:salary","50000"' | hbase shell
