#!/usr/bin/perl

@strings = ();
%thirds = ();
my $counter = 0;
while(my $line = <>) { 
  if ($line =~ /\n$/) {
    } else {
      $line = "$line\n";  
    }
    my @splitline = split(' ', $line);
    my $third = $splitline[2];
  if ($third eq "") {
        print "$line";
  } else {
        my @tarr = ();
        if (exists $thirds{$third}) {
            push @tarr, @{$thirds{$third}};
        }
        push @tarr, $counter;
        $thirds{"$third"} = \@tarr;
  }
    push @strings, $line;
    $counter++;    
}

foreach my $key (sort keys %thirds) {
    my @val = @{$thirds{"$key"}};
    foreach my $n (@val) {
        my $strr = $strings[$n];
      print "$strr";
    }
}