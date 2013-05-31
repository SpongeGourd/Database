#! usr/bin/perl -w
##by lina 2013.5.31
## This program is to transform the BLAT result read into information needed for Database.
use Bio::SeqIO;
use strict;

my $input = shift @ARGV;
my $output = shift @ARGV;

my $in = Bio::SeqIO ->new (-file => $input, -format => "Fasta");
open OUT, ">$output";



while (my $seq =$in ->next_seq() ){

##eg. $content1 = 4472739.3|SRR061299.11398118|GenBank|ADB81539.1
##    $content2 = gp43 DNA polymerase [Enterobacteria phage CC31]
  my $content1 = $seq ->display_name;
	my $content2 = $seq ->desc;
	my $content = $content1." ".$content2;
##    $content  = 4472739.3|SRR061299.11398118|GenBank|ADB81539.1 gp43 DNA polymerase [Enterobacteria phage CC31]

	$content =~ s/ \[/\|/g;
	$content =~ s/\]//g;


	my @column=split /\|/, $content;
	my $sample_id = $column[0];
	my $read_id = $column[1];
	my $hit_protein = $column[3];
	my $hit_species = $column[4];
	
	print OUT $sample_id."\t".$read_id."\t".$hit_protein."\t".$hit_species."\n";
}
