#!/usr/bin/env bats

@test "interface eth0 was added to permanent config" {
	run firewall-cmd --permanent --query-interface=eth0
	[ "$status" -eq 0 ]
}

@test "interface eth0 was added to runtime config" {
	run firewall-cmd --query-interface=eth0
	[ "$status" -eq 0 ]
}

@test "interface eth1 was removed from permanent config" {
	run firewall-cmd --permanent --query-interface=eth1
	[ "$status" -eq 1 ]
}

@test "interface eth1 was removed from runtime config" {
	run firewall-cmd --query-interface=eth1
	[ "$status" -eq 1 ]
}

@test "interface eth2 was not removed from permanent config" {
	run firewall-cmd --permanent --query-interface=eth2
	[ "$status" -eq 0 ]
}

@test "interface eth2 was not removed from runtime config" {
	run firewall-cmd --query-interface=eth2
	[ "$status" -eq 0 ]
}

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

@test "service http was added to permanent config" {
	run firewall-cmd --permanent --query-service=http
	[ "$status" -eq 0 ]
}

@test "service http was added to runtime config" {
	run firewall-cmd --query-service=http
	[ "$status" -eq 0 ]
}

@test "service telnet was removed from runtime config" {
	run firewall-cmd --query-service=telnet
	[ "$status" -eq 1 ]
}

@test "service telnet was removed from permanent config" {
	run firewall-cmd --permanent --query-service=telnet
	[ "$status" -eq 1 ]
}

@test "source 192.168.0.0/24 was added to permanent config" {
	run firewall-cmd --permanent --query-source=192.168.0.0/24
	[ "$status" -eq 0 ]
}

@test "source 192.168.0.0/24 was added to runtime config" {
	run firewall-cmd --query-source=192.168.0.0/24
	[ "$status" -eq 0 ]
}

@test "source 192.168.1.0/24 was removed from permanent config" {
	run firewall-cmd --permanent --query-source=192.168.1.0/24
	[ "$status" -eq 1 ]
}

@test "source 192.168.1.0/24 was removed from runtime config" {
	run firewall-cmd --query-source=192.168.1.0/24
	[ "$status" -eq 1 ]
}

@test "source 192.168.2.0/24 was not removed from permanent config" {
	run firewall-cmd --permanent --query-source=192.168.2.0/24
	[ "$status" -eq 0 ]
}

@test "source 192.168.2.0/24 was not removed from runtime config" {
	run firewall-cmd --query-source=192.168.2.0/24
	[ "$status" -eq 0 ]
}

@test "zone zone1 was added to permanent config" {
	run firewall-cmd --permanent --zone=zone1 --get-target
	[ "$status" -eq 0 ]
}

@test "zone zone1 was added to runtime config" {
	run firewall-cmd --zone=zone1 --list-all
	[ "$status" -eq 0 ]
}

@test "zone zone2 was removed from permanent config" {
	run firewall-cmd --permanent --zone=zone2 --get-target
	[ "$status" -eq 112 ]
}

@test "zone zone2 was removed from runtime config" {
	run firewall-cmd --zone=zone2 --list-all
	[ "$status" -eq 112 ]
}

@test "zone zone3 was not removed from permanent config" {
	run firewall-cmd --permanent --zone=zone3 --get-target
	[ "$status" -eq 0 ]
}

@test "zone zone3 was not removed from runtime config" {
	run firewall-cmd --zone=zone3 --list-all
	[ "$status" -eq 0 ]
}

@test 'masquerade was added to public zone for runtime config' {
	run firewall-cmd --zone=public --add-masquerade
	[ "$status" -eq 0 ]
}

@test 'masquerade was added to public zone for permanent config' {
	run firewall-cmd --permanent --zone=public --add-masquerade
	[ "$status" -eq 0 ]
}

@test 'masquerade was removed from public zone for runtime config' {
	run firewall-cmd --zone=public --remove-masquerade
	[ "$status" -eq 0 ]
}

@test 'masquerade was removed from public zone for permanent config' {
	run firewall-cmd --permanent --zone=public --remove-masquerade
	[ "$status" -eq 0 ]
}
