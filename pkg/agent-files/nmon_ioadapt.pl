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


foreach(@descript){
	#Rearrange the descript
	#from something like fcs7_write-KB/s
	#to fcs7.write-KB etc
	$descript_split = split(/_/, $_);
	$instance = $descript_split[0];
	$metric = $descript_split[1];
	#chop off the '/s' from the metric if needed
	if (index($metric, '/s') == 1)
	{
		$metric = substr($metric , 0, -2);
	}
	

	$uptime_metric = join('.', $instance, $metric);

	$stat=pop(@stats);
	push(@filtered,join(" ",$uptime_metric,$stat));
}
print join("\n",@filtered), "\n";
