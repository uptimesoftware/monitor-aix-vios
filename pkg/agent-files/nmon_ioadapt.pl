#!/usr/bin/perl 

while(<>){
	chomp;
	split(/,/);
	if($_[0] =~ /IOADAPT/){
		if($_[1] =~ /T0001/){
			@stats = splice(@_,2);
		} else {
			@descript = splice(@_,2);
		}
	} elsif($_[0] =~ /ZZZZ/) {
		($time,$date) = (@_)[2,3];
	} else {
		die "There is a problem with the expected data and its format";
	}
	$validate{"$_[0]"}+=1;
}

if(($validate{"IOADAPT"}!=2) || ($validate{"ZZZZ"}!=1)){
	die "Not all expected data is available";
}

my %values;

foreach(@descript){
	#Rearrange the descript
	#from something like fcs7_write-KB/s
	#to fcs7.write-KB etc
	@descript_split = split("_", $_);
	$instance = @descript_split[0];
	$metric = @descript_split[1];
	#chop off the '/s' from the metric if needed
	if (index($metric, '/s') >= 1)
	{
		$metric = substr($metric , 0, -2);
	}
	


	$uptime_metric = join('.', $instance, $metric);

	$stat=pop(@stats);
	$values{$instance}{$metric} = $stat;
	push(@filtered,join(" ",$uptime_metric,$stat));
}

#loop through the values and caculate Average Block size
# (writeKB + readKB ) * 8 / xfer-tps = Average Block size in kb
foreach my $key1 (sort keys %values)
{
	$writeKB =  $values{$key1}->{"write-KB"};
	$readKB = $values{$key1}->{"read-KB"};
	$tps = $values{$key1}->{"xfer-tps"};

	$blocksize = ( ($writeKB + $readKB ) * 8 )  / $tps;
	$values{$key1}{"Block-Size"} = $blocksize;
}


#Print the final output in ranged data friendly format for uptime
#ie. fcs0.Block-Size 1
foreach my $key1 (sort keys %values)
{
	foreach my $key2 (sort keys %{$values{$key1}})
	{
		printf ("%s.%s %.1f \n" , $key1, $key2,  $values{$key1}->{$key2} );
	}
}