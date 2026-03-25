#!/usr/bin/env bash
# Test script to verify blocky DNS blocking functionality

echo "=== Testing Blocky DNS Blocking ==="

# Test 1: Check if blocky service is running
echo -e "\n1. Checking blocky service status:"
systemctl is-active blocky || echo "Blocky service is not running"

# Test 2: Check if Redis is running (required for caching)
echo -e "\n2. Checking Redis service status:"
systemctl is-active redis || echo "Redis service is not running"

# Test 3: Test DNS resolution through blocky
echo -e "\n3. Testing DNS resolution:"
echo "Testing google.com (should resolve):"
nslookup google.com 127.0.0.1

echo -e "\nTesting doubleclick.net (should be blocked):"
nslookup doubleclick.net 127.0.0.1

echo -e "\nTesting blocked custom domain (fextralife.com):"
nslookup fextralife.com 127.0.0.1

# Test 4: Check blocky metrics endpoint
echo -e "\n4. Testing blocky web interface:"
curl -s http://localhost:4000 | head -20 || echo "Could not reach blocky web interface"

# Test 5: Check Prometheus metrics
echo -e "\n5. Testing Prometheus metrics:"
curl -s http://localhost:4000/metrics | head -10 || echo "Could not reach metrics endpoint"

echo -e "\n=== Test Complete ==="
