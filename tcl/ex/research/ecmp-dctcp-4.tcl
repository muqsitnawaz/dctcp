# sourcing template
source template.tcl

# defining link properties
set edge_link 100.0Mb
set agg_link 100.0Mb
set core_link 100.0Mb

set edge_delay 0.025ms
set agg_delay  0.025ms
set core_delay 0.025ms

set num_hosts 16
set num_nodes 36

# creating nodes
for { set i 0 } { $i <= $num_nodes } { incr i } {
    set n($i) [$ns node]
}

# creating links
$ns duplex-link $n(0) $n(16) $edge_link $edge_delay DropTail
$ns duplex-link $n(1) $n(16) $edge_link $edge_delay DropTail
$ns duplex-link $n(2) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(3) $n(17) $edge_link $edge_delay DropTail
$ns duplex-link $n(4) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(5) $n(18) $edge_link $edge_delay DropTail
$ns duplex-link $n(6) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(7) $n(19) $edge_link $edge_delay DropTail
$ns duplex-link $n(8) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(9) $n(20) $edge_link $edge_delay DropTail
$ns duplex-link $n(10) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(11) $n(21) $edge_link $edge_delay DropTail
$ns duplex-link $n(12) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(13) $n(22) $edge_link $edge_delay DropTail
$ns duplex-link $n(14) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(15) $n(23) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(24) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(25) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(26) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(27) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(28) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(29) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(31) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(30) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(31) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(35) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(32) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(33) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(34) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(35) $edge_link $edge_delay DropTail

# creating link arrays
array set links1 { 0 0 1 16 2 1 3 16 4 2 5 17 6 3 7 17 8 4 9 18 10 5 11 18 12 6 13 19 14 7 15 19 16 8 17 20 18 9 19 20 20 10 21 21 22 11 23 21 24 12 25 22 26 13 27 22 28 14 29 23 30 15 31 23 32 16 33 24 34 16 35 25 36 17 37 24 38 17 39 25 40 18 41 26 42 18 43 27 44 19 45 26 46 19 47 27 48 20 49 28 50 20 51 29 52 21 53 28 54 21 55 29 56 22 57 30 58 22 59 31 60 23 61 30 62 23 63 31 64 24 65 32 66 24 67 33 68 25 69 34 70 25 71 35 72 26 73 32 74 26 75 33 76 27 77 34 78 27 79 35 80 28 81 32 82 28 83 33 84 29 85 34 86 29 87 35 88 30 89 32 90 30 91 33 92 31 93 34 94 31 95 35}
array set links2 { 0 16 1 0 2 16 3 1 4 17 5 2 6 17 7 3 8 18 9 4 10 18 11 5 12 19 13 6 14 19 15 7 16 20 17 8 18 20 19 9 20 21 21 10 22 21 23 11 24 22 25 12 26 22 27 13 28 23 29 14 30 23 31 15 32 24 33 16 34 25 35 16 36 24 37 17 38 25 39 17 40 26 41 18 42 27 43 18 44 26 45 19 46 27 47 19 48 28 49 20 50 29 51 20 52 28 53 21 54 29 55 21 56 30 57 22 58 31 59 22 60 30 61 23 62 31 63 23 64 32 65 24 66 33 67 24 68 34 69 25 70 35 71 25 72 32 73 26 74 33 75 26 76 34 77 27 78 35 79 27 80 32 81 28 82 33 83 28 84 34 85 29 86 35 87 29 88 32 89 30 90 33 91 30 92 34 93 31 94 35 95 31}
set lnk_size [array size links1]

# monitoring links
for { set i 0 } { $i < [expr $lnk_size] } { incr i } {
	set qmon_ab($i) [$ns monitor-queue $n($links1($i)) $n($links2($i)) ""]
	set bing_ab($i) [$qmon_ab($i) get-bytes-integrator];
	set ping_ab($i) [$qmon_ab($i) get-pkts-integrator];
	set fileq($i) "qmon.trace"
	set futil_name($i) "qmon.util"
	
    append fileq($i) "$links1($i)"
	append fileq($i) "$links2($i)"
	append futil_name($i) "$links1($i)"
	append futil_name($i) "$links2($i)"
	
    set fq_mon($i) [open $fileq($i) w]
	set f_util($i) [open $futil_name($i) w]


    $ns at $STATS_START  "$qmon_ab($i) reset"
	$ns at $STATS_START  "$bing_ab($i) reset"
	$ns at $STATS_START  "$ping_ab($i) reset"
	set buf_bytes [expr 0.00025 * 1000 / 1 ]
    $ns at [expr $STATS_START+$STATS_INTR] "linkDump [$ns link $n($links1($i)) $n($links2($i))] $bing_ab($i) $ping_ab($i) $qmon_ab($i) $STATS_INTR A-B $fq_mon($i) $f_util($i) $buf_bytes"
}

# DCTCP initializations
set K 65

set sourceAlg DC-TCP-Sack
set switchAlg RED

set DCTCP_g_ 0.0625
set ackRatio 1
set packetSize 1460
 
set traceSamplingInterval 0.0001
set throughputSamplingInterval 0.01
set enableNAM 0

Agent/TCP set ecn_ 1
Agent/TCP set old_ecn_ 1
Agent/TCP/FullTcp set segsize_ $packetSize
Agent/TCP set slow_start_restart_ false
Agent/TCP set tcpTick_ 0.01
Agent/TCP set minrto_ 0.2 ; # minRTO = 200ms
Agent/TCP set windowOption_ 0

if {[string compare $sourceAlg "DC-TCP-Sack"] == 0} {
    Agent/TCP set dctcp_ true
    Agent/TCP set dctcp_g_ $DCTCP_g_;
}
Agent/TCP/FullTcp set segsperack_ $ackRatio; 
Agent/TCP/FullTcp set spa_thresh_ 3000;
Agent/TCP/FullTcp set interval_ 0.04 ; #delayed ACK interval = 40ms

Queue set limit_ 1000

Queue/RED set bytes_ false
Queue/RED set queue_in_bytes_ true
Queue/RED set mean_pktsize_ $packetSize
Queue/RED set setbit_ true
Queue/RED set gentle_ false
Queue/RED set q_weight_ 1.0
Queue/RED set mark_p_ 1.0
Queue/RED set thresh_ [expr $K]
Queue/RED set maxthresh_ [expr $K]
			 
DelayLink set avoidReordering_ true


# now generate flows and tests
set tcp0 [build-tcp $n(0) $n(8) 0.1]
set tcp1 [build-tcp $n(1) $n(9) 0.12]
set tcp2 [build-tcp $n(2) $n(10) 0.13]
set tcp3 [build-tcp $n(3) $n(11) 0.14]

set tcp4 [build-tcp $n(4) $n(12) 0.15]
set tcp5 [build-tcp $n(5) $n(13) 0.1]
set tcp6 [build-tcp $n(6) $n(14) 0.17]
set tcp7 [build-tcp $n(7) $n(15) 0.1]

# exiting ns
$ns at 0.35 "finish"

puts "running ns"
$ns run