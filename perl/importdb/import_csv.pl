#!/opt/local/bin/perl

#use strict;
#use warning;

# load module
use DBI;
# DBconnect
my $driver = "mysql";
my $database = "mollusk_breed";
my $dsn = "DBI:$driver:database=$database";
my $userid = "root";
my $password = "wubin";
my $dbh = DBI->connect($dsn, $userid, $password) or die $DBI::errstr;

#filepath
my $path="/Users/wubin/Sites/mollus/Public/UploadsGBlup/";
#my $iname="gblupev.csv";
#my $outname="dataout.txt";
my $filename=$ARGV[0];
my $sheetname=$ARGV[1];

#TimeSet
my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time());
my $time=sprintf("%d:%d:%d %d:%d:%d",$year+1900,$mon+1,$mday,$hour,$min,$sec);

#Openfile
open IN, "<$path"."$filename" or die "Can't open file:$!";
#open OUT, ">$path"."$outname";
my $i=0;
my @rawdata=<IN>;
my $number=@rawdata;
print $number;
close IN;
my @data;
#清空数据表
my $clean = $dbh -> do("TRUNCATE TABLE $sheetname");
for ($i=1;$i<$number;$i++){
    $rawdata[$i]=~ s/(")//g;
    #print $rawdata[$i];
    @data = split(/\,/, $rawdata[$i]);
    my $a=$data[0];
    my $b=$data[1];
    # execute INSERT query
    #insert to mysql
    my $sth = $dbh->do("INSERT INTO $sheetname (number, value ) values ('$a', '$b')");

    
    #print $data[0]."\n";
}
#main
#foreach(<IN>){
#    my $rawdata = $_;
#    @data = split(/\s/, $rawdata);
#    $i++;
#    my $dd=$data[1];
#    # execute INSERT query
#   #insert to mysql
#   my $sth = $dbh->do("INSERT INTO website (url, dtime, keywords, filename ) values ('$dd', '$time', '', '')");
    #print "$sth row(s) affected"."\n";
    #$sth->execute() or die $DBI::errstr;
    #$sth->finish();
    #$dbh->commit or die $DBI::errstr;
    
    #print OUT $data[1]."\n";
    
    
#}
#print "$i row(s) affected"."\n";
#close OUT;
# clean up
$dbh->disconnect();


