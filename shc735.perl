#!/usr/bin/perl

use strict;
use warnings;
use Device::SerialPort;
use Getopt::Std;

my $target='01';
getopt('c:');
our($opt_c); my $cmd = $opt_c;

if (!defined $cmd) { print "Usage: shc735 -c <up|down|right|left|menu|zoom{0,1}|iris{0,1}|focus{0,1}>\n\n"; exit -1; }

#my $serial=Device::SerialPort->new("/dev/ttyUSB0");
my $serial=Device::SerialPort->new("/dev/tty.usbserial-A501AMLN");
$serial->databits("8");
$serial->baudrate("9600");
$serial->parity("none");
$serial->stopbits(1);

print "target is $target\n";

if ($opt_c =~ /menu/) { print "command is menu\n";        &send($target, '00', '03', '00', '5f', '63'); }
elsif ($opt_c =~ /up/) { print "command is up\n";         &send($target, '00', '08', '00', '20', '29'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /down/) { print "command is down\n";     &send($target, '00', '10', '00', '20', '31'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /right/) { print "command is right\n";   &send($target, '00', '02', '20', '00', '23'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /left/) { print "command is left\n";     &send($target, '00', '04', '20', '00', '25'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /zoom0/) { print "command is zoom0\n";   &send($target, '00', '40', '00', '00', '41'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /zoom1/) { print "command is zoom1\n";   &send($target, '00', '20', '00', '00', '21'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /iris0/) { print "command is iris0\n";   &send($target, '04', '00', '00', '00', '05'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /iris1/) { print "command is iris1\n";   &send($target, '02', '00', '00', '00', '03'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /focus0/) { print "command is focus0\n"; &send($target, '00', '80', '00', '00', '81'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
elsif ($opt_c =~ /focus1/) { print "command is focus1\n"; &send($target, '01', '00', '00', '00', '02'); sleep 1 ; &send($target, '00', '00', '00', '00', '00'); }
else { print "unknown command\n"; exit -1; }
                                                                                                                                                                        
sleep 1;                                                                                                                                                                           
$serial->close;                                                                                                                                                                    
                                                                                                                                                                                                                                                                           
sub send {                                                                                                                                                                         

   my($adr,$cmd1,$cmd2,$dat1,$dat2,$sum)=@_;
   print "* sending ff $adr $cmd1 $cmd2 $dat1 $dat2 $sum\n";
   $serial->write(pack ('H2' x 7, 'ff', $adr, $cmd1, $cmd2, $dat1, $dat2, $sum));

}
