use Getopt::Long;
use warnings;
use feature qw(say);
my $filename = 'report.txt';

my $g_opt_print= "";
my $inputs ="" ;
my $outputs ="";
my $logic ="";
GetOptions ("p=s"        => \$g_opt_print);
my $out = "";
my $banana = 'data.txt';
open(my $h, '<:encoding(UTF-8)', $banana)
  or die "Could not open file '$filename' $!";
 
while (my $row = <$h>) {
    chomp $row;
    my @string_as_array = split( '', $row );
    my $first_index =0 ;
    my $secound_index=0 ;
    for (my $i = 0; $i<@string_as_array; $i++){
        if ($string_as_array[$i] eq '('){
            $first_index = $i;
        }
        elsif ($string_as_array[$i] eq ')'){
            $secound_index = $i;
        }
    }
    $g_opt_print = join( '', @string_as_array[0..$first_index] );
    $g_opt_print .=')';
    $inputs = join('', @string_as_array[$first_index+1..$secound_index-1]);
    $outputs = join('', @string_as_array[$secound_index+2..(@string_as_array-1)]);
    if ($inputs eq ""){
        $inputs = "n/a";
    }
    if ($outputs eq ""){
        $outputs = "void";
    }
   
  say $row;
  makecomment();
   $out .= "\n\n";

}
sub makecomment{
say "Comments for:$g_opt_print";
say "Inputs: $inputs";
say "Outputs: $outputs";
say "Logic Summary:";
$logic  = <STDIN>;
$out .=  "/*\n \*";
$out .= "\n \*    $g_opt_print:\n";
$out .=  " \*    Inputs:\n";
$out .= " \*    $inputs\n";
$out .= " \*    Outputs:\n";
$out .=  " \*    $outputs\n";
$out .=  " \*    Logic Summary:\n";
$out .=  " \*    $logic";
$out .=  " \*/\n";
$out =~ s/pip/\n \*    /g;
}

open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh $out;
close $fh;
