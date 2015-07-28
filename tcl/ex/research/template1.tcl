set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Yellow

Node set multiPath_ 1
Classifier/MultiPath set perflow_ 1
Classifier/MultiPath set checkpathid_ 1

set STATS_START 0
set STATS_INTR 0.08
set interval 0.08

proc printFlow {f outfile fm interval} {
    global ns 
    #puts $outfile [format "FID: %d pckarv: %d bytarv: %d pckdrp: %d bytdrp: %d rate: %.0f drprt: %.3f" [$f set flowid_] [$f set parrivals_] [$f set barrivals_] [$f set pdrops_] [$f set bdrops_] [expr [$f set barrivals_]*8/($interval*1000.)] [expr [$f set pdrops_]/double([$f set parrivals_])] ]

    # flow_id, rate and drprt,
    #puts $outfile [format "%d %.0f  %.3f" [$f set flowid_] [expr [$f set barrivals_]*8/($interval*1000000.)] [expr [$f set pdrops_]/double([$f set parrivals_])] ]
    puts $outfile [format "%d %.6f " [$f set flowid_] [expr [$f set barrivals_]*8/($interval*1000000.)] ]

    if 0 {
        set flow(0) [open "flow0" a]
        set flow(1) [open "flow1" a]
        set flow(2) [open "flow2" a]
        set flow(3) [open "flow3" a]
        set flow(4) [open "flow4" a]
        set flow(5) [open "flow5" a]
        set flow(6) [open "flow6" a]
        set flow(7) [open "flow7" a]
        set flow(8) [open "flow8" a]
        set flow(9) [open "flow9" a]
        set flow(40) [open "flow40" a]
        set flow(41) [open "flow41" a]
        set flow(42) [open "flow42" a]
        set flow(43) [open "flow43" a]
    }

    if 0 {
        if { [$f set flowid_] == 0 } {
            puts $flow(0) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 1 } {
            puts $flow(1) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 2 } {
            puts $flow(2) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 3 } {
            puts $flow(3) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 4 } {
            puts $flow(4) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 5 } {
            puts $flow(5) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 6 } {
            puts $flow(6) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 7 } {
            puts $flow(7) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 8 } {
            puts $flow(8) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 9 } {
            puts $flow(9) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 40 } {
            puts $flow(40) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 41 } {
            puts $flow(41) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 42 } {
            puts $flow(42) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
        if { [$f set flowid_] == 43 } {
            puts $flow(43) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
        }
    }

    if 0 {
        close $flow(0)
        close $flow(1)
        close $flow(2)
        close $flow(3)
        close $flow(4)
        close $flow(5)
        close $flow(6)
        close $flow(7)
        close $flow(8)
        close $flow(9)
        close $flow(40)
        close $flow(41)
        close $flow(42)
        close $flow(43)
    }
}

proc flowDump {link fm file_p interval} {
    global ns
    

    $ns at [expr [$ns now] + $interval]  "flowDump $link $fm $file_p $interval"
    puts $file_p [format "Time: %.4f" [$ns now]]
    set theflows [$fm flows]
    if {[llength $theflows] == 0} {
        return
        } else {
           set total_arr [expr double([$fm set barrivals_])]
         if {$total_arr > 0} {
               foreach f $theflows {
                   set arr [expr [expr double([$f set barrivals_])] / $total_arr]
                   if {$arr >= 0.0001} {
                    printFlow $f $file_p $fm $interval
                }
                $f reset
            }
            $fm reset
        }
    }
}


proc linkDump {link binteg pinteg qmon interval name linkfile util buf_bytes} {
    global ns
    set now_time [$ns now]
    $ns at [expr $now_time + $interval] "linkDump $link $binteg $pinteg $qmon $interval $name $linkfile $util $buf_bytes"
    set bandw [[$link link] set bandwidth_]
    set queue_bd [$binteg set sum_]
    set abd_queue [expr $queue_bd/[expr 1.*$interval]]
    set queue_pd [$pinteg set sum_]
    set apd_queue [expr $queue_pd/[expr 1.*$interval]]
    set utilz [expr 8*[$qmon set bdepartures_]/[expr 1.*$interval*$bandw]]
    if {[$qmon set parrivals_] != 0} {
        set drprt [expr [$qmon set pdrops_]/[expr 1.*[$qmon set parrivals_]]]
        } else {
            set drprt 0
        }
        if {$utilz != 0} {;
        set a_delay [expr ($abd_queue*8*1000)/($utilz*$bandw)]
        } else {
            set a_delay 0.
        }
        puts $linkfile [format "Time interval: %.6f-%.6f" [expr [$ns now] - $interval] [$ns now]]
        puts $linkfile [format "Link %s: Utiliz=%.3f LossRate=%.3f AvgDelay=%.1fms AvgQueue(P)=%.0f AvgQueue(B)=%.0f" $name $utilz $drprt $a_delay $apd_queue $abd_queue]
        set av_qsize [expr [expr $abd_queue * 100] / $buf_bytes]
        set utilz [expr $utilz * 100]
        set drprt [expr $drprt * 100]
        set buf_pkts [expr $buf_bytes / 1000]
        puts $util [format "%.6f   %.6f" [$ns now] $utilz]
        $binteg reset
        $pinteg reset
        $qmon reset
}

# opening output files
set nf [open out.nam w]
$ns namtrace-all $nf

# defining finish procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exit 0
}

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
for { set i 0 } { $i < $num_nodes } { incr i } {
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

#Setup a TCP connection
set tcp [new Agent/TCP]
$ns attach-agent $n(0) $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n(1) $sink
$ns connect $tcp $sink

# ftp application
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

set starts 1
$ns at $starts "$ftp start"

#Call the finish procedure after 5 seconds of simulation time
$ns at 3.0 "finish"

#Run the simulation
$ns run