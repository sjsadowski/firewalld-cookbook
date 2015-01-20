#!/usr/bin/env bats

rule1='rule family="ipv4" source address="192.168.100.0/24" service name="ssh" log prefix="ssh" level="info" limit value="1/m" accept'
rule2='rule family="ipv4" source address="192.168.200.0/24" service name="ssh" log prefix="ssh" level="info" limit value="1/m" accept'
rule3='rule family="ipv4" source address="192.168.254.0/24" service name="ssh" log prefix="ssh" level="info" limit value="1/m" accept'

@test "rule 1 was added to permanent config" {
        run bash -c "firewall-cmd --permanent --query-rich-rule='${rule1}'"
        [ "$status" -eq 0 ]
}

@test "rule 1 was added to runtime config" {
        run bash -c "firewall-cmd --query-rich-rule='${rule1}'"
        [ "$status" -eq 0 ]
}

@test "rule 3 was removed from runtime config" {
        run bash -c "firewall-cmd --query-rich-rule='${rule3}'"
        [ "$status" -eq 1 ]
}

@test "rule 3 was removed from permanent config" {
        run bash -c "firewall-cmd --permanent --query-rich-rule='${rule3}'"
        [ "$status" -eq 1 ]
}

@test "rule 2 was not removed from runtime config" {
        run bash -c "firewall-cmd --query-rich-rule='${rule2}'"
        [ "$status" -eq 0 ]
}

@test "rule 2 was not removed from permanent config" {
        run bash -c "firewall-cmd --permanent --query-rich-rule='${rule2}'"
        [ "$status" -eq 0 ]
}
