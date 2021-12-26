@employees = ();

sub new_employee { 
    my ($name, $surname, $age, $position, $salary) = @_; 

    my %employee = ( 
        "name" => $name, 
        "surname" => $surname, 
        "age" => $age, 
        "position" => $position,
        "salary" => $salary
    ); 

    return \%employee; # return a reference to a local object can return an object like this $employee 
}

my $counter = 0;
# skip first two lines
while(my $line = <>) { 
    if ($counter == 1) {
        last;
    }
    $counter++;
}

$avg_age = 0;
$avg_salary = 0;

my @lines = ();
while(my $line = <>) { 
    push @lines, $line;
}

#while(my $line = <>) { 
foreach $line (@lines[0..$#lines-1]) {
    $line = lc $line;
    $line =~ s/([\w']+)/\u\L$1/g;
    $line =~ s/\n//;
    my @splitline = split(',', $line, -1);
    
    # gotta skip bad lines
    $length = scalar @splitline;
    if ($length < 6) {
        next;
    }
    
    my $name = $splitline[0];
    my $surname = $splitline[1];
    my $age = $splitline[2];
    my $pos = $splitline[4];
    my $salary = $splitline[5];

    $avg_age += $age;
    $avg_salary += $salary;

    my $emp1 = new_employee($name, $surname, $age, $pos, $salary); 
    push @employees, $emp1;
}

# print
my $c2 = 1;
foreach my $empl (sort { $a->{'salary'} <=> $b->{'salary'} } @employees) {
    printf "%4d | %-16s | %-3s | %-24s | %-9s\n", $c2++,"$empl->{'surname'} $empl->{'name'}", "$empl->{'age'}", "$empl->{'position'}", "$empl->{'salary'}";
}

# print averages
my $ce = scalar @employees;
if ($ce == 0) {
    print "awk: cmd. line:1: fatal: division by zero attempted\n";
} else {
    printf "\nAvg age: %d\nAvg salary: %d\n",$avg_age/$ce,$avg_salary/$ce;
}