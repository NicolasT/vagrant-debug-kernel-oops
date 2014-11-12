#!/bin/bash -xue

echo "Test script running!"
sleep 1
echo "Test fails, triggering kernel oops"
sudo bash -c 'echo c > /proc/sysrq-trigger'
echo "Test survived anyway?!"
exit 1
