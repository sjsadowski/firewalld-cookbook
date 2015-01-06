#!/usr/bin/env bats

@test "port 993/tcp was added to permanent config" {
	run firewall-cmd --permanent --query-port=993/tcp
	[ "$status" -eq 0 ]
}

@test "port 993/tcp was added to runtime config" {
	run firewall-cmd --query-port=993/tcp
	[ "$status" -eq 0 ]
}

@test "port 1001/tcp was removed from runtime config" {
	run firewall-cmd --query-port=1001/tcp
	[ "$status" -eq 1 ]
}

@test "port 1001/tcp was removed from permanent config" {
	run firewall-cmd --permanent --query-port=1001/tcp
	[ "$status" -eq 1 ]
}

@test "port 1002/tcp was not removed from runtime config" {
	run firewall-cmd --query-port=1002/tcp
	[ "$status" -eq 0 ]
}

@test "port 1002/tcp was not removed from permanent config" {
	run firewall-cmd --permanent --query-port=1002/tcp
	[ "$status" -eq 0 ]
}
